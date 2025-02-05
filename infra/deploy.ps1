$template_file = "main.bicep"
$default_location = "eastus"
$project = "wwi-migration2"
$env = "dev"
# Use only letters and numbers for password to avoid issues with scaping special characters.
$admin_password = ConvertTo-SecureString "xi6ZWendn8aMF2" -AsPlainText -Force
$deployment_id = Get-Date -Format "yyyyMMddHHmmss"
$deployment_name = "$project-dply-$deployment_id-$env"

Connect-AzAccount

$context = Get-AzSubscription -SubscriptionName "analytics-sub-dev"
Set-AzContext $context

Write-Output "Deployment name: $deployment_name"

New-AzSubscriptionDeployment `
  -TemplateFile $template_file `
  -Location $default_location `
  -Name $deployment_name `
  -deployment_id $deployment_id `
  -default_location $default_location `
  -project $project `
  -env $env `
  -admin_password $admin_password