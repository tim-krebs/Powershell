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


# ***** PowerShell Script to retrieve Details about the desktop *****

# Define path where report log should created
$Location = "C:\Users\timkrebs\Desktop"

# Retrieve desktop settings
$desktop = Get-CimInstance -ClassName Win32_Desktop

# Retrieve BIOS Information 
$bios = Get-CimInstance -ClassName Win32_ComputerSystem | Select-Object -Property SystemType

# Gahter processor details
$processor = Get-CimINstance -ClassName Win32_Processor 

# Get Computer Manufacturer Details 
$manufacturer = Get-CimInstance -ClassName Win32_ComputerSystem

# Get installed Hotfixes 
$hotfixes = Get-CimInstance -ClassName Win32_QuickFixEngineering

# Get OS Version Information
$os = Get-CimInstance -ClassName Win32_OperatingSystem | `
    Select-Object -Property BuildNumber,BuildType,OSType,ServicePackMajorVersion,ServicePackMinorVersion

# Get Users and Owners
$usergroups = Get-CimInstance -ClassName Win32_OperatingSystem | `
    Select-Object -Property NumberOfLicensedUsers,NumberOfUsers,RegisteredUser

# Get currently Logged-On Users
$loggedOn = Get-CimInstance -ClassName Win32_ComputerSystem -Property UserName

# Get all Service status
$services = Get-CimInstance -ClassName Win32_Service | Select-Object -Property Status,Name,DisplayName


# Create Log-File
$report = "$($Location)\Report.log"
New-Item $report -ItemType File -Value "Desktop_Report"
Add-Content $report "********** Desktop Details **********"
Add-Content $report $desktop
Add-Content $report "********** BIOS Details **********"
Add-Content $report $bios
Add-Content $report "********** Processor Details **********"
Add-Content $report $processor
Add-Content $report "********** Manufacturer Details **********"
Add-Content $report $manufacturer
Add-Content $report "********** Hotfix Details **********"
Add-Content $report $hotfixes
Add-Content $report "********** Operating System Details **********"
Add-Content $report $os
Add-Content $report "********** Desktop Details **********"
Add-Content $report $usergr # working on
Add-Content $report "********** Logged On User Details **********"
Add-Content $report $loggedOn
Add-Content $report "********** Services Details **********"
Add-Content $report $services