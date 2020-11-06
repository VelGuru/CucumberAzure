[CmdletBinding()]
param($TestResultPath,$OutputFolder,$JsonMapping,$InputType)


    # Get the inputs.
    $testResultPath = $TestResultPath
	$outputFolder = $OutputFolder
    $jsonMapping = $JsonMapping  
    $inputType = $InputType
    if($inputType -eq "file"){
              $jsonMapping = "gnanavel"
              Write-host "Using file $jsonMapping for JSON mapping"
    }
    else
    {
        Write-host "-----------------------"
        Write-host "Json test mapping"
        Write-host "-----------------------"
        Write-host `"$jsonMapping`"
    }

    
    

   