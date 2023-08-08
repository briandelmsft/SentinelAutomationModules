# Required PowerShell modules:
#  - MgGraph to grant MSI permissions using the Microsoft Graph API
#  - Az grant permissons on Azure resources
# To install the pre-requisites, uncomment the following two lines:
#  Install-Module Microsoft.Graph.Applications -Scope CurrentUser -Force
#  Install-Module -Name Az.Resources -Scope CurrentUser -Repository PSGallery -Force

#Requires -Modules Microsoft.Graph.Applications, Az.Resources

# Required Permissions
#  - Azure AD Global Administrator or an Azure AD Privileged Role Administrator to execute the Set-APIPermissions function
#  - Resource Group Owner or User Access Administrator on the Microsoft Sentinel resource group to execute the Set-RBACPermissions function

# Enter your tenant and subscrition details below:
$TenantId = ""
$AzureSubscriptionId = ""
$SentinelResourceGroupName = "" # Resource Group Name where the Sentinel workspace is

$STATIdentityName = ""   #Name of identity STAT will be running under
#If using a System assigned managed identity, this will be the name of the function app (do not include .azurewebsites.net)
#If using a User Assigned Managed Identity or service principal, this will be the name of that identity

#Check if modules are installed in case the script is ran interactively from an IDE
if ((Get-Module -ListAvailable -Name Microsoft.Graph.Applications) -eq $null) {
    Write-Host "[-] Make sure the module Microsoft.Graph.Applications is installed. You can use the following command to install it: Install-Module Microsoft.Graph.Applications -Scope CurrentUser -Force" -ForegroundColor Red
    return 
} elseif ((Get-Module -ListAvailable -Name Az.Resources) -eq $null) {
    Write-Host "[-] Make sure the module Az.Resources is installed. You can use the following command to install it: Install-Module -Name Az.Resources -Scope CurrentUser -Repository PSGallery -Force" -ForegroundColor Red
    return 
}


#$SampleLogicAppName="Sample-STAT-Triage"           #Name of the Sample Logic App

# Connect to the Microsoft Graph API and Azure Management API
Write-Host "[+] Connect to the Azure AD tenant: $TenantId"
Connect-MgGraph -TenantId $TenantId -Scopes AppRoleAssignment.ReadWrite.All, Application.Read.All -ErrorAction Stop | Out-Null
Write-Host "[+] Connecting to  to the Azure subscription: $AzureSubscriptionId"
try
{
    Login-AzAccount -Subscription $AzureSubscriptionId -Tenant $TenantId -ErrorAction Stop | Out-Null
}
catch
{
    Write-Host "[-] Login to Azure Management failed. $($error[0])" -ForegroundColor Red
    return
}

function Set-APIPermissions ($MSIName, $AppId, $PermissionName) {
    Write-Host "[+] Setting permission $PermissionName on $MSIName"
    $MSI = Get-AppIds -AppName $MSIName
    if ( $MSI.count -gt 1 )
    {
        Write-Host "[-] Found multiple principals with the same name." -ForegroundColor Red
        return 
    } elseif ( $MSI.count -eq 0 ) {
        Write-Host "[-] Principal not found." -ForegroundColor Red
        return 
    }
    Start-Sleep -Seconds 2 # Wait in case the MSI identity creation take some time
    $GraphServicePrincipal = Get-MgServicePrincipal -Filter "appId eq '$AppId'"
    $AppRole = $GraphServicePrincipal.AppRoles | Where-Object {$_.Value -eq $PermissionName -and $_.AllowedMemberTypes -contains "Application"}
    try
    {
        New-MgServicePrincipalAppRoleAssignment -ServicePrincipalId $MSI.Id -PrincipalId $MSI.Id -ResourceId $GraphServicePrincipal.Id -AppRoleId $AppRole.Id -ErrorAction Stop | Out-Null
    }
    catch
    {
        if ( $_.Exception.Message -eq "Permission being assigned already exists on the object" )
        {
            Write-Host "[-] $($_.Exception.Message)"
        } else {
            Write-Host "[-] $($_.Exception.Message)" -ForegroundColor Red
        }
        return
    }
    Write-Host "[+] Permission granted" -ForegroundColor Green
}

function Get-AppIds ($AppName) {
    Get-MgServicePrincipal -Filter "displayName eq '$AppName'"
}

function Set-RBACPermissions ($MSIName, $Role) {
    Write-Host "Adding $Role to $MSIName"
    $MSI = Get-AppIds -AppName $MSIName
    if ( $MSI.count -gt 1 )
    {
        Write-Host "[-] Found multiple principals with the same name." -ForegroundColor Red
        return 
    } elseif ( $MSI.count -eq 0 ) {
        Write-Host "[-] Principal not found." -ForegroundColor Red
        return 
    }
    $Assign = New-AzRoleAssignment -ApplicationId $MSI.AppId -Scope "/subscriptions/$($AzureSubscriptionId)/resourceGroups/$($SentinelResourceGroupName)" -RoleDefinitionName $Role -ErrorAction SilentlyContinue -ErrorVariable AzError
    if ( $null -ne $Assign )
    {
        Write-Host "[+] Role added" -ForegroundColor Green
    } elseif ( $AzError[0].Exception.Message -like "*Conflict*" ) {
        Write-Host "[-] Role already assigned"
    } else {
        Write-Host "[-] $($AzError[0].Exception.Message)" -ForegroundColor Red
    }
}

Set-RBACPermissions -MSIName $STATIdentityName -Role "Microsoft Sentinel Responder"
Set-APIPermissions -MSIName $STATIdentityName -AppId "ca7f3f0b-7d91-482c-8e09-c5d840d0eac5" -PermissionName "Data.Read"
Set-APIPermissions -MSIName $STATIdentityName -AppId "00000003-0000-0000-c000-000000000000" -PermissionName "MailboxSettings.Read"
Set-APIPermissions -MSIName $STATIdentityName -AppId "fc780465-2017-40d4-a0c5-307022471b92" -PermissionName "AdvancedQuery.Read.All"
Set-APIPermissions -MSIName $STATIdentityName -AppId "fc780465-2017-40d4-a0c5-307022471b92" -PermissionName "Machine.Read.All"
Set-APIPermissions -MSIName $STATIdentityName -AppId "fc780465-2017-40d4-a0c5-307022471b92" -PermissionName "File.Read.All"
Set-APIPermissions -MSIName $STATIdentityName -AppId "05a65629-4c1b-48c1-a78b-804c4abdd4af" -PermissionName "investigation.read"
Set-APIPermissions -MSIName $STATIdentityName -AppId "00000003-0000-0000-c000-000000000000" -PermissionName "Directory.Read.All"
Set-APIPermissions -MSIName $STATIdentityName -AppId "00000003-0000-0000-c000-000000000000" -PermissionName "Reports.Read.All"
Set-APIPermissions -MSIName $STATIdentityName -AppId "00000003-0000-0000-c000-000000000000" -PermissionName "RoleManagement.Read.Directory"
Set-APIPermissions -MSIName $STATIdentityName -AppId "8ee8fdad-f234-4243-8f3b-15c294843740" -PermissionName "AdvancedHunting.Read.All"
Set-APIPermissions -MSIName $STATIdentityName -AppId "00000003-0000-0000-c000-000000000000" -PermissionName "IdentityRiskyUser.Read.All"


#Triage-Content Sample
#Set-RBACPermissions -MSIName $SampleLogicAppName -Role "Microsoft Sentinel Responder"


Write-Host "[+] End of the script. Please review the output and check for potential failures."
