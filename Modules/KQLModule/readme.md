# Run-KQLQuery

## Description
This module allows you to run custom KQL queries against Microsoft Sentinel or Microsoft 365 Advanced Hunting.  In these queries you can filter the results based on the entities data from you Microsoft Sentinel Incident

## Suported Entity Types
* Account
* Host
* IP Address

## Trigger Parameters

|Parameter|Expected Values|Description|
|---|---|---|
|Base Module Body|Body (dynamic content)|The Body should be selected from the Dynamic content of the Base-Module response|
|KQL Query|The KQL Query you wish to execute|
|LookbackInDays|1-90|This defines how far back to look back in the data, note this is limited to 30 days for Microsoft 365 Advanced Hunting|
|RunQueryAgainst|Sentinel/M365|This defines if the KQL query will run against the Microsoft Sentinel data or the M365 Defender Advanced Hunting data|

## Return Properties

|Property|Description|
|---|---|
|DetailedResults|An array of each record found by the KQL query|
|ResultsCount|Number of results found by the KQL query|
|ResultsFound|true/false indicating if results were found by the KQL query|

## Sample Return

```
{
  "DetailedResults": [
    {
        "TBD": "TBD"
    }
  ],
  "ResultsCount": 1,
  "RelatedAccountAlertsFound": true,

}
```

## Quick Deployment

[![Deploy to Azure](https://aka.ms/deploytoazurebutton)](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Fbriandelmsft%2FSentinelAutomationModules%2Fkql_module%2FModules%2FKQLModule%2Fazuredeploy.json)

## Post Deployment

* Grant the Logic app managed identity access to the Log Analytics API application permissions Data.Read (GrantPermissions.ps1)
* Grant the Logic app managed identity access to the Microsoft 365 Security API permissions AdvancedHunting.Read.All (GrantPermissions.ps1)
* Grant the Logic app Microsoft Sentinel Responder RBAC role on the resource group containing Microsoft Sentinel (GrantPermissions.ps1)
