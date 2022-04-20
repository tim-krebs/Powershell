function Sync-UsersInCsvFileToAzdo{
    <#
   .SYNOPSIS
   Adding, removing and upgrade user and license to azure devops
   .DESCRIPTION
   This function reads a csv-file and updates the users license 
   .PARAMETER Name
   <CSVPath>   Specify the filepath to the csv-file
   .EXAMPLE
   Sync-UsersInCsvFileToAzdo -CSVPath "<PathToCsvFile>"
   #>

   param( 
       [Parameter(Mandatory=$true)]
       [string]$CSVPath

   )

   'Import data from CSV file...'
   $csvdata = Import-Csv $CSVPath

   # declare variables to store data
   $EMAIL = @()
   $LICENSE = @()
   $ACTION = @()
   $ORAGNIZATION = @()
   
   # Store data in arrays
   $csvdata | ForEach-Object {
       $EMAIL += $_.EMAIL
       $LICENSE += $_.LICENSE
       $ACTION += $_.ACTION
       $ORAGNIZATION += $_.ORAGNIZATION
   }

   # Login into your Account
   'Connect to your Azure-Account...'
   az login
   # Azure DevOps Token: 2e7wkozira7abh3h6uqbofgymmypxt7v3rpryddwaps4j6hpfnrq


   # Adding or removing user to Azure DevOps
   $i = 0
   foreach($LINE in $csvdata){
       if($ACTION[$i] -eq "ADD"){ #add muss ein string compare sein 
           az devops user add --email-id $EMAIL[$i] --license-type $LICENSE[$i] --org $ORAGNIZATION[$i]
           "User: $($EMAIL[$i]) with License: $($LICENSE[$i]) assigned to Organization: $($ORAGNIZATION[$i]) added to Azure." 
       }
       elseif($ACTION[$i] -eq "REMOVE"){
           az devops user remove --user $EMAIL[$i] --org $ORAGNIZATION[$i]
           "User: $($EMAIL[$i]) assigned to Organization: $($ORAGNIZATION[$i]) removed from Azure."
       }
       elseif($ACTION[$i] -eq "UPDATE"){
           #az devops user update --license-type $LICENSE[$i] --user $EMAIL[$i] --org $ORAGNIZATION[$i]
           az devops user update --license-type $LICENSE[$i] --user $EMAIL[$i]
           "User: $($EMAIL[$i]) assigned to Organization: $($ORAGNIZATION[$i]) updated License to $($LICENSE[$i])." 
       }
       $i++
   }
}