# Required PowerShell modules:
#  - MgGraph to grant MSI permissions using the Microsoft Graph API
#  - Az grant permissons on Azure resources
# To install the pre-requisites, uncomment the following two lines:
#  Install-Module Microsoft.Graph.Applications -Scope CurrentUser -Force
#  Install-Module -Name Az.Resources -Scope CurrentUser -Repository PSGallery -Force

# Required Permissions
#  - Azure AD Global Administrator or an Azure AD Privileged Role Administrator to execute the Set-APIPermissions function
#  - Resource Group Owner or User Access Administrator on the Microsoft Sentinel resource group to execute the Set-RBACPermissions function you will need either 

# Enter your tenant and subscrition details below:
$TenantId = ""
$AzureSubscriptionId = ""
$SentinelResourceGroupName = "" # Resource Group Name where the Sentinel workspace is

# If you have changed the default name of the logic apps, update the names below:
$AADLogicAppName = "Get-AADUserRisksInfo"          # Name of the AAD Risks Logic App
$BaseLogicAppName = "Base-Module"                  # Name of the Base Module
$FileLogicAppName = "Get-FileInsights"             # Name of the FileInsights Logic App
$KQLLogicAppName = "Run-KQLQuery"                  # Name of the KQL Query Logic App
$UEBALogicAppName = "Get-UEBAInsights"             # Name of the UEBA Logic App
$OOFLogicAppName = "Get-OOFDetails"                # Name of the OOF Logic App
$MDELogicAppName = "Get-MDEInsights"               # Name of the MDE Logic App
$MCASLogicAppName = "Get-MCASInvestigationScore"   # Name of the MCAS Logic App
$RelatedAlertsLogicAppName = "Get-RelatedAlerts"   # Name of the Related Alerts Logic App
$RunPlaybookLogicAppName = "Run-Playbook"          # Name of the Run-Playbook Logic App
$ScoringLogicAppName = "Calculate-RiskScore"       # Name of the Risk Scoring Logic App
$TILogicAppName = "Get-ThreatIntel"                # Name of the TI Logic App
$WatchlistLogicAppName = "Get-WatchlistInsights"   # Name of the Watchlists Logic App

# Additional options
$LogicAppPrefix = ""                               # Adds a prefix to all Logic App names

# Connect to the Microsoft Graph API and Azure Management API
Write-Host "⚙️ Connect to the Azure AD tenant: $TenantId"
Connect-MgGraph -TenantId $TenantId -Scopes Application.ReadWrite.All | Out-Null
Write-Host "⚙️ Connecting to  to the Azure subscription: $AzureSubscriptionId"
try
{
    Login-AzAccount -Subscription $AzureSubscriptionId -Tenant $TenantId -ErrorAction Stop | Out-Null
}
catch
{
    Write-Host "⛔ Login to Azure Management failed. $($error[0])"
}

function Set-APIPermissions ($MSIName, $AppId, $PermissionName) {
    Write-Host "⚙️ Setting permission $PermissionName on $MSIName"
    $MSI = Get-AppIds -AppName $MSIName
    if ( $MSI.count -gt 1 )
    {
        Write-Host "`t❌ Found multiple principals with the same name." -ForegroundColor Red
        return 
    } 
    Start-Sleep -Seconds 2 # Wait in case the MSI identity creation tool some time
    $GraphServicePrincipal = Get-MgServicePrincipal -Filter "appId eq '$AppId'"
    $AppRole = $GraphServicePrincipal.AppRoles | Where-Object {$_.Value -eq $PermissionName -and $_.AllowedMemberTypes -contains "Application"}
    try
    {
        New-MgServicePrincipalAppRoleAssignment -ServicePrincipalId $MSI.Id -PrincipalId $MSI.Id -ResourceId $GraphServicePrincipal.Id -AppRoleId $AppRole.Id -ErrorAction Stop | Out-Null
    }
    catch
    {
        Write-Host "❌ $($_.Exception.Message)" -ForegroundColor Red
        return
    }
    Write-Host "✅ Permission granted" -ForegroundColor Green
}

function Get-AppIds ($AppName) {
    Get-MgServicePrincipal -Filter "displayName eq '$AppName'"
}

function Set-RBACPermissions ($MSIName, $Role) {
    Write-Host "⚙️ Adding $Role to $MSIName"
    $MSI = Get-AppIds -AppName $MSIName
    if ( $MSI.count -gt 1 )
    {
        Write-Host "❌ Found multiple principals with the same name." -ForegroundColor Red
        return 
    }
    $Assign = New-AzRoleAssignment -ApplicationId $MSI.AppId -Scope "/subscriptions/$($AzureSubscriptionId)/resourceGroups/$($SentinelResourceGroupName)" -RoleDefinitionName $Role -ErrorAction SilentlyContinue -ErrorVariable AzError
    if ( $Assign -ne $null )
    {
        Write-Host "✅ Role added" -ForegroundColor Green
    } else {
        Write-Host "❌ $($AzError[0].Exception.Message)" -ForegroundColor Red
    }
}

#UEBA
Set-APIPermissions -MSIName $LogicAppPrefix$UEBALogicAppName -AppId "ca7f3f0b-7d91-482c-8e09-c5d840d0eac5" -PermissionName "Data.Read"
Set-RBACPermissions -MSIName $LogicAppPrefix$UEBALogicAppName -Role "Microsoft Sentinel Responder"

