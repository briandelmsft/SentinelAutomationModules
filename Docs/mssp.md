# Sentinel Triage AssistanT (STAT) :hospital: - MSSP / Multi Tenant Deployments

With the introduction of STAT v2 we have added support for Multi Tenant Service Principal Authentication to enable MSSP and other organizations with multiple tenants to run STAT in a centralized location, while accessing services in another Azure Ad tenant.

## Prerequisites

* Create a Multi tenant Service Principal in the central tenant
* Run the GrantPermissions.ps1 against this service principal
* Grant consent in the customer/other tenants to this Service Principal
* Deploy STAT v2 (Preview build 1.5.0 or later) using the Service Principal as the Identity type during the deployment

## Identify the AAD tenant to run STAT against

By default STAT will execute its API calls against the tenant where it is installed.  However, if you are using Azure Lighthouse to execute a logic app in your MSSP tenant from a customer tenant you will need to add some additional configuration.  You, must come up with a way to identify the source tenant of the incident such that you can pass the tenant id to STAT.  This could be accomplished by a watchlist in your source tenant, which looks up the workspace id or subscription id against a watchlist to determine the originating tenant, or it could be done through any other means.  Ultimately, STAT cannot make the determination of which tenant to execute against, so you will need to provide this information.  Additionally, to use the MDCA module you will also be able to lookup the customers MDCA API endpoint and provide this information as well.  This can be stored and looked up in a similiar fashion as the tenant id.

## Provide AAD Tenant Details to STAT

The Base Module has a new optional parameter called *MultiTenantConfig*.  In a multi tenant configuration, this parameter will need to be passed to the base module.  The parameter is expecting a JSON object containing the multi tenant configuration.

### Example 1 - All APIs are located in the Customer Tenant / STAT Deployed in MSSP Tenant

```json
{
    "TenantId": "CustomerTenantGUID",
    "MDCAUrl": "customer.region.portal.cloudappsecurity.com"
}
```

### Example 2 - The Sentinel Incidents and STAT are in MSSP Tenant / All other data in the Customer Tenant

```json
{
    "ARMTenantId": "MSSPTenantGUID",
    "TenantId": "CustomerTenantGUID",
    "MDCAUrl": "customer.region.portal.cloudappsecurity.com"
}
```

## Advanced Configuration

STAT v2 allows for an API by API level of control against which tenant the authentication occurs, so for other scenarios you can customize this further.  To do so, the *MultiTenantConfig* accepts all of these properties.

|Property|Description|
|---|---|
|TenantId|The default tenant id to use for any APIs not explicitly specified. Setting a service specific tenant id overrides this value for that service.|
|ARMTenantId|The tenant id to use when accessing the Azure Resource Manager API. This API is primarily used for updating incidents.|
|MSGraphTenantId|The tenant id to use when accessing the Microsoft Graph API.|
|LogAnalyticsTenantId|The tenant id to use when access the Log Analytics API to run KQL queries.|
|M365DTenantId|The tenant id to use when accessing Microsoft 365 Defender APIs|
|MDETenantId|The tenant id to use when accessing Microsoft Defender for Endpoint APIs|
|MDCAUrl|The tenant specific API endpoint to use when accessing MDCA (MDCA module only). Do not include *https://*|


---
[Documentation Home](readme.md)
