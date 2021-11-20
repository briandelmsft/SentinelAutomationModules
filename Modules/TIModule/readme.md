# Get-ThreatIntel

## Description
This module will check the incident entities to see if there is corresponding threat intelligence in Microsoft Sentinel.

## Suported Entity Types
* IP
* Domain
* URL
* FileHash

## Trigger Parameters

|Parameter|Expected Values|Description|
|---|---|---|
|AddIncidentComments|Yes/No|When set to yes, the results of the query will be added to the Sentinel Incident Comments|
|Base Module Body|Body (dynamic content)|The Body should be selected from the Dynamic content of the Base-Module response|
|CheckDomains|Check Domain Entities for Threat Intelligence Matches|
|CheckFileHashes|Check File Hash Entities for Theat Intelligence Matches|
|CheckIPs|Check IP Entities for Threat Intelligence Matches|
|CheckURLs|Check URL Entities for Threat Intelligence Matches|
|LookbackInDays|1-90|This defines how far back to look through the ThreatIntelligenceIndicators table in Sentinel|

## Return Properties

|Property|Description|
|---|---|
|TBD||
|DetailedResults|An array of Threat Intelligence data|


## Sample Return

```
{
}
```

## Quick Deployment

[![Deploy to Azure](https://aka.ms/deploytoazurebutton)](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Fbriandelmsft%2FSentinelAutomationModules%2Fmain%2FModules%2FTIModule%2Fazuredeploy.json)

## Post Deployment

* Grant the Logic app managed identity access to the Log Analytics API application permissions Data.Read (GrantPermissions.ps1)
* Grant the Logic app Microsoft Sentinel Responder RBAC role on the resource group containing Microsoft Sentinel (GrantPermissions.ps1)
