package main

import (
	"encoding/json"
	"fmt"
	"io"
	"log/slog"
	"net/http"
	"time"

	"github.com/labiraus/prove-it/apps/pkg/api"
	"github.com/labiraus/prove-it/apps/pkg/base"
	"github.com/labiraus/prove-it/apps/pkg/kubernetesutil"
	"github.com/labiraus/prove-it/apps/pkg/prometheusutil"

	"github.com/patrickmn/go-cache"
)

const (
	helloHandlerLabel = "helloHandler"
)

var (
	c          = cache.New(5*time.Minute, 10*time.Minute)
	kubeAccess = false
)

func main() {
	var err error
	ctx := base.Init("basicapi")
	defer func() {
		p := recover()
		if p != nil {
			err = fmt.Errorf("panic: %v", p)
		}
		if err != nil {
			slog.ErrorContext(ctx, err.Error())
		}
	}()

	mux := http.NewServeMux()
	prometheusutil.Init(mux)
	mux.HandleFunc("/hello", helloHandler)

	done := api.Init(ctx, mux)

	kubeAccess, err = kubernetesutil.Init()
	if err != nil {
		return
	}
	if !kubeAccess {
		slog.InfoContext(ctx, "kubernetes access not available")
	}
	close(base.Ready)
	<-done
	slog.InfoContext(ctx, "finishing")
}

func helloHandler(w http.ResponseWriter, r *http.Request) {
	var err error
	startTime := time.Now() // Capture the start time
	prometheusutil.IncrementProcessed(helloHandlerLabel, "call")
	defer func() {
		p := recover()
		if p != nil {
			err = fmt.Errorf("panic: %v", p)
		}
		if err != nil {
			slog.ErrorContext(r.Context(), err.Error())
			prometheusutil.IncrementProcessed(helloHandlerLabel, "error")
		}
		prometheusutil.OpDuration(helloHandlerLabel, time.Since(startTime))
	}()

	slog.InfoContext(r.Context(), helloHandlerLabel+"called")

	var request = UserRequest{}
	body, err := io.ReadAll(r.Body)
	if err != nil {
		w.WriteHeader(http.StatusBadRequest)
		return
	}

	err = json.Unmarshal(body, &request)
	if err != nil {
		w.WriteHeader(http.StatusBadRequest)
		return
	}

	if request.UserID == 0 {
		request.UserID = 1
	}

	secretValue, ok := c.Get("secretValue")
	if !ok {
		slog.DebugContext(r.Context(), "reloading secret configValue")
		if !kubeAccess {
			secretValue = "no secret"
		} else {
			secretValue = base.GetEnv("SECRETVALUE", "no secret")
		}
		c.Set("secretValue", secretValue, cache.DefaultExpiration)
	}

	response := UserResponse{
		UserID:   request.UserID,
		Username: secretValue.(string),
		Email:    "something@somewhere.com",
	}

	data, err := json.Marshal(response)
	if err != nil {
		w.WriteHeader(http.StatusInternalServerError)
		return
	}

	_, err = w.Write(data)
	if err != nil {
		w.WriteHeader(http.StatusInternalServerError)
		return
	}
}
