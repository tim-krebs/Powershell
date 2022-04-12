<#
Copyright (c) 2021 Jan Schaffranek. All rights reserved.

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

Function Gather-Info{
    <#
    .SYNOPSIS
    Collect Details about the computer
    .DESCRIPTION
    This function collects the computer name, operating system, IP addreses and the current date (Format: mm/dd/yyyy)
    .PARAMETER Name
    Specifies the computer name for which the information is collected
    .EXAMPLE
    Gahter-Info -Name localhost
    #>
[CmdletBinding()]
Param()

    # Collect IP Addresses and split the single string into an array of IP's
    $IP4Address=(Get-NetIPAddress).IPAddress
    [array]$IPArray=$IP4Address.split(" ")
    # Collect additional information about the computer from the input parameter
    $PCName=(Get-CimInstance -ClassName Win32_ComputerSystem).Name
    $Make=(Get-CimInstance -ClassName Win32_ComputerSystem).Manufacturer
    $OS=(Get-CimInstance -ClassName Win32_OperatingSystem).Caption
    # Get the current date of the day
    $Today=(Get-Date -Format mm/dd/yyyy)
    
    $ComputerInfo=@{
        ComputerName=$PCName;
        DateOfIP="$Today";
        IPAddress=$IPArray;
        OperatingSystem=$OS;
        Manufacturer="$Make";
        WaranteeExpiration=[DateTime]"06/30/202"
    }

    return $ComputerInfo
}