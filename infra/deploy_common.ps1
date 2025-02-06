$template_file = "common.bicep"
$deployment_id = Get-Date -Format "yyyyMMddHHmmss"
$project = "common270f06e"
$env = "dev"

$deployment_name = "$project-dply-$deployment_id-$env"
$client_ip = (Invoke-WebRequest -Uri "https://api64.ipify.org").Content

Connect-AzAccount

$context = Get-AzSubscription -SubscriptionName "analytics-sub-dev"
Set-AzContext $context

Set-AzDefault -ResourceGroupName "common-rg-dev"

Write-Output "Deployment name: $deployment_name"

New-AzResourceGroupDeployment `
  -TemplateFile $template_file `
  -Name $deployment_name `
  -project $project `
  -env $env `
  -client_ip $client_ip