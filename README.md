# pwd-pwk8s-azurermtemplate

This is a simple Azure RM template to build an Ubuntu 18.04 VM with Play-with-Docker/K8S installed.

The NSG created is open to the world, ensure to change the `sourceAddressPrefix` parameter to restrict access to a single IP.

## Deployment example using Azure CLI:

### Create a resource group

`az group create --name pwd-pwk8s-azurermtemplate --location northeurope`

*Change northeurope to your local region*

### Change the parameters in azuredeploy.parameters.json

Update the `adminPublicKey` parameter to your own SSH key and update the dnsZone parameter to a valid DNS child zone you can delegate to from your own DNS domain.

### Deploy template

`az deployment group create --resource-group pwd-pwk8s-azurermtemplate --template-file ./azuredeploy.json --parameters ./azuredeploy.parameters.json`

### Delegate your DNS

You need to set up DNS delegation so that you can resolve the DNS zone specified in the `dnsZone` parameter

### Access the environment

Access the environment using `http://host.{dnsZone}` refers to the child dns zone mentioned earlier

### Clean-up

When you're done, delete the resource group:

`az group delete --name pwd-pwk8s-azurermtemplate --yes`
