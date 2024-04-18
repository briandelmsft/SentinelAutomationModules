# Deploy the full solution

This template is used to deploy or update the Microsoft Sentinel Triage AssistanT (STAT) solution.

## Deployment Considerations

The Microsoft Sentinel Triage AssistanT (STAT) creates an Azure Function, API connection, and a Logic Apps Custom Connector.  To use the STAT solution these items must be deployed in the same subscription and datacenter region as the Microsoft Sentinel playbooks which will use the solution.

#### Deploying Multiple Copies of STAT

In most cases it is only necessary to deploy STAT a single time, but in some circumstances such as if you need to create playbooks using STAT in multiple subscriptions or in multiple data center regions the solution may need to be deployed more than once.  If you must deploy STAT in multiple subscriptions or multiple datacenters it is recommended to use the advanced setup option.

## Upgrade Considerations

To upgrade the Microsoft Sentinel Triage AssistanT you can simply deploy the solution again, using the same settings as your original deployment.  This will update all of the STAT components but will maintain any existing connections to other logic apps you have a built and you will not be required to reassign the permissions as they will also be maintained.  When upgrading an advanced mode deployment, it is important that you use the same configuration as the original deployment.

## Quick Deployment

[![Deploy to Azure](https://aka.ms/deploytoazurebutton)](https://aka.ms/mstatdeploy)

## Post Deployment

### Grant Permissions

* Run [GrantPermissions.ps1](GrantPermissions.ps1) to grant the necessary API and RBAC permissions to the STAT Function deployed by this template.

The GrantPermissions.ps1 script contains 2 types of permissions assignments that are set via PowerShell Functions.  To execute these functions you will require permission:

|Function|Permissions|
|---|---|
|Set-APIPermissions|Calls to this function require the user to be either an Azure AD Global Administrator or Azure AD Privileged Role Administrator|
|Set-RBACPermissions|Calls to this function require the user to be either a Resource Group Owner or User Access Administrator on the Resource Group where Microsoft Sentinel is installed|

> If you do not have a single account with both the necessary Azure AD and Resource group permissions, you can run the Set-APIPermissions and Set-RBACPermissions calls seperately under different accounts.

### Restrict Calls to STAT Function (optional)

By default the STAT function is protected by a unique Shared Access Signature.  However, there are not any default restrictions on which IP addresses this function can be called from and it is possible to restrict it to only allow calls from Logic Apps custom connectors.

To restrict the STAT Function to only accept calls from the Logic apps custom connector:
1. Locate the appropriate IP ranges for your Azure datacenter region [here](https://www.microsoft.com/download/details.aspx?id=56519) under the section **AzureConnectors.&lt;AzureRegion&gt;**
2. Navigate in the Azure Portal to the STAT Function app
3. Locate **Settings -> Networking**
4. Click **Access restriction**
5. Click **+ Add** to add a new restriction
6. Configure the rule with the following properties:

|Field|Value|
|---|---|
|Name|Allow LA Connector|
|Action|Allow|
|Priority|100|
|Description|Allow access from Logic app custom connector|
|Type|Service Tag|
|Service Tag|AzureConnector.<YourRegion>|

7. Click **Add rule**

> Note: To maintain these IP restrictions, these steps will need to be repeated when updating the STAT solution.
