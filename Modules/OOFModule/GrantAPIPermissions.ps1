#  Install-Module AzureAD # Install the module (You need admin on the machine)

$TenantID=""  #Add your AAD Tenant Id
$DisplayNameOfMSI="Get-OOFDetails" #Name of the Logic App

Connect-AzureAD -TenantId $TenantID
$MSI = (Get-AzureADServicePrincipal -Filter "displayName eq '$DisplayNameOfMSI'")
Start-Sleep -Seconds 5
$GraphAppId = "00000003-0000-0000-c000-000000000000"
$PermissionName = "MailboxSettings.Read" 
$GraphServicePrincipal = Get-AzureADServicePrincipal -Filter "appId eq '$GraphAppId'"
$AppRole = $GraphServicePrincipal.AppRoles | Where-Object {$_.Value -eq $PermissionName -and $_.AllowedMemberTypes -contains "Application"}
New-AzureAdServiceAppRoleAssignment -ObjectId $MSI.ObjectId -PrincipalId $MSI.ObjectId -ResourceId $GraphServicePrincipal.ObjectId -Id $AppRole.Id
