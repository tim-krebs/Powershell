<#
Copyright (c) 2022 Tim Krebs. All rights reserved.

MIT License

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:
The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED *AS IS*, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
#>

# ***** PowerShell Script to create your Resource Group and Virtual Network with Azure PowerShell *****

Function CreateVM{
    <#
    .SYNOPSIS
    .DESCRIPTION
    .PARAMETER Name
    .EXAMPLE
    Gather-Info -ResourceGroupName <YourLabName> -ResourceGroupVnetName <VirtualNetwork> -LocationName <EastUS> -MSInternalAzureSubScription <d06dcc55-07b2-4b7f-9e73-830e50422235>
    #>
    param( 
        [Parameter(Mandatory=$true)]
        [string]$ResourceGroupName

        [Parameter(Mandatory=$true)]
        [string]$ResourceGroupVnetName

        [Parameter(Mandatory=$true)]
        [string]$LocationName

        [Parameter(Mandatory=$true)]
        [string]$MSInternalAzureSubScription
    )

    'Connect to your Azure-Account...'

    'Set MS Internal Consumption SubscriptionID...'
    $MSInternalAzureSubScription=$MSInternalAzureSubScription

    ' Set PowerShell context to Internal Consumption...'
    Select-AzSubscription -SubscriptionName $MSInternalAzureSubScription

    'Create new ResourceGroup...'
    New-AZResourceGroup -Name $ResourceGroupName -Location $LocationName

    'Create new Azure Virtual Network and network security Group to allow HTTPS/SMTP/RDP...'
    'Setting Resource Group rules..'
    $rule1 = New-AZNetworkSecurityRuleConfig -Name "RDPTraffic" -Description "Allow RDP to all VMs on the subnet" -Access Allow -Protocol Tcp -Direction Inbound -Priority 100 -SourceAddressPrefix Internet -SourcePortRange * -DestinationAddressPrefix * -DestinationPortRange 3389
    $rule2 = New-AZNetworkSecurityRuleConfig -Name "ExchangeSecureWebTraffic" -Description "Allow HTTPS to all VMs on the subnet" -Access Allow -Protocol Tcp -Direction Inbound -Priority 101 -SourceAddressPrefix Internet -SourcePortRange * -DestinationAddressPrefix * -DestinationPortRange 443
    $rule3 = New-AZNetworkSecurityRuleConfig -Name "ExchangeSMTPTraffic" -Description " Allow SMTP to all VMs on the subnet" -Access Allow -Protocol Tcp -Direction Inbound -Priority 102 -SourceAddressPrefix Internet -SourcePortRange * -DestinationAddressPrefix * -DestinationPortRange 25

    'Apply rules...'
    New-AZNetworkSecurityGroup -Name EXSrvrSubnetNSG -ResourceGroupName $ResourceGroupName -Location $LocationName -SecurityRules $rule1, $rule2,$rule3
    $nsg=Get-AZNetworkSecurityGroup -Name EXSrvrSubnetNSG -ResourceGroupName $ResourceGroupName
    Add-AZVirtualNetworkSubnetConfig -Name default -AddressPrefix 10.0.0.0/24 -VirtualNetwork $virtualNetwork -NetworkSecurityGroup $nsg

    $virtualNetwork | Set-AZVirtualNetwork

    '**** Finished Successfull - Resource Group Created ****'
    
}