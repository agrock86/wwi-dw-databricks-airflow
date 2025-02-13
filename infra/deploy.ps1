$template_file = "main.bicep"
$default_location = "eastus"
$project = "wwi-migration2"
$env = "dev"
# Use only letters and numbers for password to avoid issues with scaping special characters.
$admin_password = ConvertTo-SecureString "xi6ZWendn8aMF2" -AsPlainText -Force
$ssh_public_key = ConvertTo-SecureString "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCm4fNuzYrn3SuIXZ0CBoU9AGVAL6jxzYTsCAZl7M8nGRSmmMWEYb3V9JB0YYiGSUtZfzhRaHuXGr+vCy8ssm9STNvhc1Ar9Sh9FQsxVBfblS8DJkYsK4FLmvlykHV/YQNT5HElVse+L/7mFVwAtIQ9jHYtDGfobrC3ZBVL6yEqYeTtIiZD9xAt0sGuYk38DZ+jnS8BcQjeVrYuI1Q7DSeB/rd3+TNjJ7ELQuUD4rd6IQ322R1CjAMYky2Yxalnvc5HOuPZTmCQR793dGUtVylx5/TZpOQTYCh2iB6w2R7uCwbp7dLraKCBme8JPa2Sg2AZwYaYukj4g1KTX3wfPGh36XBX4YBn2gZkwYM7TLMjB6NM3QyRwzSYCn7v84MblWHLOTP+GMFD24lT0jdffnoWi0Sjn72BvvIkpMXwmYNza68Tn5fDerWvAHR1JEMDFjOcT4LltbiOX4dn+bbmzUZ7h+CiDpk6Or+xF8fUy2KWOfaLlM21s2cMcNjM4eI/hO0= generated-by-azure" -AsPlainText -Force
$deployment_id = Get-Date -Format "yyyyMMddHHmmss"
$deployment_name = "$project-dply-$deployment_id-$env"
$client_ip = (Invoke-WebRequest -Uri "https://api64.ipify.org").Content

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
  -admin_password $admin_password `
  -ssh_public_key $ssh_public_key `
  -client_ip $client_ip