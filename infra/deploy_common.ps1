$template_file = "common.bicep"
$deployment_id = Get-Date -Format "yyyyMMddHHmmss"
$project = "common270f06e"
$environment = "dev"

$deployment_name = "$project-dply-$deployment_id-$environment"

Connect-AzAccount

$context = Get-AzSubscription -SubscriptionName "analytics-sub-dev"
Set-AzContext $context

Set-AzDefault -ResourceGroupName "common-rg-dev"

Write-Output "Deployment name: $deployment_name"

New-AzResourceGroupDeployment `
  -TemplateFile $template_file `
  -Mode Complete `
  -Name $deployment_name `
  -project $project `
  -environment $environment