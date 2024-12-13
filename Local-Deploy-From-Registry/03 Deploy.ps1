# This script will create a new Azure Container App, build the code files using the Dockerfile in this directory, push it to the
# Azure Container Registry, and deploy it to the Azure Container App.
# This method does not even require a Docker installation on the local machine.

$RG_NAME = '<resource-group-name>'
$LOCATION = '<location>'
$CONTAINER_APP_NAME = '<container-app-name>'
$ACA_ENVIRONMENT_NAME = '<aca-environment-name>'
$ACR_NAME = '<acr-name>'
$ACR_REGISTRY_SERVER = "$ACR_NAME.azurecr.io"
$IMAGE_NAME = '<image-name>'

Set-Location -Path '<path-to-your-dockerfile>'
# Create a docker container using the Dockerfile (*** this command will require Docker to be running on the local machine ***)
docker build -t "$ACR_REGISTRY_SERVER/$IMAGE_NAME" .

# Label the image and push it to Azure Container Registry
az acr login --name $ACR_NAME
docker push "$ACR_REGISTRY_SERVER/$IMAGE_NAME"

# Deploy the image from Azure Container Registry to ACA (if new app is being created, ingress will not be enabled by default)
az containerapp up --name $CONTAINER_APP_NAME --resource-group $RG_NAME --location $LOCATION --image "$ACR_REGISTRY_SERVER/$IMAGE_NAME" --environment $ACA_ENVIRONMENT_NAME

# To only update the image
az containerapp update --name $CONTAINER_APP_NAME --resource-group $RG_NAME --image "$ACR_REGISTRY_SERVER/$IMAGE_NAME"

# To only add Ingress to the existing container app
az containerapp up --name $CONTAINER_APP_NAME --resource-group $RG_NAME --image "$ACR_REGISTRY_SERVER/$IMAGE_NAME" --ingress external --target-port 80