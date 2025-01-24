$template_file = "main.bicep"
$default_location = "eastus"
$deployment_id = Get-Date -Format "yyyyMMddHHmmss"
$project = "wwi-migration2"
$environment = "dev"
$admin_password = ConvertTo-SecureString "xi6Z&Wendn*8aMF2" -AsPlainText -Force

$deployment_name = "$project-dply-$deployment_id-$environment"

Connect-AzAccount

$context = Get-AzSubscription -SubscriptionName "analytics-sub-dev"
Set-AzContext $context

Write-Output "Deployment name: $deployment_name"

New-AzSubscriptionDeployment `
  -TemplateFile $template_file `
  -Mode Complete `
  -Location $default_location `
  -Name $deployment_name `
  -default_location $default_location `
  -deployment_id $deployment_id `
  -project $project `
  -environment $environment `
  -admin_password $admin_password