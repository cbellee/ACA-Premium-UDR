param location string
param vnetName string
param vnetPrefix string
param subnets array

resource vnet 'Microsoft.Network/virtualNetworks@2021-05-01' = {
  name: vnetName
  location: location
  properties: {
    addressSpace: {
      addressPrefixes: [
        vnetPrefix
      ]
    }
    subnets: [for subnet in subnets: {
      name: '${vnetName}/${subnet.name}'
      properties: {
        addressPrefix: subnet.properties.addressPrefix
        privateEndpointNetworkPolicies: 'Disabled'
        privateLinkServiceNetworkPolicies: 'Enabled'
      }
    }]
  }
}

/* @batchSize(1)
resource vnetSubnets 'Microsoft.Network/virtualNetworks/subnets@2020-08-01' = [ for subnet in subnets: {
  name: '${vnet.name}/${subnet.name}'
  properties: {
    addressPrefix: subnet.properties.addressPrefix
    privateEndpointNetworkPolicies: 'Disabled'
    privateLinkServiceNetworkPolicies: 'Enabled'
  }
}] */

output vnetId string = vnet.id
