# Sentinel Triage AssistanT (STAT) :hospital: - Deployment

The deployment of the STAT solution is broken down into 2 steps:

1. Deploying Azure Resources
2. Granting Permissions

## Deploying Azure Resources

The first step to deploying STAT is to deploy the STAT components into a Resource Group in your Azure subscription.  These components consist of an Azure Function, API Connections and a Custom Logic Apps Connector.  While seperate ARM templates exist for components of the STAT solution, it should be deployed through the single ARM template available below.

Consider the permissions on the Resource Group where you deploy STAT and ensure that no unauthorized users have access to the resources.  Since these resources will contain information about security incidents that have been analyzed which may contain private or sensitive information.

When deploying STAT you should use a Resource Group within the same subscription and datacenter region as your other Microsoft Sentinel automation Playbooks.  Logic Apps Custom Connectors can only be used from the same subscription and datacenter as they are created in.  If multiple subscriptions or datacenters must be used, STAT can be deployed to each one.

STAT can be deployed/updated via single ARM deployment

### Deployment Template

[![Deploy to Azure](https://aka.ms/deploytoazurebutton)](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Fbriandelmsft%2FSentinelAutomationModules%2Fstatv2_preview%2FDeploy%2Fstatdeploy.json/createUIDefinitionUri/https%3A%2F%2Fraw.githubusercontent.com%2Fbriandelmsft%2FSentinelAutomationModules%2Fstatv2_preview%2FDeploy%2Fdeployui.json)

## Identity Configuration

STAT can be deployed using any of the following identity types

*   System Assigned Managed Identity
*   User Assigned Managed Identity
*   Service Principal Identity

For MSSPs or other Multi Tenant environments, you will need to deploy STAT using a Multi Tenant Service Principal Identity if you wish to centrally run your automation.  For Single Tenant use, we recommend using a System Assigned Managed Identity, but any other supported identity type will work in a single tenant deployment.

## Post Deloyment

After the STAT template is deployed it will need to be granted permissions to various APIs and Sentinel itself to operate.

### Grant Permissions

To grant permissions to STAT, use the PowerShell script [GrantPermissions.ps1](/Deploy/GrantPermissions.ps1).  

The following modifications will need to be made to the script

* Set the $TenantID to your [tenant id](https://docs.microsoft.com/azure/active-directory/fundamentals/active-directory-how-to-find-tenant) 
* Set the $AzureSubscriptionId to the Azure Subscription GUID of the **Microsoft Sentinel** subscription
* Set the $SentinelResourceGroupName to the Resource Group Name where **Microsoft Sentinel** resides
* Set the $STATIdentityName to the name of the identity you deployed STAT using.  If using a System assigned managed identity, this will be the name of the Azure Function app


The GrantPermissions.ps1 script contains 2 types of permissions assignments that are set via PowerShell Functions.  To execute these functions you will require permission:

|Function|Permissions|
|---|---|
|Set-APIPermissions|Calls to this function require the user to be either an Azure AD Global Administrator or Azure AD Privileged Role Administrator|
|Set-RBACPermissions|Calls to this function require the user to be either a Resource Group Owner or User Access Administrator on the Resource Group where Microsoft Sentinel is installed|

> If you do not have a single account with both the necessary Azure AD and Resource group permissions, you can run the Set-APIPermissions and Set-RBACPermissions calls seperately under different accounts.

STAT Uses the following permissions

|Permission|Type|Description|
|---|---|---|
|Data.Read|Log Analytics API|Execute KQL queries against your Log Analytics workspace|
|Directory.Read.All|Microsoft Graph API|Read Azure AD data in the Microsoft Graph to resolve/enrich entities|
|MailboxSettings.Read|Mirosoft Graph API|Read users Out of Office settings|
|RoleManagement.Read.Directory|Microsoft Graph API|Read privileged role information to enrich user data|
|IdentityRiskyUser.Read.All|Microsoft Graph API|Read user risk information from Azure AD Identity Protection|
|AdvancedQuery.Read.All|Microsoft Defender for Endpoint API|Query MDE data|
|Machine.Read.All|Microsoft Defender for Endpoint API|Retrieve Machine inforamtion including risk level|
|File.Read.All|Microsoft Defender for Endpoint API|Retrieve file information including known threats and GlobalPrevalence|
|investigation.read|Microsoft Defender for Cloud Apps API|Retrieve user investigation priorities|
|AdvancedHunting.Read.All|Microsoft 365 Security API|Execute KQL queries against the Microsoft 365 Security service|
|Microsoft Sentinel Responder|Azure RBAC Role|Gives permissions to update incidents and read data from Sentinel. This is typically used by STAT to add comments to incidents.|

### Restrict Calls to STAT Coordinator (optional)

All STAT modules, except the STAT Coordinator, are restricted to only being called from a Logic Apps IP and with a valid Shared Access Signature.  However, by default the STAT coordinator is only protected by the Shared Access Signature.  This is due to the Logic Apps Custom connector using IP addresses outside of the standard Logic Apps IP ranges.

To restrict the STAT coordinator to only accept calls from the Logic apps custom connector:
1. Locate the appropriate IP ranges for your Azure datacenter region [here](https://www.microsoft.com/download/details.aspx?id=56519) under the section **AzureConnectors.&lt;AzureRegion&gt;**
2. Navigate in the Azure Portal to the **STAT-Coordinator** logic app
3. Locate **Settings -> Workflow settings**
4. Change the drop down menu from **Any IP** to **Specific IP ranges**
5. Add the IP ranges obtained in step 1
6. **Save**

> Note: To maintain these IP restrictions, these steps will need to be repeated when updating the STAT solution.


---
[Documentation Home](readme.md)
