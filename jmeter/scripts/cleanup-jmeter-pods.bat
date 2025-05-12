@echo off
rem Set the Kubernetes namespace
set NAMESPACE=benchmarking-goapi

echo Deleting pods starting with "jmeter"...

rem Use a temporary file to store the output of kubectl get pods
set TEMP_FILE=%TEMP%\pod-list.txt

rem Get the list of pods and store them in the temporary file
kubectl get pods --no-headers -o custom-columns=":metadata.name" -n %NAMESPACE% > %TEMP_FILE%

rem Loop through each line in the temporary file and delete pods starting with "jmeter"
for /f "usebackq tokens=*" %%i in (`type "%TEMP_FILE%" ^| findstr /i "jmeter"`) do (
				echo Deleting pod %%i
    kubectl delete pod %%i -n %NAMESPACE%
)

rem Delete the temporary file
del %TEMP_FILE%

echo Pods deleted.
