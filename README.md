# CucumberAzure
CucumberAzure

-dllpath "$(System.DefaultWorkingDirectory)\buildtask\ps_modules\VstsTaskSdk" -jsonpath "$(System.DefaultWorkingDirectory)\buildtask\Test.json" -vsaccount "https://dev.azure.com/797041/" -project "Cucumber"
$(System.DefaultWorkingDirectory)\buildtask\run.ps1
