# Sentinel Triage AssistanT (STAT) :hospital: - Deployment

The deployment of the STAT solution is broken down into 2 steps:

1. Deploying Azure Resources
2. Granting Permissions

## Deploying Azure Resources

The first step to deploying STAT is to deploy the STAT components into a Resource Group in your Azure subscription.  These components consist of Logic Apps, API Connections and a Custom Logic Apps Connector.  For the best experience, all components of the STAT solution should be deployed at one time and as updates are made avaialble the entire solution should be updated together as well.

Consider the permissions on the Resource Group where you deploy STAT and ensure that no unauthorized users have access to the Logic apps.  Since these logic apps will contain information about security incidents that have been analyzed there will be details about these security incidents and related data in the run history.

When deploying STAT you should use a Resource Group within the same subscription and datacenter region as your other Microsoft Sentinel automation Playbooks.  Logic Apps Custom Connectors can only be used from the same subscription and datacenter as they are created in.  If multiple subscriptions or datacenters must be used, STAT can be deployed to each one.

STAT can be deployed/updated via single ARM deployment

### Deployment Template

[![Deploy to Azure](https://aka.ms/deploytoazurebutton)](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Fbriandelmsft%2FSentinelAutomationModules%2Fmain%2FDeploy%2Fazuredeploy.json/createUIDefinitionUri/https%3A%2F%2Fraw.githubusercontent.com%2Fbriandelmsft%2FSentinelAutomationModules%2Fmain%2FDeploy%2FcreateUiDefinition.json)

## Granting Permissions

After the STAT template is deployed it will need to be granted permissions to various APIs and Sentinel itself to operate.  All components of STAT run as System Assigned Managed Identities.

### Grant Permissions

To grant permissions to STAT, use the PowerShell script [GrantPermissions.ps1](/Deploy/GrantPermissions.ps1).  

The following modifications will need to be made to the script

* Set the $TenantID to your [tenant id](https://docs.microsoft.com/azure/active-directory/fundamentals/active-directory-how-to-find-tenant) 
* Set the $AzureSubscriptionId to the Azure Subscription GUID of the **Microsoft Sentinel** subscription
* Set the $SentinelResourceGroupName to the Resource Group Name where **Microsoft Sentinel** resides

Additionally, if you have deployed STAT using custom Logic App names the LogicAppName variables will need to be udpated as well.

STAT Uses the following permissions

|Permission|Type|Description|
|---|---|---|
|Data.Read|Log Analytics API|Execute KQL queries against your Log Analytics workspace|
|User.Read.All|Microsoft Graph API|Read users in the Microsoft Graph to resolve/enrich user data|
|MailboxSettings.Read|Mirosoft Graph API|Read users Out of Office settings|
|RoleManagement.Read.Directory|Microsoft Graph API|Read privileged role information to enrich user data|
|IdentityRiskyUser.Read.All|Microsoft Graph API|Read user risk information from Azure AD Identity Protection|
|AdvancedQuery.Read.All|Microsoft Defender for Endpoint API|Query MDE data|
|Machine.Read.All|Microsoft Defender for Endpoint API|Retrieve Machine inforamtion including risk level|
|investigation.read|Microsoft Defender for Cloud Apps API|Retrieve user investigation priorities|
|AdvancedHunting.Read.All|Microsoft 365 Security API|Execute KQL queries against the Microsoft 365 Security service|
|Microsoft Sentinel Responder|Azure RBAC Role|Gives permissions to update incidents and read data from Sentinel. This is typically used by STAT to add comments to incidents.|


---
[Documentation Home](readme.md)