#  Install-Module AzureAD -Force # Install the module (You need admin on the machine)
#  Install-Module -Name Az -Repository PSGallery -Force  # Install the module (You need admin on the machine)

$TenantID=""  #Add your AAD Tenant Id
$AzureSubscriptionId = "" #Azure Subscrition Id of Sentinel Subscription
$SentinelResourceGroupName = "" #Resource Group Name of Sentinel

$UEBALogicAppName="Get-UEBAInsights"             #Name of the UEBA Logic App
$OOFLogicAppName="Get-OOFDetails"                #Name of the OOF Logic App
$MDELogicAppName="Get-MDEUsersDevicesRiskScore"  #Name of the MDE Logic App
$MCASLogicAppName="Get-MCASInvestigationScore"   #Name of the MCAS Logic App
$RelatedAlertsLogicAppName="Get-RelatedAlerts"   #Name of the Related Alerts Logic App

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
Set-RBACPermissions -MSIName $UEBALogicAppName -Role "Azure Sentinel Responder"

#OOF
Set-APIPermissions -MSIName $OOFLogicAppName -AppId "00000003-0000-0000-c000-000000000000" -PermissionName "MailboxSettings.Read"
Set-RBACPermissions -MSIName $OOFLogicAppName -Role "Azure Sentinel Responder"

#RelatedAlerts
Set-APIPermissions -MSIName $RelatedAlertsLogicAppName -AppId "ca7f3f0b-7d91-482c-8e09-c5d840d0eac5" -PermissionName "Data.Read"
Set-RBACPermissions -MSIName $RelatedAlertsLogicAppName -Role "Azure Sentinel Responder"

#MDE
Set-APIPermissions -MSIName $MDELogicAppName -AppId "00000003-0000-0000-c000-000000000000" -PermissionName "User.Read.All"
Set-APIPermissions -MSIName $MDELogicAppName -AppId "fc780465-2017-40d4-a0c5-307022471b92" -PermissionName "AdvancedQuery.Read.All"
Set-APIPermissions -MSIName $MDELogicAppName -AppId "fc780465-2017-40d4-a0c5-307022471b92" -PermissionName "Machine.Read.All"
Set-RBACPermissions -MSIName $MDELogicAppName -Role "Azure Sentinel Responder"

#MCAS
Set-APIPermissions -MSIName $MCASLogicAppName -AppId "00000003-0000-0000-c000-000000000000" -PermissionName "User.Read.All"
Set-RBACPermissions -MSIName $MCASLogicAppName -Role "Azure Sentinel Responder"

