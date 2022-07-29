# Base Module

## Description
The base module must be called before any other modules in this solution.  It performs important shared functions such as enriching entity data and formatting the enriched data in a consistent way to pass into other modules.  Unsupported entity types will be returned in the OtherEntities array with no enrichments.

## Suported Entity Types
* Account
* IP
* Host
* File
* FileHash
* DnsDomain
* URL

## Trigger Parameters

|Parameter|Expected Values|Description|
|---|---|---|
|AddAccountComment|True/False (Default:True)|Add comment to Sentinel incident with account enrichments|
|AddIPComment|True/False (Default:True)|Add comment to Sentinel incident with IP enrichments|
|EnrichIPsWithGeoData|True/False (Default:True)|When set to true, IP address entities will be returned with Geo enrichment data such as Country, City and LAT/LONG|
|Entities|Entities (dynamic content)|This should be selected from the Dynamic content of the incident creation rule trigger|
|IncidentARMId|Incident ARM ID (dynamic content)|This should be selected from the Dynamic content of the incident creation rule trigger|
|WorkspaceId|Workspace ID (dynamic content)|This should be selected from the Dynamic content of the incident creation rule trigger|

## Sample Return

```
{
  "Accounts": [
    {
      "userPrincipalName": "user1@contoso.com",
      "id": "f4610870-413b-4716-845c-426820fc9e96",
      "onPremisesSecurityIdentifier": "S-1-5-21-565363555-1337343555-2447627555-32656",
      "onPremisesDistinguishedName": "CN=user1,OU=Lab,OU=Org,DC=contoso,DC=com",
      "onPremisesDomainName": "contoso.com",
      "onPremisesSamAccountName": "user1",
      "onPremisesSyncEnabled": true,
      "mail": "user.1@contoso.com",
      "city": null,
      "state": null,
      "country": null,
      "department": "Security Testing",
      "jobTitle": "Tester",
      "officeLocation": null,
      "accountEnabled": true,
      "manager": {
        "@odata.type": "#microsoft.graph.user",
        "userPrincipalName": "manager1@contoso.com",
        "mail": "manager.1@contoso.com",
        "id": "a83439dd-262c-4606-a076-4d5e33d63970"
      },
      "AssignedRoles": [],
      "RawEntity": {
        "aadUserId": "f4610870-413b-4716-845c-426820fc9e96",
        "friendlyName": "f4610870-413b-4716-845c-426820fc9e96"
      },
      "isAADPrivileged": false,
      "isMfaRegistered": true,
      "isSSPREnabled": true,
      "isSSPRRegistered": true
    }
  ],
  "AccountsCount": 1,
  "Domains": [],
  "DomainsCount": 0,
  "EntitiesCount": 5,
  "FileHashes": [
    {
      "RawEntity": {
        "hashValue": "ce808a96c72b74d2c73e38d9115873df4ae3a5f901e969344f44873595dd4cca",
        "algorithm": "SHA256",
        "friendlyName": "ce808a96c72b74d2c73e38d9115873df4ae3a5f901e969344f44873595dd4cca(SHA256)"
      }
    }
  ],
  "FileHashesCount": 1,
  "Files": [],
  "FilesCount": 0,
  "Hosts": [
    {
      "DnsDomain": "contoso.com",
      "FQDN": "host1.contoso.com",
      "Hostname": "host1",
      "RawEntity": {
        "dnsDomain": "contoso.com",
        "hostName": "host1",
        "netBiosName": "host1.contoso.com",
        "friendlyName": "host1"
      }
    }
  ],
  "HostsCount": 1,
  "IPs": [
    {
      "Address": "40.126.28.11",
      "GeoData": {
        "asn": "8075",
        "carrier": "microsoft corporation",
        "city": "chicago",
        "cityCf": 95,
        "continent": "north america",
        "country": "united states",
        "countryCf": 99,
        "ipAddr": "40.126.28.11",
        "ipRoutingType": "fixed",
        "latitude": "41.84885",
        "longitude": "-87.67125",
        "organization": "microsoft corporation",
        "organizationType": "Publishing",
        "region": "great lakes",
        "state": "illinois",
        "stateCf": 97,
        "stateCode": "il"
      },
      "RawEntity": {
        "address": "40.126.28.11",
        "friendlyName": "40.126.28.11"
      }
    }
  ],
  "IPsCount": 1,
  "IncidentARMId": "/subscriptions/397caaaa-d999-4abc-acdd-f3a40db41234/resourceGroups/sentinel-rg/providers/Microsoft.OperationalInsights/workspaces/sentinel-workspace/providers/Microsoft.SecurityInsights/Incidents/afdffc57-0ae5-4323-b75e-48a64fcb3280",
  "ModuleVersions": {
    "AADRisksModule": "0.0.4",
    "BaseModule": "0.3.0",
    "FileModule": "0.0.3",
    "KQLModule": "0.0.5",
    "MCASModule": "0.0.5",
    "MDEModule": "0.1.1",
    "OOFModule": "0.0.3",
    "RelatedAlerts": "0.0.7",
    "TIModule": "0.0.4",
    "UEBAModule": "0.0.5",
    "WatchlistModule": "0.0.5"
  },
  "OtherEntities": [
    {
      "id": "/subscriptions/.../Entities/",
      "type": "Microsoft.SecurityInsights/Entities",
      "kind": "Process",
      "properties": {
        "processId": "1918",
        "friendlyName": "1918"
      }
    },
    {
      "id": "/subscriptions/.../Entities/",
      "type": "Microsoft.SecurityInsights/Entities",
      "kind": "MailMessage",
      "properties": {
        "fileEntityIds": [],
        "recipient": "recipient@contoso.com",
        "p2Sender": "sender@contoso.com",
        "networkMessageId": "93b12097-530b-4add-9deb-d34878d0fb02",
        "friendlyName": "93b12097-530b-4add-9deb-d34878d0fb02"
      }
    }
  ],
  "OtherEntitiesCount": 2,
  "TenantDisplayName": "Contoso",
  "TenantId": "b85d1087-e1a5-4d3e-bccf-3683b206a77e",
  "URLs": [
    {
      "RawEntity": {
        "url": "https://www.contoso.com/folder/index.aspx",
        "friendlyName": "https://www.contoso.com/folder/index.aspx"
      }
    }
  ],
  "URLsCount": 1,
  "WorkspaceId": "6ba275ab-1c20-4ac0-58e8-138499ea383c"
}
```

## Release Notes

### Version 0.4.0

This version adds enrichments about MFA and SSPR status to account entities.  This enrichments requires the additional graph permission of Reports.Read.All.  If you are upgrading from a previous version, you will need to add this additional permissions using the GrantPermissions.ps1 PowerShell script.  If this permissions is not added, the module will return *Unknown* for the SSPR and MFA status of the account.

## Advanced Deployment

Deployment of the Sentinel Triage AssistanT should typically be performed from the [deployment template](/Deploy/readme.md), however in some cases you may wish to deploy an individual module below.

[![Deploy to Azure](https://aka.ms/deploytoazurebutton)](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Fbriandelmsft%2FSentinelAutomationModules%2Fmain%2FModules%2FBaseModule%2Fazuredeploy.json)

## Post Deployment

* Grant the Logic app managed identity access to the Microsoft Graph application permissions User.Read.All, Reports.Read.All and RoleManagement.Read.Directory (GrantPermissions.ps1)
* Grant the Logic app Microsoft Sentinel Responder RBAC role on the resource group containing Microsoft Sentinel (GrantPermissions.ps1)
