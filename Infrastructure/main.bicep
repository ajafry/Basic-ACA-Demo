param location string = resourceGroup().location
param suffix string = 'abcd'
param logAnalyticsWorkspaceName string = 'law-${location}-${suffix}'
param containerAppsEnvironmentName string = 'cappenv${suffix}'
param containerRegistryName string = 'acr${location}${suffix}'

module logAnalyticsWorkspace 'br/public:avm/res/operational-insights/workspace:0.9.0' = {
  name: 'logAnalyticsWorkspaceDeployment'
  params: {
    // Required parameters
    name: logAnalyticsWorkspaceName
    // Non-required parameters
    location: location
  }
}

module containerAppsEnvironment 'br/public:avm/res/app/managed-environment:0.8.1' = {
  name: 'containerAppsEnvironmentDeployment'
  params: {
    // Required parameters
    logAnalyticsWorkspaceResourceId: logAnalyticsWorkspace.outputs.resourceId
    name: containerAppsEnvironmentName
    // Non-required parameters
    internal: false
    zoneRedundant: false
    location: location
    workloadProfiles: [
      {
        maximumCount: 3
        minimumCount: 0
        name: 'CAW01'
        workloadProfileType: 'D4'
      }
    ]
  }
}

module registry 'br/public:avm/res/container-registry/registry:0.6.0' = {
  name: 'containerRegistryDeployment'
  params: {
    // Required parameters
    name: containerRegistryName
    // Non-required parameters
    acrSku: 'Basic'
    location: location
  }
}
