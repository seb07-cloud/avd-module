#Initialize Variables
$ENV:TF_VAR_REGION = "westeurope"
$ENV:TF_VAR_STORAGE_ACCOUNT_SKU = "Standard_LRS"
$RESOURCEGROUPNAME = "rg_terraformstate"

#Connect and set Owner Permissions on the Root Level of the Subscription
Connect-AzAccount
New-AzRoleAssignment -Scope '/' -RoleDefinitionName 'Owner' -ObjectId (Get-AzADUser -UserPrincipalName (Get-AzContext).Account).id

#Create Storageaccount and Container for TFState
$ENV:TF_VAR_STORAGEACCOUNTNAME = "$($ENV:TF_VAR_CUSTOMER_PREFIX)terraformtfstate"
$CONTAINERNAME = "tfstate"

$STORAGEACCOUNT = New-AzStorageAccount -ResourceGroupName $RESOURCEGROUPNAME `
    -SkuName $ENV:TF_VAR_STORAGE_ACCOUNT_SKU `
    -Location $ENV:TF_VAR_REGION `
    -Name $STORAGEACCOUNTNAME `
    -AllowBlobPublicAccess $True

New-AzStorageContainer -Name $CONTAINERNAME `
    -Context $STORAGEACCOUNT.Context `
    -Permission blob

$ACCOUNT_KEY = (Get-AzStorageAccountKey -ResourceGroupName $RESOURCEGROUPNAME -Name $STORAGEACCOUNTNAME)[0].value
$env:ARM_ACCESS_KEY = $ACCOUNT_KEY
