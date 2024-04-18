# Sentinel Triage AssistanT (STAT) :hospital: - Troubleshooting

> [!NOTE]
> STAT documentation is being relocated to the builin [Wiki](https://github.com/briandelmsft/SentinelAutomationModules/wiki)

You will find here the troubleshooting steps for specific situations.

## A module is failing with a 40x error message

This can happen in the following situations:
- You did not run the `GrantPermissions.ps1` to grant the RBAC roles and application permissions.
- You used the modules at least once before executing the `GrantPermissions.ps1` script. The modules are all using [system-assigned managed identity](https://learn.microsoft.com/en-us/azure/active-directory/managed-identities-azure-resources/overview). When managed identities are used through logic apps, they are caching access tokens. If you run the permission script after you already cached a token, it might take up to an hour for managed identity to refresh its token.    

## STAT Logic App Connector prompts for a Function Code

When creating a Logic App in a resource group other than the RG where STAT was deployed, you will be prompted to provide a connection name and a function code.  Connection name is just a descriptive name and could be set to almost any value.  The Function code must be obtained from the STAT Function app and entered in the Function Code text box.

#### Obtaining the Function Code

1.  In the Azure Portal go into the Resource Group where the STAT Function app was deployed
2.  Click on the STAT Function App
3.  Navigate to Functions -> modules
4.  Click the **Get Function Url** button
5.  Copy the function code from the end of the URL.  The code starts immediately after **?code=**

## Microsoft Defender for Cloud Apps fails with *There is no configured endpoint for MDCA*

This module needs the API endpoint of your Microsoft Defender for Cloud Apps tenant. If this was not entered, or entered incorrectly, during the setup of STAT you may run into this error. You can find the correct value in the portal https://portal.cloudappsecurity.com/ by following these steps:

1. Click on the ❔ icone on the top right
2. Click on the About item
3. Copy the FQDN you see from the PORTAL URL section

> Do not include the https:// component, copy the FQDN only.

![image](https://user-images.githubusercontent.com/22434561/153331954-c072f23d-1e3e-4d69-bf1c-448fa27e92ec.png)

4. Navigate to the Azure Portal and into your STAT Function App
5. Click on Configuration
6. Edit the MDCA_ENDPOINT set it to the value obtained above and click Ok
7. Click Save

## GrantPermissions.ps1 permissions failures

The script will fail to set Graph API permissions on the system-assigned managed identities if you use an account which is not a member of the Global Administrator role or User Access Administrator role. See the [deployment documentation](/Deploy#grant-permissions) for more details.

If you run into permissions or consent issues with the GrantPermissions.ps1, you can try using the [LegacyGrantPermissions.ps1](/Deploy/LegacyGrantPermissions.ps1). It leverages the legacy AzureAD PowerShell module and doesn't require explicit consent for the scopes `AppRoleAssignment.ReadWrite.All` and `Application.Read.All`. 

## GrantPermissions.ps1 Missing closing '}'

If you save and run the script on a machine without the MgGraph module installed, you might see a misleading error message suggesting that a missing } prevents the script from running. It is in fact an issue with MgGraph cmdlets not being available.
Make sure you have installed the MgGraph module prior executing the script. You can do so by uncommenting the 5th line of the script:
```
Install-Module Microsoft.Graph.Applications -Scope CurrentUser -Force
```

## LegacyGrantPermissions.ps1 failures

See the following table for specific failure troubleshooting.
|Error|Troubleshooting steps|
|---|---|
|`New-AzureADServiceAppRoleAssignment : Cannot convert 'System.Object[]' to the type 'System.String' required by parameter 'ObjectId'. Specified method is not supported.`|You have more than one logic app with the same name in your Azure subscription. This scenario is not supported with the current version of the script.|

## GCC Medium - No active license found

When using STAT in GCC Medium, you may receive an error within some modules indicating 'No active license found'.  This is due to the incorrect API endpoint being used by the module.  To correct this, deploy STAT using advanced mode and set both the Microsoft 365 Defender API Endpoint and Microsoft Defender for Endpoint API Endpoint to the GCC version of the endpoint.

STAT is not presently supported in GCC High, DoD or other Sovereign clouds.