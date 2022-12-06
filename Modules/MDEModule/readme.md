# Get-MDEInsights

## Description
This module will return the risk score and exposure level from Microsoft Defender for Endpoint of all the machines on which a user logged on interactively and for all machines with specified IP addresses.

## Suported Entity Types
* Accounts (if the accounts have objectSid available)
* IPs
* Hosts (using the MdatpDeviceId if present, else construct the FQDN from the raw entitiy)

## Trigger Parameters

|Parameter|Expected Values|Description|
|---|---|---|
|AddIncidentComments|True/False (Default:True)|When set to true, the results of the query will be added to the Sentinel Incident Comments|
|Base Module Body|Body (dynamic content)|The Body should be selected from the Dynamic content of the Base-Module response|
|LookbackInDays|1-30|This defines how far back to look through the DeviceLogonEvents table in Microsoft Defender for Endpoint|

## Return Properties

|Property|Description|
|---|---|
|AnalyzedEntities|Number of entities analyzed in the module|
|UsersHighestRiskScore|The highest risk score found for all machines of a specific user|
|UsersHighestExposureLevel|The highest exposure level found for all machines of a specific user|
|IPsHighestExposureLevel|The highest risk score level found for all machines with a specific IP|
|IPsHighestRiskScore|The highest exposure level found for all machines with a specific IP|
|HostsHighestExposureLevel|The highest risk score level found for all hosts matching the MdatpDeviceId or the FQDN|
|HostsHighestRiskScore|The highest exposure level found for all hosts matching the MdatpDeviceId or the FQDN|
|ModuleName|The internal Name of the Playbook|
|DetailedResults|An array of the accounts and IPs analyzed|

## Sample Return

```
{
    "AnalyzedEntities": 4,
    "IPsHighestExposureLevel": "Unknown",
    "IPsHighestRiskScore": "Unknown",
    "UsersHighestExposureLevel": "Medium",
    "UsersHighestRiskScore": "High",
    "HostsHighestExposureLevel": "Medium",
    "HostsHighestRiskScore": "Low",
    "ModuleName": "MDEModule",
    "DetailedResults":
    {
        "Accounts": [
        {
            "UserDevices": [],
            "UserHighestExposureLevel": "Unknown",
            "UserHighestRiskScore": "Unknown",
            "UserId": "102b4fab-0a2e-43d4-9885-5a78ae6772a8",
            "UserPrincipalName": "bob@contoso.com",
            "UserSid": "S-1-5-21-1703388146-2621323185-1663833956-49112"
        },
        {
            "UserHighestExposureLevel": "Medium",
            "UserHighestRiskScore": "High",
            "UserId": "ff2b4fab-0a2e-43d4-ed85-5a78ae6714a8",
            "UserPrincipalName": "alice@contoso.com",
            "UserSid": "S-1-5-21-1703388146-2621323185-1663833956-1111",
            "UserDevices": [
            {
                "id": "d8992d10a94d4aad9ffe4853823456501544d300",
                "computerDnsName": "client1.contoso.com",
                "riskScore": "High",
                "exposureLevel": "Low"
            },
            {
                "id": "12392d10a94d4aad9ffe4853823456501544d3e4",
                "computerDnsName": "client2.contoso.com",
                "riskScore": "Low",
                "exposureLevel": "Medium"
            }]
        }],
        "IPs": [
        {
            "Address": "198.84.160.91",
            "IPDevices": [],
            "IPHighestExposureLevel": "Unknown",
            "IPHighestRiskScore": "Unknown"
        }],
        "Hosts": [
        {
            "id": "b9e57eb3ab888957a952f2b9fedd719264f5dbd9",
            "computerDnsName": "server91.contoso.com",
            "riskScore": "Low",
            "exposureLevel": "Medium"
        }]
    }
}
```

## Deployment

To deploy the Sentinel Triage AssistanT visit the [deployment documentation](/Docs/deployment.md).
