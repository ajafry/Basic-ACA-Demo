$RG_NAME = '<resource-group-name>'
$LOCATION = '<location>'
$CONTAINER_APP_NAME = '<container-app-name>'
$ACA_ENVIRONMENT_NAME = '<aca-environment-name>'

# Install the ACA extension (it may already be installed on your machine, but just to make sure)
az extension add --name containerapp --upgrade --allow-preview true

az provider register --namespace Microsoft.App
az provider register --namespace Microsoft.OperationalInsights