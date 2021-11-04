# Get-FileInsights

## Description
This module will check if the entities are found as email attachments and will run the [FileProfile()](https://docs.microsoft.com/en-us/microsoft-365/security/defender/advanced-hunting-fileprofile-function) function on the provided hashes. 

## Suported Entity Types
* File
* FileHash

## Trigger Parameters

Trigger name: **triage**

|Parameter|Expected Values|Description|
|---|---|---|
|AddIncidentComments|Yes/No|When set to yes, the results of the query will be added to the Sentinel Incident Comments|
|Entities|EnrichedEntities (dynamic content)|This should be selected from the Dynamic content|

## Return Properties

|Property|Description|
|---|---|
|AnalyzedEntities|Number of entities analyzed in the module|
|EntitiesAttachmentCount|Number of times the entities were found in email attachements|
|HashedInvalidSignatureCount|Number of hashes of files with no or invalid signatures found|
|HashesLinkedToThreatCount|Number of hashes of files linked with a known threat found|
|HashesNotMicrosoftSignedCount|Number of hashes of files not signed by Microsoft found|
|HashesThreatList|List of known threat for hashes parsed witht the function FileProfile()|
|MaximumGlobalPrevalence|Highest global prevalence score found in the FileProfile() output|
|MinimumGlobalPrevalence|Lowest global prevalence score found in the FileProfile() output|
|DetailedResults|An array of Files and HashFiles|

## Sample Return

```
{
    "AnalyzedEntities": 2,
    "EntitiesAttachmentCount": 0,
    "HashedInvalidSignatureCount": 0,
    "HashesLinkedToThreatCount": 0,
    "HashesNotMicrosoftSignedCount": 0,
    "HashesThreatList": [],
    "MaximumGlobalPrevalence": 948591,
    "MinimumGlobalPrevalence": 751340,
    "DetailedResults": [
    {
        "EmailAttachmentCount": 0,
        "EmailAttachmentFileSize": "",
        "EmailAttachmentFirstSeen": "",
        "EmailAttachmentLastSeen": "",
        "FileName": "",
        "GlobalFirstSeen": "2018-09-17T22:09:03.4724305Z",
        "GlobalLastSeen": "2021-11-04T13:34:41.1027033Z",
        "GlobalPrevalence": 948591,
        "IsCertificateValid": 1,
        "MD5": "7353f60b1739074eb17c5f4dddefe239",
        "Publisher": "Microsoft Corporation",
        "SHA1": "6cbce4a295c163791b60fc23d285e6d84f28ee4c",
        "SHA256": "de96a6e69944335375dc1ac238336066889d9ffc7d73628ef4fe1b1b160ab32c",
        "SignatureState": "SignedValid",
        "ThreatName": ""
    },
    {
        "EmailAttachmentCount": 0,
        "EmailAttachmentFileSize": "",
        "EmailAttachmentFirstSeen": "",
        "EmailAttachmentLastSeen": "",
        "FileName": "",
        "GlobalFirstSeen": "2018-09-18T21:23:46.1435835Z",
        "GlobalLastSeen": "2021-11-04T13:32:43.879195Z",
        "GlobalPrevalence": 751340,
        "IsCertificateValid": 1,
        "MD5": "ae61d8f04bcde8158304067913160b31",
        "Publisher": "Microsoft Corporation",
        "SHA1": "4f4970c3545972fea2bc1984d597fc810e6321e0",
        "SHA256": "25c8266d2bc1d5626dcdf72419838b397d28d44d00ac09f02ff4e421b43ec369",
        "SignatureState": "SignedValid",
        "ThreatName": ""
    }]
}
```

## Quick Deployment

[![Deploy to Azure](https://aka.ms/deploytoazurebutton)](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Fbriandelmsft%2FSentinelAutomationModules%2Fmain%2FModules%2FFileModule%2Fazuredeploy.json)

## Post Deployment

* Grant the Logic app managed identity access to the Microsoft Threat Protection permissions AdvancedHunting.Read.All (GrantPermissions.ps1)
* Grant the Logic app Azure Sentinel Responder RBAC role on the resource group containing Azure Sentinel (GrantPermissions.ps1)
