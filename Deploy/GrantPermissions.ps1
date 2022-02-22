#  Install-Module AzureAD -Force # Install the module (You need admin on the machine)
#  Install-Module -Name Az -Repository PSGallery -Force  # Install the module (You need admin on the machine)

$TenantID=""  #Add your AAD Tenant Id
$AzureSubscriptionId = "" #Azure Subscrition Id of Sentinel Subscription
$SentinelResourceGroupName = "" #Resource Group Name of Sentinel

$AADLogicAppName="Get-AADUserRisksInfo"          #Name of the AAD Risks Logic App
$BaseLogicAppName="Base-Module"                  #Name of the Base Module
$FileLogicAppName="Get-FileInsights"             #Name of the FileInsights Logic App
$KQLLogicAppName="Run-KQLQuery"                  #Name of the KQL Query Logic App
$UEBALogicAppName="Get-UEBAInsights"             #Name of the UEBA Logic App
$OOFLogicAppName="Get-OOFDetails"                #Name of the OOF Logic App
$MDELogicAppName="Get-MDEInsights"               #Name of the MDE Logic App
$MCASLogicAppName="Get-MCASInvestigationScore"   #Name of the MCAS Logic App
$RelatedAlertsLogicAppName="Get-RelatedAlerts"   #Name of the Related Alerts Logic App
$TILogicAppName="Get-ThreatIntel"                #Name of the TI Logic App
$WatchlistLogicAppName="Get-WatchlistInsights"   #Name of the Watchlists Logic App

$SampleLogicAppName="Sample-STAT-Triage"      #Name of the Sample Logic App

Connect-AzureAD -TenantId $TenantID
Login-AzAccount
Set-AzContext -Subscription $AzureSubscriptionId

function Set-APIPermissions ($MSIName, $AppId, $PermissionName) {
    $MSI = Get-AppIds -AppName $MSIName
    Start-Sleep -Seconds 2
    $GraphServicePrincipal = Get-AzureADServicePrincipal -Filter "appId eq '$AppId'"
    $AppRole = $GraphServicePrincipal.AppRoles | Where-Object {$_.Value -eq $PermissionName -and $_.AllowedMemberTypes -contains "Application"}
    New-AzureAdServiceAppRoleAssignment -ObjectId $MSI.ObjectId -PrincipalId $MSI.ObjectId -ResourceId $GraphServicePrincipal.ObjectId -Id $AppRole.Id
}

function Get-AppIds ($AppName) {
    Get-AzureADServicePrincipal -Filter "displayName eq '$AppName'"
}

function Set-RBACPermissions ($MSIName, $Role) {
    $MSI = Get-AppIds -AppName $MSIName
    New-AzRoleAssignment -ApplicationId $MSI.AppId -Scope "/subscriptions/$($AzureSubscriptionId)/resourceGroups/$($SentinelResourceGroupName)" -RoleDefinitionName $Role
}

#UEBA
Set-APIPermissions -MSIName $UEBALogicAppName -AppId "ca7f3f0b-7d91-482c-8e09-c5d840d0eac5" -PermissionName "Data.Read"
Set-RBACPermissions -MSIName $UEBALogicAppName -Role "Microsoft Sentinel Responder"

#OOF
Set-APIPermissions -MSIName $OOFLogicAppName -AppId "00000003-0000-0000-c000-000000000000" -PermissionName "MailboxSettings.Read"
Set-RBACPermissions -MSIName $OOFLogicAppName -Role "Microsoft Sentinel Responder"

#RelatedAlerts
Set-APIPermissions -MSIName $RelatedAlertsLogicAppName -AppId "ca7f3f0b-7d91-482c-8e09-c5d840d0eac5" -PermissionName "Data.Read"
Set-RBACPermissions -MSIName $RelatedAlertsLogicAppName -Role "Microsoft Sentinel Responder"

#MDE
Set-APIPermissions -MSIName $MDELogicAppName -AppId "00000003-0000-0000-c000-000000000000" -PermissionName "User.Read.All"
Set-APIPermissions -MSIName $MDELogicAppName -AppId "fc780465-2017-40d4-a0c5-307022471b92" -PermissionName "AdvancedQuery.Read.All"
Set-APIPermissions -MSIName $MDELogicAppName -AppId "fc780465-2017-40d4-a0c5-307022471b92" -PermissionName "Machine.Read.All"
Set-RBACPermissions -MSIName $MDELogicAppName -Role "Microsoft Sentinel Responder"

#MCAS
Set-APIPermissions -MSIName $MCASLogicAppName -AppId "05a65629-4c1b-48c1-a78b-804c4abdd4af" -PermissionName "investigation.read"
Set-RBACPermissions -MSIName $MCASLogicAppName -Role "Microsoft Sentinel Responder"

#Watchlists
Set-APIPermissions -MSIName $WatchlistLogicAppName -AppId "ca7f3f0b-7d91-482c-8e09-c5d840d0eac5" -PermissionName "Data.Read"
Set-RBACPermissions -MSIName $WatchlistLogicAppName -Role "Microsoft Sentinel Responder"

#Base module
Set-APIPermissions -MSIName $BaseLogicAppName -AppId "00000003-0000-0000-c000-000000000000" -PermissionName "User.Read.All"
Set-APIPermissions -MSIName $BaseLogicAppName -AppId "00000003-0000-0000-c000-000000000000" -PermissionName "RoleManagement.Read.Directory"
Set-RBACPermissions -MSIName $BaseLogicAppName -Role "Microsoft Sentinel Responder"

#File module
Set-APIPermissions -MSIName $FileLogicAppName -AppId "8ee8fdad-f234-4243-8f3b-15c294843740" -PermissionName "AdvancedHunting.Read.All"
Set-RBACPermissions -MSIName $FileLogicAppName -Role "Microsoft Sentinel Responder"

#KQL module
Set-APIPermissions -MSIName $KQLLogicAppName -AppId "ca7f3f0b-7d91-482c-8e09-c5d840d0eac5" -PermissionName "Data.Read"
Set-APIPermissions -MSIName $KQLLogicAppName -AppId "8ee8fdad-f234-4243-8f3b-15c294843740" -PermissionName "AdvancedHunting.Read.All"
Set-RBACPermissions -MSIName $KQLLogicAppName -Role "Microsoft Sentinel Responder"

#AADRisksModule
Set-APIPermissions -MSIName $AADLogicAppName -AppId "ca7f3f0b-7d91-482c-8e09-c5d840d0eac5" -PermissionName "Data.Read"
Set-APIPermissions -MSIName $AADLogicAppName -AppId "00000003-0000-0000-c000-000000000000" -PermissionName "User.Read.All"
Set-APIPermissions -MSIName $AADLogicAppName -AppId "00000003-0000-0000-c000-000000000000" -PermissionName "IdentityRiskyUser.Read.All"
Set-RBACPermissions -MSIName $AADLogicAppName -Role "Microsoft Sentinel Responder"

#TI
Set-APIPermissions -MSIName $TILogicAppName -AppId "ca7f3f0b-7d91-482c-8e09-c5d840d0eac5" -PermissionName "Data.Read"
Set-RBACPermissions -MSIName $TILogicAppName -Role "Microsoft Sentinel Responder"

#Triage-Content Sample
Set-RBACPermissions -MSIName $SampleLogicAppName -Role "Microsoft Sentinel Responder"
