cd C:\Windows\System32\actions-runner;

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
   ./config.cmd remove --token $remove_token;
}else {
   $PAT = "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";
   $org = "Zikulas";
   $headers = @{
       'Accept' = 'application/vnd.github+json'
       'X-GitHub-Api-Version' = '2022-11-28'
       'Authorization' = "Bearer $PAT"
   };
   $reg_token_url = "https://api.github.com/orgs/$org/actions/runners/remove-token";
   $reg_token = Invoke-RestMethod -Uri $reg_token_url -Method Post -Headers $headers | Select-Object -Property token -First 1 -ExpandProperty token;
   ./config.cmd --unattended --url https://github.com/Zikulas --token $reg_token;
}; 


$PAT = "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";
   $org = "Zikulas";
   $headers = @{
       'Accept' = 'application/vnd.github+json'
       'X-GitHub-Api-Version' = '2022-11-28'
       'Authorization' = "Bearer $PAT"
   };
   $reg_token_url = "https://api.github.com/orgs/$org/actions/runners/remove-token";
   $reg_token = Invoke-RestMethod -Uri $reg_token_url -Method Post -Headers $headers | Select-Object -Property token -First 1 -ExpandProperty token;
   ./config.cmd --unattended --url https://github.com/Zikulas --token $reg_token --runasservice --windowslogonaccount 'Administrator' --windowslogonpassword 'admin12345;';