#Define the interval to repeat the job
$trigger = New-JobTrigger -Once -At 9:00AM -RepetitionInterval (New-TimeSpan -Seconds 60) -RepeatIndefinitely
#Get user credential so that the job has access to the network
$cred = Get-Credential -UserName Administrator
#Set job options
$opt = New-ScheduledJobOption -RunElevated -RequireNetwork
#
Register-ScheduledJob -Name Remove-Runner -Trigger $trigger -Credential $cred -FilePath c:\Windows\System32\actions-runner\remove_runner.ps1 -MaxResultCount 10  ScheduledJobOption $opt



#Define the interval to repeat the job
$trigger = New-JobTrigger -Once -At (Get-Date).Date -RepetitionInterval (New-TimeSpan -Seconds 60) -RepeatIndefinitely

#Create Schedule Job
Register-ScheduledJob -Name Remove-Runner -Trigger $trigger -Credential $cred -FilePath c:\Windows\System32\actions-runner\remove-runner.ps1 -User "Administrator" 
