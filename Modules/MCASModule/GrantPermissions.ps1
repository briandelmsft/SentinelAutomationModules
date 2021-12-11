#  Install-Module AzureAD -Force # Install the module (You need admin on the machine)
#  Install-Module -Name Az -Repository PSGallery -Force  # Install the module (You need admin on the machine)

$TenantID=""  #Add your AAD Tenant Id
$AzureSubscriptionId = "" #Azure Subscrition Id of Sentinel Subscription
$SentinelResourceGroupName = "" #Resource Group Name of Sentinel

$MCASLogicAppName="Get-MCASInvestigationScore"   #Name of the MCAS Logic App

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

#MCAS
Set-RBACPermissions -MSIName $MCASLogicAppName -Role "Microsoft Sentinel Responder"
Set-APIPermissions -MSIName $MCASLogicAppName -AppId "05a65629-4c1b-48c1-a78b-804c4abdd4af" -PermissionName "investigation.read"
