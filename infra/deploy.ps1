$deployment_id = Get-Date -Format 'yyyyMMddHHmmss'
$deployment_name = "$project-dply-$deployment_id-$environment"
$template_file = 'main.bicep'

$project = 'wwi-migration2'
$environment = 'dev'
$default_location = 'eastus'

New-AzSubscriptionDeployment `
  -Name $deployment_name `
  -Location $default_location `
  -TemplateFile $template_file `
  -project $project `
  -environment $environment `
  -default_location $default_location `