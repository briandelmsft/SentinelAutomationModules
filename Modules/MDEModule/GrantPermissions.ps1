#  Install-Module AzureAD -Force # Install the module (You need admin on the machine)
#  Install-Module -Name Az -Repository PSGallery -Force  # Install the module (You need admin on the machine)

$TenantID=""  #Add your AAD Tenant Id
$AzureSubscriptionId = "" #Azure Subscrition Id of Sentinel Subscription
$SentinelResourceGroupName = "" #Resource Group Name of Sentinel

$MDELogicAppName="Get-MDEInsights"  #Name of the MDE Logic App

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

#MDE
Set-APIPermissions -MSIName $MDELogicAppName -AppId "00000003-0000-0000-c000-000000000000" -PermissionName "User.Read.All"
Set-APIPermissions -MSIName $MDELogicAppName -AppId "fc780465-2017-40d4-a0c5-307022471b92" -PermissionName "AdvancedQuery.Read.All"
Set-APIPermissions -MSIName $MDELogicAppName -AppId "fc780465-2017-40d4-a0c5-307022471b92" -PermissionName "Machine.Read.All"
Set-RBACPermissions -MSIName $MDELogicAppName -Role "Azure Sentinel Responder"
