# Get-ThreatIntel

## Description
This module will check the incident entities to see if there is corresponding threat intelligence in Microsoft Sentinel.

## Supported Entity Types
* IP
* Domain
* URL
* FileHash

## Trigger Parameters

|Parameter|Expected Values|Description|
|---|---|---|
|AddIncidentComments|True/False (Default:True)|When set to true, the results of the query will be added to the Sentinel Incident Comments|
|AddIncidentTask|True/False (Default:False)|When set to true, a task will be added to the Sentinel incident to review the query results if results are found.|
|Base Module Body|Body (dynamic content)|The Body should be selected from the Dynamic content of the Base-Module response|
|CheckDomains|True/False (Default:True)|Check Domain Entities for Threat Intelligence Matches|
|CheckFileHashes|True/False (Default:True)|Check File Hash Entities for Theat Intelligence Matches|
|CheckIPs|True/False (Default:True)|Check IP Entities for Threat Intelligence Matches|
|CheckURLs|True/False (Default:True)|Check URL Entities for Threat Intelligence Matches|
|IncidentTaskInstructions|Markdown Text|A list of instructions you want to include in the task|
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
|ModuleName|The internal Name of the Playbook|
|TotalTIMatchCount|Count of all Threat Intelligence matches|
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
  "ModuleName": "TIModule",
  "TotalTIMatchCount": 3,
  "URLEntitiesCount": 1,
  "URLEntitiesWithTI": 1,
  "URLTIFound": true
}
```

## Deployment

To deploy the Sentinel Triage AssistanT visit the [deployment documentation](/Docs/deployment.md).
