@echo off
rem Set the Kubernetes namespace
set NAMESPACE=benchmarking-goapi

echo Deleting jobs starting with "jmeter"...

rem Use a temporary file to store the output of kubectl get jobs
set TEMP_FILE=%TEMP%\job-list.txt

rem Get the list of jobs and store them in the temporary file
kubectl get jobs --no-headers -o custom-columns=":metadata.name" -n %NAMESPACE% > %TEMP_FILE%

rem Loop through each line in the temporary file and delete jobs starting with "jmeter"
for /f "usebackq tokens=*" %%i in (`type "%TEMP_FILE%" ^| findstr /i "jmeter"`) do (
				echo Deleting job %%i
    kubectl delete job %%i -n %NAMESPACE%
)

rem Delete the temporary file
del %TEMP_FILE%

echo Jobs deleted.
