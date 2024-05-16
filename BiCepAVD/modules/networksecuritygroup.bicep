@description('Name of the NSG')
param name string

@description('Tags on the NSG')
param tags object

@description('Region of NSG')
param location string = resourceGroup().location

resource networksecuritgroup 'Microsoft.Network/networkSecurityGroups@2023-11-01' = {
  name: 'nsg-${name}'
  location: location
  tags: tags
  properties: {
    securityRules: [
      {
        name: 'Inbound App01'
        properties: {
          protocol: 'Tcp'
          sourcePortRange: '*'
          destinationPortRanges:  [
            '8080'
            '5701'
          ]
          sourceAddressPrefix: '*'
          destinationAddressPrefix: '10.0.59.10/24'
          access: 'Allow'
          priority: 120
          direction: 'Inbound'
        }
      }
    ]
  }
}

output id string = networksecuritgroup.id
