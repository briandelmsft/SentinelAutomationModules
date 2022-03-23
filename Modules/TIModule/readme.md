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
|AddIncidentComments|True/False (Default:True)|When set to true, the results of the query will be added to the Sentinel Incident Comments|
|Base Module Body|Body (dynamic content)|The Body should be selected from the Dynamic content of the Base-Module response|
|CheckDomains|True/False (Default:True)|Check Domain Entities for Threat Intelligence Matches|
|CheckFileHashes|True/False (Default:True)|Check File Hash Entities for Theat Intelligence Matches|
|CheckIPs|True/False (Default:True)|Check IP Entities for Threat Intelligence Matches|
|CheckURLs|True/False (Default:True)|Check URL Entities for Threat Intelligence Matches|
|LookbackInDays|(Default:14)|This defines how far back to look through the ThreatIntelligenceIndicators table in Sentinel.  All active threat intel is included when looking back the default 14 days.|

## Return Properties

|Property|Description|
|---|---|
|AnyTIFound|true/false if any Threat Intelligence was found for any indicator type|
|DetailedResults|An array of Threat Intelligence that was matched with the incident entities|
|DomainEntitiesCount|Count of Domain Entities in Incident|
|DomainEntitiesWithTI|Count of Domain Entities with Threat Intelligence matches|
|DomainTIFound|true/false if Domain Threat Intelligence was found|
|FileHashEntitiesCount|Count of FileHash Entities in Incident|
|FileHashEntitiesWithTI|Count of FileHash Entities with Threat Intelligence matches|
|FileHashTIFound|true/false if FIleHash Threat Intelligence was found|
|IPEntitiesCount|Count of IP Entities in Incident|
|IPEntitiesWithTI|Count of IP Entities with Threat Intelligence matches|
|IPTIFound|true/false if IP Threat Intelligence was found|
|URLEntitiesCount|Count of URL Entities in Incident|
|URLEntitiesWithTI|Count of URL Entities with Threat Intelligence matches|
|URLTIFound|true/false if URL Threat Intelligence was found|

## Sample Return

```
{
  "AnyTIFound": true,
  "DetailedResults": [
    {
      "TIType": "IP",
      "TIData": "40.126.28.11",
      "SourceSystem": "Azure Sentinel",
      "Description": "TestingOnly Benign IP",
      "ThreatType": "benign",
      "ConfidenceScore": 0,
      "IndicatorId": "73F782D74E5A8D0A144076FCEF875D2ED16A59EBC15E1A0053D9BEFBB7C35F8D"
    },
    {
      "TIType": "URL",
      "TIData": "https://www.contoso.com/folder/index.aspx",
      "SourceSystem": "Azure Sentinel",
      "Description": "TestingOnly-BenignUrl",
      "ThreatType": "benign",
      "ConfidenceScore": 0,
      "IndicatorId": "6090F19551C4B7C7B5F7DEE6B1FC79B4457B3ACD6928313A860815190BC160D6"
    },
    {
      "TIType": "Domain",
      "TIData": "contoso.com",
      "SourceSystem": "Azure Sentinel",
      "Description": "BenignThreat-Testing only",
      "ThreatType": "benign",
      "ConfidenceScore": 0,
      "IndicatorId": "EAB98E3ED850F21B5F23905E905B0338FC37B11D82428741F15F4505E9BDF9DA"
    }
  ],
  "DomainEntitiesCount": 1,
  "DomainEntitiesWithTI": 1,
  "DomainTIFound": true,
  "FileHashEntitiesCount": 1,
  "FileHashEntitiesWithTI": 0,
  "FileHashTIFound": false,
  "IPEntitiesCount": 1,
  "IPEntitiesWithTI": 1,
  "IPTIFound": true,
  "URLEntitiesCount": 1,
  "URLEntitiesWithTI": 1,
  "URLTIFound": true
}
```

## Advanced Deployment

Deployment of the Sentinel Triage AssistanT should typically be performed from the [deployment template](/Deploy/readme.md), however in some cases you may wish to deploy an individual module below.

[![Deploy to Azure](https://aka.ms/deploytoazurebutton)](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Fbriandelmsft%2FSentinelAutomationModules%2Fmain%2FModules%2FTIModule%2Fazuredeploy.json)

## Post Deployment

* Grant the Logic app managed identity access to the Log Analytics API application permissions Data.Read (GrantPermissions.ps1)
* Grant the Logic app Microsoft Sentinel Responder RBAC role on the resource group containing Microsoft Sentinel (GrantPermissions.ps1)
