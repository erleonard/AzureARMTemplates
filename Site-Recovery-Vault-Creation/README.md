# Site Recovery Vault Creation

This template creates a recovery vault for Azure Site Recovery.

# Deploy using PowerShell:
````powershell
New-AzureRmResourceGroupDeployment -Name ASRDeployment `
                                   -ResourceGroupName (New-AzureRmResourceGroup -Name 'RG-ASR' -Location 'canadaeast').ResourceGroupName `
                                   -TemplateUri 'https://raw.githubusercontent.com/erleonard/AzureARMTemplates/master/Site-Recovery-Vault-Creation/azuredeploy.json' `
                                   -VaultName 'ASR' `
                                   -ASRVaultVNName 'ASRVault-VNET-PROD' `
                                   ASRVaultSAType 'Standard_LRS' `
                                   -Verbose
````