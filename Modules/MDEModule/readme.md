# Get-MDEUsersDevicesRiskScore

## Description
This module will check the risk score in Microsoft Defender for Endpoint of all the machines on which a user logged on interactively.

## Suported Entity Types
* Account (ideally with a userSid property, if the userSid will be looked up thanks to the other properties)

## Trigger Parameters

|Parameter|Expected Values|Description|
|---|---|---|
|AddIncidentComments|Yes/No|When set to yes, the results of the query will be added to the Sentinel Incident Comments|
|Entities|Entities (dynamic content)|This should be selected from the Dynamic content of the incident creation rule trigger|
|IncidentARMId|Incident ARM ID (dynamic content)|This should be selected from the Dynamic content of the incident creation rule trigger|
|LookbackInDays|Number of days to look for user activity on Microsoft Defender for Endpoint data. Minimum 1. Maximum 30|

## Return Properties

|Property|Description|
|---|---|
|HighestScore|Returns the highest risk score found for all machines used by the entities.  If no machines are found, it will return the value "unknown"|
|PerUserScore|An array of the users' details|
|UserHighestScore|The highest risk score found for all machines of a specific user|
|UserId|The Azure AD objectId of the user (if provided in the Entities or found thanks to the other properties)|
|UserPrincipalName|The UserPrincipalName of the user (if provided in the Entities or found thanks to the other properties)|
|UserSid|The on premises user SID (if provided in the Entities or found thanks to the other properties)|
|UserDevices|An array of the users' devices found in Microsoft Defender for Endpoint|
|DeviceId|The device identifier in Microsoft Defender for Endpoint|
|DeviceName|The device name in Microsoft Defender for Endpoint|
|DeviceRiskScore|The risk score for the device|


## Sample Return

```
{
  "HighestScore": "High",
  "PerUserScore": [
    {
        "UserHighestScore": "Medium",
        "UserId": "6f61346af61979770ed7de50ab98f218980a97ab",
        "UserPrincipalName": "bob@fabrikam.com",
        "UserSid": "S-1-5-21-3983730427-1411257960-1702799300-1906",
        "UserDevices": [
            {
            "DeviceId": "cf913468796679770ff7de50ab98f218da0a97e1",
            "DeviceName": "client3.fabrikam.com",
            "DeviceRiskScore": "Medium"
            }
        ]
    },
    {
        "UserHighestScore": "unknown",
        "UserId": "102b4fab-0a2e-43d4-9885-5a78ae6772a8",
        "UserPrincipalName": "admin@contoso.onmicrosoft.com",
        "UserSid": "",
        "UserDevices": []
    },
    {
        "UserHighestScore": "High",
        "UserId": "unknown",
        "UserPrincipalName": "john@contoso.com",
        "UserSid": "S-1-5-21-1703388146-2621323181-1663833956-11211"
        "UserDevices": [
            {
                "DeviceId": "d8992d10a94d4aad959e4853823456501544d301",
                "DeviceName": "client1.contoso.com",
                "DeviceRiskScore": "High"
            },
            {
                "DeviceId": "b3585be3a0c4090e3e3f9f10b261d70c4a3911c1",
                "DeviceName": "client2.contoso.com",
                "DeviceRiskScore": "None"
            }
        ]
    }
  ]
}
```


## Quick Deployment

[![Deploy to Azure](https://aka.ms/deploytoazurebutton)](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Fbriandelmsft%2FSentinelAutomationModules%2FMDEModule%2FModules%2FMDEModule%2Fazuredeploy.json)

## Post Deployment

* Grant the Logic app managed identity access to the Microsoft Graph application permissions User.Read.All (GrantAPIPermissions.ps1)
* Grant the Logic app managed identity access to the Microsoft Defender API permissions Machine.Read.All and AdvancedQuery.Read.All (GrantAPIPermissions.ps1)
* Grant the Logic app Azure Sentinel Responder RBAC role on the resource group containing Azure Sentinel