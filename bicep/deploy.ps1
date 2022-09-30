$rgName = 'aca-udr-private-preview-rg'
$location = 'australiaeast'

az group create --name $rgName --location $location

az deployment group create `
    --resource-group $rgName `
    --name 'aca-udr-deployment' `
    --template-file .\bicep\main.bicep `
    --parameters publicSshKey="$(Get-Content ~/.ssh/id_rsa.pub)"
