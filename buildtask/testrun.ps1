[CmdletBinding()]
param($TestResultPath,$OutputFolder,$JsonMapping,$InputType)


    # Get the inputs.
    $testResultPath = "target/surefire-reports"
	$outputFolder = "target"
    $jsonMapping = $JsonMapping  
    $inputType = "file"
    if($inputType -eq "file"){
              $jsonMapping = "TestJson"
              Write-host "Using file $jsonMapping for JSON mapping"
    }
    else
    {
        Write-host "-----------------------"
        Write-host "Json test mapping"
        Write-host "-----------------------"
        Write-host `"$jsonMapping`"
    }

    $vsoAccountName = (Get-VstsTaskVariableInfo | Where-Object { $_.Name -eq "system.taskDefinitionsUri"}).Value
    $projectName = (Get-VstsTaskVariableInfo | Where-Object { $_.Name -eq "build.Repository.name"}).Value

    Write-host "-----------------------"
    Write-host "Config"
    Write-host "-----------------------"
    Write-host "Tests path= $testResultPath"
    Write-host "Project name (var)= $projectName"
    Write-host "Visual Studio Account name (var)= $vsoAccountName"
    Write-host "Output folder= $outputFolder"

    #Set the working directory.
    $cwd = "bin"
    Write-host "Setting working directory to '$cwd'."
    Set-Location $cwd

    Write-host "Creation of dynamic .NET DLL using ROSLYN..."
    Write-host "-------------------------------------------------"
	#$filereader=$(System.DefaultWorkingDirectory);
    $proc = Start-Process  -FilePath "./UnitTestGenerator/Microsoft.DX.JavaTestBridge.UnitTestGenerator.exe" -ArgumentList "AutomatedTestAssembly `"$jsonMapping`" $testResultPath" 
    $handle = $proc.Handle # cache proc.Handle
	

	Write-host "Test" $proc.ExitCode
    

        Write-host ".NET Unit test assembly created (AutomatedTestAssembly.dll)"
        
        Write-host "Association of tests with VSTS..."
        Write-host "-------------------------------------------------"

        Start-Process -FilePath "./VSTS/Microsoft.DX.JavaTestBridge.VSTS.exe" -ArgumentList "$vsoAccountName $projectName AutomatedTestAssembly.dll $username $password" 
       
          Write-host "Association completed successfully"
         
          #required DLL to run
          Move-Item .\AutomatedTestAssembly.dll $outputFolder -Force
          Copy-Item .\UnitTestGenerator\Newtonsoft.Json.dll $outputFolder -Force
          Copy-Item .\VSTS\Microsoft.DX.JavaTestBridge.Common.dll $outputFolder -Force

          Write-host "Files copied to $outputFolder"
       
    
    

   