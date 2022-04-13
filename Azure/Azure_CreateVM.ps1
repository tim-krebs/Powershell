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

# ***** PowerShell Script to create virtual machines with azure powershell *****


Function CreateVM{
    <#
    .SYNOPSIS
    .DESCRIPTION
    .PARAMETER Name
    .EXAMPLE
    #>

    param(
        [Parameter(Mandatory=$true)]
        [string]$ResourceGroupName

        [Parameter(Mandatory=$true)]
        [string]$ResourceGroupVnetName

        [Parameter(Mandatory=$true)]
        [string]$LocationName

        [Parameter(Mandatory=$true)]
        [string]$SubscriptionName
    )

    'Setting Powershell context to Azure Internal Consumption'
    Select-AzSubscription $SubscriptionName

    $DcVirtualMachineSKU = "Standard_B2s"
    $ExchangeVirtualMachineSKU = "Standard_b4ms"
    $ClientMachineVirtualMachineSKU = "Standard_b2ms"

}