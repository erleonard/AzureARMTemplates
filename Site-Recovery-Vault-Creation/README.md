# Site Recovery Vault Creation

This template creates a recovery vault for Azure Site Recovery with storage account and virtual network.

## Deploy using Azure Portal
[![Deploy to Azure](http://azuredeploy.net/deploybutton.png)](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Ferleonard%2FAzureARMTemplates%2Fmaster%2FSite-Recovery-Vault-Creation%2Fazuredeploy.json)
# Deploy using PowerShell:
````powershell
New-AzureRmResourceGroupDeployment -Name ASRDeployment `
                                   -ResourceGroupName (New-AzureRmResourceGroup -Name 'RG-ASR' -Location 'canadaeast').ResourceGroupName `
                                   -TemplateUri 'https://raw.githubusercontent.com/erleonard/AzureARMTemplates/master/Site-Recovery-Vault-Creation/azuredeploy.json' `
                                   -VaultName 'ASR' `
                                   -ASRVaultVNName 'ASRVault-VNET-PROD' `
                                   -ASRVaultSAType 'Standard_LRS' `
                                   -Verbose
````

