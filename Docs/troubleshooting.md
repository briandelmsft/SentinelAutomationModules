# Sentinel Triage AssistanT (STAT) :hospital: - Troubleshooting

You will find here the troubleshooting steps for specific situations.

## A module is failing with a 40x error message

This can happen in the following situations:
- You did not run the `GrantPermissions.ps1` to grant the RBAC roles and application permissions.
- You used the modules at least once before executing the `GrantPermissions.ps1` script. The modules are all using [system-assigned managed identity](https://learn.microsoft.com/en-us/azure/active-directory/managed-identities-azure-resources/overview). When managed identities are used through logic apps, they are caching access tokens. If you run the permission script after you already cached a token, it might take up to an hour for managed identity to refresh its token.    

## The Get-MCASInvestigationScore is intermittently failing

Contrary to the other modules, the MCAS (Microsoft Defender for Cloud Apps) module has a [Post Deployment task](Modules/MCASModule). You need to specify the API URL for your own tenant. If you do not provide it, the module is trying to find it by trying various regions but this is a best-effort strategy.

Note that you can leverage the [Sentinel Triage AssistanT - Status workbook](/Workbook) to check for execution failure rates for all your modules at once.

## GrantPermissions.ps1 failures

The script will fail to set Graph API permissions on the system-assigned managed identities if you use an account which is not a member of the Global Administrator role or User Access Administrator role. See the [deployment documentation](Deploy#grant-permissions) for more details.

If you run into permissions or consent issues with the GrantPermissions.ps1, you can try using the [LegacyGrantPermissions.ps1](/Deploy/LegacyGrantPermissions.ps1). It leverages the legacy AzureAD PowerShell module and doesn't require explicit consent for the scope `AppRoleAssignment.ReadWrite.All`. 


## LegacyGrantPermissions.ps1 failures

See the following table for specific failure troubleshooting.
|Error|Troubleshooting steps|
|---|---|
|`New-AzureADServiceAppRoleAssignment : Cannot convert 'System.Object[]' to the type 'System.String' required by parameter 'ObjectId'. Specified method is not supported.`|You have more than one logic app with the same name in your Azure subscription. This scenario is not supported with the current version of the script.|