#OOF
Set-APIPermissions -MSIName $LogicAppPrefix$OOFLogicAppName -AppId "00000003-0000-0000-c000-000000000000" -PermissionName "MailboxSettings.Read"
Set-RBACPermissions -MSIName $LogicAppPrefix$OOFLogicAppName -Role "Microsoft Sentinel Responder"

#RelatedAlerts
Set-APIPermissions -MSIName $LogicAppPrefix$RelatedAlertsLogicAppName -AppId "ca7f3f0b-7d91-482c-8e09-c5d840d0eac5" -PermissionName "Data.Read"
Set-RBACPermissions -MSIName $LogicAppPrefix$RelatedAlertsLogicAppName -Role "Microsoft Sentinel Responder"

#MDE
Set-APIPermissions -MSIName $LogicAppPrefix$MDELogicAppName -AppId "00000003-0000-0000-c000-000000000000" -PermissionName "User.Read.All"
Set-APIPermissions -MSIName $LogicAppPrefix$MDELogicAppName -AppId "fc780465-2017-40d4-a0c5-307022471b92" -PermissionName "AdvancedQuery.Read.All"
Set-APIPermissions -MSIName $LogicAppPrefix$MDELogicAppName -AppId "fc780465-2017-40d4-a0c5-307022471b92" -PermissionName "Machine.Read.All"
Set-RBACPermissions -MSIName $LogicAppPrefix$MDELogicAppName -Role "Microsoft Sentinel Responder"

#MCAS
Set-APIPermissions -MSIName $LogicAppPrefix$MCASLogicAppName -AppId "05a65629-4c1b-48c1-a78b-804c4abdd4af" -PermissionName "investigation.read"
Set-RBACPermissions -MSIName $LogicAppPrefix$MCASLogicAppName -Role "Microsoft Sentinel Responder"

#Watchlists
Set-APIPermissions -MSIName $LogicAppPrefix$WatchlistLogicAppName -AppId "ca7f3f0b-7d91-482c-8e09-c5d840d0eac5" -PermissionName "Data.Read"
Set-RBACPermissions -MSIName $LogicAppPrefix$WatchlistLogicAppName -Role "Microsoft Sentinel Responder"

#Base module
Set-APIPermissions -MSIName $LogicAppPrefix$BaseLogicAppName -AppId "00000003-0000-0000-c000-000000000000" -PermissionName "User.Read.All"
Set-APIPermissions -MSIName $LogicAppPrefix$BaseLogicAppName -AppId "00000003-0000-0000-c000-000000000000" -PermissionName "Reports.Read.All"
Set-APIPermissions -MSIName $LogicAppPrefix$BaseLogicAppName -AppId "00000003-0000-0000-c000-000000000000" -PermissionName "RoleManagement.Read.Directory"
Set-RBACPermissions -MSIName $LogicAppPrefix$BaseLogicAppName -Role "Microsoft Sentinel Responder"

#File module
Set-APIPermissions -MSIName $LogicAppPrefix$FileLogicAppName -AppId "8ee8fdad-f234-4243-8f3b-15c294843740" -PermissionName "AdvancedHunting.Read.All"
Set-RBACPermissions -MSIName $LogicAppPrefix$FileLogicAppName -Role "Microsoft Sentinel Responder"

#KQL module
Set-APIPermissions -MSIName $LogicAppPrefix$KQLLogicAppName -AppId "ca7f3f0b-7d91-482c-8e09-c5d840d0eac5" -PermissionName "Data.Read"
Set-APIPermissions -MSIName $LogicAppPrefix$KQLLogicAppName -AppId "8ee8fdad-f234-4243-8f3b-15c294843740" -PermissionName "AdvancedHunting.Read.All"
Set-RBACPermissions -MSIName $LogicAppPrefix$KQLLogicAppName -Role "Microsoft Sentinel Responder"

#AADRisksModule
Set-APIPermissions -MSIName $LogicAppPrefix$AADLogicAppName -AppId "ca7f3f0b-7d91-482c-8e09-c5d840d0eac5" -PermissionName "Data.Read"
Set-APIPermissions -MSIName $LogicAppPrefix$AADLogicAppName -AppId "00000003-0000-0000-c000-000000000000" -PermissionName "User.Read.All"
Set-APIPermissions -MSIName $LogicAppPrefix$AADLogicAppName -AppId "00000003-0000-0000-c000-000000000000" -PermissionName "IdentityRiskyUser.Read.All"
Set-RBACPermissions -MSIName $LogicAppPrefix$AADLogicAppName -Role "Microsoft Sentinel Responder"

#TI
Set-APIPermissions -MSIName $LogicAppPrefix$TILogicAppName -AppId "ca7f3f0b-7d91-482c-8e09-c5d840d0eac5" -PermissionName "Data.Read"
Set-RBACPermissions -MSIName $LogicAppPrefix$TILogicAppName -Role "Microsoft Sentinel Responder"

#Triage-Content Sample
Set-RBACPermissions -MSIName $LogicAppPrefix$SampleLogicAppName -Role "Microsoft Sentinel Responder"

#Calculate-RiskScore
Set-RBACPermissions -MSIName $LogicAppPrefix$ScoringLogicAppName -Role "Microsoft Sentinel Responder"

#Run-Playbook
Set-RBACPermissions -MSIName $LogicAppPrefix$RunPlaybookLogicAppName -Role "Microsoft Sentinel Responder"

Write-Host "⚙️ End of the script. Please review the output and check for potential failures."
