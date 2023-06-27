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


$trigger = New-JobTrigger -Once -At (Get-Date).Date -RepetitionInterval (New-TimeSpan -Seconds 60) -RepeatIndefinitely
Register-ScheduledJob -Name Remove-Runner -Trigger $trigger -FilePath c:\Windows\System32\actions-runner\remove-runner.ps1

$time=Get-Date -Format "dddd MM/dd/yyyy HH:mm K"
Add-Content C:\ProgramData\Amazon\EC2Launch\log\agent.log $time 

cat C:\ProgramData\Amazon\EC2Launch\log\agent.log 


Register-ScheduledJob -Name Remove-Runner-State -Trigger $trigger -ScriptBlock {
    $aws_token_url = "http://169.254.169.254/latest/api/token";
    $aws_token_headers = @{
        'X-aws-ec2-metadata-token-ttl-seconds' = '21600'
    };
    $aws_token = Invoke-RestMethod -Uri $aws_token_url -Method Put -Headers $aws_token_headers;
    $ec2_metadata_url = "http://169.254.169.254/latest/meta-data/autoscaling/target-lifecycle-state";
    $ec2_metadata_headers = @{
        'X-aws-ec2-metadata-token' = $aws_token
    };
    $ec2_lifecycle_state = Invoke-RestMethod -Uri $ec2_metadata_url -Method Get -Headers $ec2_metadata_headers;
    $date=Get-Date;
    $content=$ec2_lifecycle_state + "," + $date;
    Add-Content C:\ProgramData\Amazon\EC2Launch\log\agent.log $content;
    if($ec2_lifecycle_state -eq 'Terminated'){
        $PAT = "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";
        $org = "Zikulas";
        $headers = @{
            'Accept' = 'application/vnd.github+json'
            'X-GitHub-Api-Version' = '2022-11-28'
            'Authorization' = "Bearer $PAT"
        };
        $remove_token_url = "https://api.github.com/orgs/$org/actions/runners/remove-token";
        $remove_token = Invoke-RestMethod -Uri $remove_token_url -Method Post -Headers $headers | Select-Object -Property token -First 1 -ExpandProperty token;
        C:\Windows\System32\actions-runner\config.cmd remove --token $remove_token;
    }else {
        $content=$ec2_lifecycle_state + ", Good";
        Add-Content C:\ProgramData\Amazon\EC2Launch\log\agent.log $content;
    };
}
