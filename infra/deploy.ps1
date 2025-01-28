$template_file = "main.bicep"
$default_location = "eastus"
$deployment_id = Get-Date -Format "yyyyMMddHHmmss"
$project = "wwi-migration2"
$environment = "dev"
$admin_password = ConvertTo-SecureString "xi6ZWendn8aMF2" -AsPlainText -Force # Use only letters and numbers to avoid issues with scaping special characters.

$deployment_name = "$project-dply-$deployment_id-$environment"

Connect-AzAccount

$context = Get-AzSubscription -SubscriptionName "analytics-sub-dev"
Set-AzContext $context

Write-Output "Deployment name: $deployment_name"

New-AzSubscriptionDeployment `
  -TemplateFile $template_file `
  -Location $default_location `
  -Name $deployment_name `
  -default_location $default_location `
  -deployment_id $deployment_id `
  -project $project `
  -environment $environment `
  -admin_password $admin_password