# Use this file to deploy the infrastructure for an Azure Container App environment

$RESOURCE_GROUP_NAME = "<resource-group-name>"

Set-Location -Path '<path-to-your-bicep-file>'
az deployment group create  --resource-group $RESOURCE_GROUP_NAME --template-file .\main.bicep --parameters suffix='foo'