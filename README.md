# pwd-pwk8s-azurermtemplate

This is a simple Azure RM template to build an Ubuntu 18.04 VM with Play-with-Docker/K8S installed.

The NSG created is open to the world, ensure to change the `sourceAddressPrefix` parameter to restrict access to a single IP.

## Deployment example using Azure CLI:

### Create a resource group

`az group create --name pwd-pwk8s-azurermtemplate --location `

*Change northeurope to your local region*

### Deploy template

`az group deployment create --resource-group pwd-pwk8s-azurermtemplate --template-file ./azuredeploy.json --parameters ./azuredeploy.parameters.json`

### Clean-up

When you're done, delete the resource group:

`az group delete --name pwd-pwk8s-azurermtemplate --yes`
