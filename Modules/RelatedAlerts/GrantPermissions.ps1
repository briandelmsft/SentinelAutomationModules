#  Install-Module AzureAD -Force # Install the module (You need admin on the machine)
#  Install-Module -Name Az -Repository PSGallery -Force  # Install the module (You need admin on the machine)

$TenantID=""  #Add your AAD Tenant Id
$AzureSubscriptionId = "" #Azure Subscrition Id of Sentinel Subscription
$SentinelResourceGroupName = "" #Resource Group Name of Sentinel

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

#RelatedAlerts
Set-APIPermissions -MSIName $RelatedAlertsLogicAppName -AppId "ca7f3f0b-7d91-482c-8e09-c5d840d0eac5" -PermissionName "Data.Read"
Set-RBACPermissions -MSIName $RelatedAlertsLogicAppName -Role "Azure Sentinel Responder"
