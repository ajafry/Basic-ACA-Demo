# This script will create a new Azure Container App, build the code files using the Dockerfile in this directory, push it to the
# Azure Container Registry, and deploy it to the Azure Container App.
# This is one of the simplest ways to deploy a containerized application to Azure. 
# This method does not even require a Docker installation on the local machine.

$RG_NAME = '<resource-group-name>'
$LOCATION = '<location>'
$CONTAINER_APP_NAME = '<container-app-name>'
$ACA_ENVIRONMENT_NAME = '<aca-environment-name>'
$ACR_REGISTRY_SERVER = '<acr-registry-server>'  # e.g. myregistry.azurecr.io

Set-Location -Path '<path-to-your-dockerfile>'

# The az containerapp up command is the fastest way to deploy an app in Azure Container Apps from an existing image, local source code, or a GitHub repo. 
# With this single command, you can have your container app up and running in minutes.
# It case use existing resources (resouce group, ACR, environment, LAW, app) or create new ones.
# Note: Ingress will be enabled by default.
az containerapp up --name $CONTAINER_APP_NAME --resource-group $RG_NAME --location $LOCATION --registry-server $ACR_REGISTRY_SERVER --environment $ACA_ENVIRONMENT_NAME --source .

# Make changes to the HTML file and re-run the previous command