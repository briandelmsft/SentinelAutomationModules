#  Install-Module AzureAD # Install the module (You need admin on the machine)

$TenantID=""  #Add your AAD Tenant Id
$DisplayNameOfMSI="Get-UEBAEvents" #Name of the Logic App

Connect-AzureAD -TenantId $TenantID
$MSI = (Get-AzureADServicePrincipal -Filter "displayName eq '$DisplayNameOfMSI'")
Start-Sleep -Seconds 5
$GraphAppId = "ca7f3f0b-7d91-482c-8e09-c5d840d0eac5"
$PermissionName = "Data.Read" 
$GraphServicePrincipal = Get-AzureADServicePrincipal -Filter "appId eq '$GraphAppId'"
$AppRole = $GraphServicePrincipal.AppRoles | Where-Object {$_.Value -eq $PermissionName -and $_.AllowedMemberTypes -contains "Application"}
New-AzureAdServiceAppRoleAssignment -ObjectId $MSI.ObjectId -PrincipalId $MSI.ObjectId -ResourceId $GraphServicePrincipal.ObjectId -Id $AppRole.Id
