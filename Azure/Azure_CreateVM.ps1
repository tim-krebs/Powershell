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


function CreateVM{
    <#
    .SYNOPSIS
    .DESCRIPTION
    .PARAMETER Name
    .EXAMPLE
    CreateVM -ResourceGroupName TestLab -ResourceGroupVnetName VirtualNetwork -LocationName EastUS -SubscriptionName c6b2e6c3-4430-4f8e-ab91-1b24b751d2b0
    #>

    param(
        [Parameter(Mandatory=$true)]
        [string]$ResourceGroupName,

        [Parameter(Mandatory=$true)]
        [string]$ResourceGroupVnetName,

        [Parameter(Mandatory=$true)]
        [string]$LocationName,

        [Parameter(Mandatory=$true)]
        [string]$SubscriptionName
    )

    'Setting Powershell context to Azure Internal Consumption...'
    Select-AzSubscription $SubscriptionName

    'Setting Virtual Machine size...'
    $DcVirtualMachineSKU = "Standard_B2s"
    $ExchangeVirtualMachineSKU = "Standard_b4ms"
    $ClientMachineVirtualMachineSKU = "Standard_b2ms"


    #Provision The Domain Controller - Tested Good
    'Creating Domain Controller...'
    $vmDCName = "AZ-DC-01"
    $locationName = (Get-AZResourceGroup -Name $ResourceGroupName).Location
    $DCcred=Get-Credential -Message "Type the name and password of the local administrator account. User name: labadmin, Password: LS1Setup! $vmDCName."

    $vnet=Get-AZVirtualNetwork -Name $ResourceGroupVnetName -ResourceGroupName $ResourceGroupName

    $nicDCName=$vmDCName + "-NIC"
    $pipDCName=$vmDCName + "-PublicIP"
    $DCpip=New-AZPublicIpAddress -Name $pipDCName -ResourceGroupName $ResourceGroupName -Location $locationName -AllocationMethod Dynamic
    $DCnic=New-AZNetworkInterface -Name $nicDCName -ResourceGroupName $ResourceGroupName -Location $locationName -SubnetId $vnet.Subnets[0].Id -PublicIpAddressId $DCpip.Id


    $vmDCConfig=New-AZVMConfig -VMName $vmDCName -VMSize $DcVirtualMachineSKU
    'Setting Disk size...'
    $vmDCConfig=Set-AZVMOSDisk -VM $vmDCConfig -Name ($vmDCName +"-OS") -DiskSizeInGB 128 -CreateOption FromImage -StorageAccountType "Standard_LRS"
    $vmDCConfig=Set-AZVMOperatingSystem -VM $vmDCConfig -Windows -ComputerName $vmDCName -Credential $DCcred -ProvisionVMAgent -EnableAutoUpdate
    $vmDCConfig=Set-AZVMSourceImage -VM $vmDCConfig -PublisherName MicrosoftWindowsServer -Offer WindowsServer -Skus 2019-Datacenter -Version "latest"
    $vmDCConfig=Add-AZVMNetworkInterface -VM $vmDCConfig -Id $DCnic.Id

    New-AZVM -ResourceGroupName $ResourceGroupName -Location $locationName -VM $vmDCConfig
    '**** Finished - Domain Controller Created ****'


    #Provision The Exchange Virtual Machine - Tested Good
    #Exchange 2019
    'Creating Exchange VM...'
    $vmEXName="AZ-EX-2019-01" 
    $locationName=(Get-AZResourceGroup -Name $ResourceGroupName).Location 
    $EXcred=Get-Credential -Message "Type the name and password of the local administrator account. User name: labadmin, Password: LS1Setup! $vmEXName." 
    $vnet=Get-AZVirtualNetwork -Name $ResourceGroupVnetName -ResourceGroupName $ResourceGroupName 

    $nicEXName=$vmEXName + "-NIC" 
    $pipEXName=$vmEXName + "-PublicIP" 
    $EXpip=New-AZPublicIpAddress -Name $pipEXName -ResourceGroupName $ResourceGroupName -Location $locationName -AllocationMethod Dynamic 
    $EXnic=New-AZNetworkInterface -Name $nicEXName -ResourceGroupName $ResourceGroupName -Location $locationName -SubnetId $vnet.Subnets[0].Id -PublicIpAddressId $Expip.id 
    
    $vmExConfig=New-AZVMConfig -VMName $vmEXName -VMSize $ExchangeVirtualMachineSKU 
    $vmExConfig=Set-AZVMOSDisk -VM $vmExConfig -Name ($vmEXName +"-OS") -DiskSizeInGB 128 -CreateOption FromImage -StorageAccountType "Standard_LRS" 
    $vmExConfig=Set-AZVMOperatingSystem -VM $vmExConfig -Windows -ComputerName $vmEXName -Credential $EXcred -ProvisionVMAgent -EnableAutoUpdate 
    $vmExConfig=Set-AZVMSourceImage -VM $vmExConfig -PublisherName MicrosoftWindowsServer -Offer WindowsServer -Skus 2019-Datacenter -Version "latest" 
    $vmExConfig=Add-AZVMNetworkInterface -VM $vmExConfig -Id $EXnic.Id 

    New-AZVM -ResourceGroupName $ResourceGroupName -Location $locationName -VM $vmExConfig
    '**** Finished - Exchange VM Created ****'


    #Provision The Client Virtual Machine - Tested Good
    'Creating Client VM...'
    $vmName="AZ-Client-01" 
    $locationName=(Get-AZResourceGroup -Name $ResourceGroupName).Location 
    $cred=Get-Credential -Message "Type the name and password of the local administrator account for exVM. User name: labadmin, Password: LS1Setup!." 
    $vnet=Get-AZVirtualNetwork -Name $ResourceGroupVnetName -ResourceGroupName $ResourceGroupName 

    $nicName=$vmName + "-NIC" 
    $pipName=$vmName + "-PublicIP" 
    $pip=New-AZPublicIpAddress -Name $pipName -ResourceGroupName $ResourceGroupName -Location $locationName -AllocationMethod Dynamic 
    $nic=New-AZNetworkInterface -Name $nicName -ResourceGroupName $ResourceGroupName -Location $locationName -SubnetId $vnet.Subnets[0].Id -PublicIpAddressId $pip.Id 
    
    $vm=New-AZVMConfig -VMName $vmName -VMSize $ClientMachineVirtualMachineSKU 
    $vm=Set-AZVMOSDisk -VM $vm -Name ($vmName +"-OS") -DiskSizeInGB 128 -CreateOption FromImage -StorageAccountType "Standard_LRS" 
    $vm=Set-AZVMOperatingSystem -VM $vm -Windows -ComputerName $vmName -Credential $cred -ProvisionVMAgent -EnableAutoUpdate 
    $vm=Set-AZVMSourceImage -VM $vm -PublisherName MicrosoftWindowsDesktop -Offer Windows-10 -Skus 21H1-pro  -Version "latest" 
    $vm=Add-AZVMNetworkInterface -VM $vm -Id $nic.Id 

    New-AZVM -ResourceGroupName $ResourceGroupName -Location $locationName -VM $vm

    '**** Finished - Client-01 VM Created ****'


    #Provision The Client Virtual Machine - Tested Good
    $vmName="AZ-Client-02" 
    $locationName=(Get-AZResourceGroup -Name $ResourceGroupName).Location 
    $cred=Get-Credential -Message "Type the name and password of the local administrator account for exVM. User name: labadmin, Password: LS1Setup!" 
    $vnet=Get-AZVirtualNetwork -Name $ResourceGroupVnetName -ResourceGroupName $ResourceGroupName 

    $nicName=$vmName + "-NIC" 
    $pipName=$vmName + "-PublicIP" 
    $pip=New-AZPublicIpAddress -Name $pipName -ResourceGroupName $ResourceGroupName -Location $locationName -AllocationMethod Dynamic 
    $nic=New-AZNetworkInterface -Name $nicName -ResourceGroupName $ResourceGroupName -Location $locationName -SubnetId $vnet.Subnets[0].Id -PublicIpAddressId $pip.Id 
    
    $vm=New-AZVMConfig -VMName $vmName -VMSize $ClientMachineVirtualMachineSKU 
    $vm=Set-AZVMOSDisk -VM $vm -Name ($vmName +"-OS") -DiskSizeInGB 128 -CreateOption FromImage -StorageAccountType "Standard_LRS" 
    $vm=Set-AZVMOperatingSystem -VM $vm -Windows -ComputerName $vmName -Credential $cred -ProvisionVMAgent -EnableAutoUpdate 
    $vm=Set-AZVMSourceImage -VM $vm -PublisherName MicrosoftWindowsDesktop -Offer Windows-10 -Skus 21H1-pro  -Version "latest" 
    $vm=Add-AZVMNetworkInterface -VM $vm -Id $nic.Id 
    
    New-AZVM -ResourceGroupName $ResourceGroupName -Location $locationName -VM $vm 
    '**** Finished - Client-02 VM Created ****'


    #Provision The Client Virtual Machine - Tested Good- Windows 11
    $vmName="AZ-Client-03" 
    $locationName=(Get-AZResourceGroup -Name $ResourceGroupName).Location 
    $cred=Get-Credential -Message "Type the name and password of the local administrator account for exVM. User name: labadmin, Password: LS1Setup!" 
    $vnet=Get-AZVirtualNetwork -Name $ResourceGroupVnetName -ResourceGroupName $ResourceGroupName 

    $nicName=$vmName + "-NIC" 
    $pipName=$vmName + "-PublicIP" 
    $pip=New-AZPublicIpAddress -Name $pipName -ResourceGroupName $ResourceGroupName -Location $locationName -AllocationMethod Dynamic 
    $nic=New-AZNetworkInterface -Name $nicName -ResourceGroupName $ResourceGroupName -Location $locationName -SubnetId $vnet.Subnets[0].Id -PublicIpAddressId $pip.Id 
    
    $vm=New-AZVMConfig -VMName $vmName -VMSize $ClientMachineVirtualMachineSKU 
    $vm=Set-AZVMOSDisk -VM $vm -Name ($vmName +"-OS") -DiskSizeInGB 128 -CreateOption FromImage -StorageAccountType "Standard_LRS" 
    $vm=Set-AZVMOperatingSystem -VM $vm -Windows -ComputerName $vmName -Credential $cred -ProvisionVMAgent -EnableAutoUpdate 
    $vm=Set-AZVMSourceImage -VM $vm -PublisherName MicrosoftWindowsDesktop -Offer Windows-11 -Skus win11-21h2-pro  -Version "latest" 
    $vm=Add-AZVMNetworkInterface -VM $vm -Id $nic.Id 
    
    New-AZVM -ResourceGroupName $ResourceGroupName -Location $locationName -VM $vm 
    '**** Finished - Client-03 VM Created ****'


    #Provision The Exchange Virtual Machine - Tested Good
    #Exchange EDGE 2019
    $vmEXName="AZ-EDGE-2019-01" 
    $locationName=(Get-AZResourceGroup -Name $ResourceGroupName).Location 
    $EXcred=Get-Credential -Message "Type the name and password of the local administrator account for $vmEXName. User name: labadmin, Password: LS1Setup!" 
    $vnet=Get-AZVirtualNetwork -Name $ResourceGroupVnetName -ResourceGroupName $ResourceGroupName 

    $nicEXName=$vmEXName + "-NIC" 
    $pipEXName=$vmEXName + "-PublicIP" 
    $EXpip=New-AZPublicIpAddress -Name $pipEXName -ResourceGroupName $ResourceGroupName -Location $locationName -AllocationMethod Dynamic 
    $EXnic=New-AZNetworkInterface -Name $nicEXName -ResourceGroupName $ResourceGroupName -Location $locationName -SubnetId $vnet.Subnets[0].Id -PublicIpAddressId $Expip.id 
    
    $vmExConfig=New-AZVMConfig -VMName $vmEXName -VMSize $ExchangeVirtualMachineSKU 
    $vmExConfig=Set-AZVMOSDisk -VM $vmExConfig -Name ($vmEXName +"-OS") -DiskSizeInGB 128 -CreateOption FromImage -StorageAccountType "Standard_LRS" 
    $vmExConfig=Set-AZVMOperatingSystem -VM $vmExConfig -Windows -ComputerName $vmEXName -Credential $EXcred -ProvisionVMAgent -EnableAutoUpdate 
    $vmExConfig=Set-AZVMSourceImage -VM $vmExConfig -PublisherName MicrosoftWindowsServer -Offer WindowsServer -Skus 2019-Datacenter -Version "latest" 
    $vmExConfig=Add-AZVMNetworkInterface -VM $vmExConfig -Id $EXnic.Id 

    New-AZVM -ResourceGroupName $ResourceGroupName -Location $locationName -VM $vmExConfig 
    '**** Finished - Echange-Edge-01 VM Created ****'


    #Provision The Exchange Virtual Machine - Tested Good
    #Exchange EDGE 2019
    $vmEXName="AZ-EDGE-2019-02" 
    $locationName=(Get-AZResourceGroup -Name $ResourceGroupName).Location 
    $EXcred=Get-Credential -Message "Type the name and password of the local administrator account for $vmEXName. User name: labadmin, Password: LS1Setup!" 
    $vnet=Get-AZVirtualNetwork -Name $ResourceGroupVnetName -ResourceGroupName $ResourceGroupName 

    $nicEXName=$vmEXName + "-NIC" 
    $pipEXName=$vmEXName + "-PublicIP" 
    $EXpip=New-AZPublicIpAddress -Name $pipEXName -ResourceGroupName $ResourceGroupName -Location $locationName -AllocationMethod Dynamic 
    $EXnic=New-AZNetworkInterface -Name $nicEXName -ResourceGroupName $ResourceGroupName -Location $locationName -SubnetId $vnet.Subnets[0].Id -PublicIpAddressId $Expip.id 
    
    $vmExConfig=New-AZVMConfig -VMName $vmEXName -VMSize $ExchangeVirtualMachineSKU 
    $vmExConfig=Set-AZVMOSDisk -VM $vmExConfig -Name ($vmEXName +"-OS") -DiskSizeInGB 128 -CreateOption FromImage -StorageAccountType "Standard_LRS" 
    $vmExConfig=Set-AZVMOperatingSystem -VM $vmExConfig -Windows -ComputerName $vmEXName -Credential $EXcred -ProvisionVMAgent -EnableAutoUpdate 
    $vmExConfig=Set-AZVMSourceImage -VM $vmExConfig -PublisherName MicrosoftWindowsServer -Offer WindowsServer -Skus 2019-Datacenter -Version "latest" 
    $vmExConfig=Add-AZVMNetworkInterface -VM $vmExConfig -Id $EXnic.Id 

    New-AZVM -ResourceGroupName $ResourceGroupName -Location $locationName -VM $vmExConfig 
    '**** Finished - Echange-Edge-02 VM Created ****'


    #Exchange Azure RMS connector 
    $vmEXName="AZ-AIP-01" 
    $MemberVirtualMachineSKU = "Standard_B2s"
    $locationName=(Get-AZResourceGroup -Name $ResourceGroupName).Location 
    $EXcred=Get-Credential -Message "Type the name and password of the local administrator account for $vmEXName. User name: labadmin, Password: LS1Setup!" 
    $vnet=Get-AZVirtualNetwork -Name $ResourceGroupVnetName -ResourceGroupName $ResourceGroupName 

    $nicEXName=$vmEXName + "-NIC" 
    $pipEXName=$vmEXName + "-PublicIP" 
    $EXpip=New-AZPublicIpAddress -Name $pipEXName -ResourceGroupName $ResourceGroupName -Location $locationName -AllocationMethod Dynamic 
    $EXnic=New-AZNetworkInterface -Name $nicEXName -ResourceGroupName $ResourceGroupName -Location $locationName -SubnetId $vnet.Subnets[0].Id -PublicIpAddressId $Expip.id 
    
    $vmExConfig=New-AZVMConfig -VMName $vmEXName -VMSize $MemberVirtualMachineSKU
    $vmExConfig=Set-AZVMOSDisk -VM $vmExConfig -Name ($vmEXName +"-OS") -DiskSizeInGB 128 -CreateOption FromImage -StorageAccountType "Standard_LRS" 
    $vmExConfig=Set-AZVMOperatingSystem -VM $vmExConfig -Windows -ComputerName $vmEXName -Credential $EXcred -ProvisionVMAgent -EnableAutoUpdate 
    $vmExConfig=Set-AZVMSourceImage -VM $vmExConfig -PublisherName MicrosoftWindowsServer -Offer WindowsServer -Skus 2019-Datacenter -Version "latest" 
    $vmExConfig=Add-AZVMNetworkInterface -VM $vmExConfig -Id $EXnic.Id 

    New-AZVM -ResourceGroupName $ResourceGroupName -Location $locationName -VM $vmExConfig 
    '**** Finished - Exchange-Azure-RMS-Conector-01 Created ****'


    #Exchange Azure RMS connector 
    $vmEXName="AZ-AIP-02" 
    $MemberVirtualMachineSKU = "Standard_B2s"
    $locationName=(Get-AZResourceGroup -Name $ResourceGroupName).Location 
    $EXcred=Get-Credential -Message "Type the name and password of the local administrator account for $vmEXName. User name: labadmin, Password: LS1Setup!" 
    $vnet=Get-AZVirtualNetwork -Name $ResourceGroupVnetName -ResourceGroupName $ResourceGroupName 

    $nicEXName=$vmEXName + "-NIC" 
    $pipEXName=$vmEXName + "-PublicIP" 
    $EXpip=New-AZPublicIpAddress -Name $pipEXName -ResourceGroupName $ResourceGroupName -Location $locationName -AllocationMethod Dynamic 
    $EXnic=New-AZNetworkInterface -Name $nicEXName -ResourceGroupName $ResourceGroupName -Location $locationName -SubnetId $vnet.Subnets[0].Id -PublicIpAddressId $Expip.id 
    
    $vmExConfig=New-AZVMConfig -VMName $vmEXName -VMSize $MemberVirtualMachineSKU
    $vmExConfig=Set-AZVMOSDisk -VM $vmExConfig -Name ($vmEXName +"-OS") -DiskSizeInGB 128 -CreateOption FromImage -StorageAccountType "Standard_LRS" 
    $vmExConfig=Set-AZVMOperatingSystem -VM $vmExConfig -Windows -ComputerName $vmEXName -Credential $EXcred -ProvisionVMAgent -EnableAutoUpdate 
    $vmExConfig=Set-AZVMSourceImage -VM $vmExConfig -PublisherName MicrosoftWindowsServer -Offer WindowsServer -Skus 2019-Datacenter -Version "latest" 
    $vmExConfig=Add-AZVMNetworkInterface -VM $vmExConfig -Id $EXnic.Id 

    New-AZVM -ResourceGroupName $ResourceGroupName -Location $locationName -VM $vmExConfig 
    '**** Finished - Exchange-Azure-RMS-Conector-02 Created ****'


}