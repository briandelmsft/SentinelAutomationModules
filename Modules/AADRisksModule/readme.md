# Get-AADUserRisksInfo

## Description
This module will retrieve the level of risk of the user in Azure AD Identity Protection as well as the following information is requested:
* Number of IP addresses matching an entry in your threat intelligence in the SigninLogs table
* Number of MFA fraud report
* Number of MFA failure (the user denied the MFA request or the MFA request timed out)

## Suported Entity Types
* Account

## Trigger Parameters

Trigger name: **triage**

|Parameter|Expected Values|Description|
|---|---|---|
|AddIncidentComments|Yes/No|When set to yes, the results of the query will be added to the Sentinel Incident Comments|
|Entities|Entities (dynamic content)|This should be selected from the Dynamic content of the incident creation rule trigger|
|IncidentARMId|Incident ARM ID (dynamic content)|This should be selected from the Dynamic content of the incident creation rule trigger|
|LookbackInDays|1-90|This defines how far back to look through the SecurityAlert tables in Sentinel|
|WorkspaceId|Workspace ID (dynamic content)|This should be selected from the Dynamic content of the incident creation rule trigger|
|MFAFailureLookup|Yes/No|This enables the lookup the SigninLogs table for MFA failures|
|MFAFraudLookup|Yes/No|This enables the lookup the AuditLogs table for MFA fraud reports|
|TIIPLookup|Yes/No|This enables the lookup of the IP addresses listed in the SigninLogs in your Threat Intelligence table|


## Return Properties

|Property|Description|
|---|---|
|AnalyzedEntities|Returns the number of entities analyzed (returns 0 if no Account entities were found)|
|HighestRiskyUser|Returns the highest risk level found in Azure AD for all entities(returns unknown if no Account entities were found)|
|FailedMFATotalCount|Returns the total failed MFA request in the SigninLogs table for all entities (returns 0 if no Account entities were found)|
|FailedMFATotalCount|Returns the total MFA fraud reports in the AuditLogs table for all entities (returns 0 if no Account entities were found)|
|RiskyIPTotalCount|Returns the total of IP addresses in the SigninLogs also found in your Threat Intelligence table for all entities (returns 0 if no Account entities were found)|
|DetailedResults|An array containing the details for each entity|
|UserPrincipalName|The UserPrincipalName for the current entity|
|UserId|The Azure AD object Id for the current entity|
|UserRiskLevel|The entity risk level found in Azure AD Identity Protection|
|FailedMFACount|Total of failed MFA request in the SigninLogs table for the current entity|
|MFAFraudCount|Total of MFA fraud reports in the AuditLogs table for the current entity|
|RiskyIPCount|Total of IP addresses in the SigninLogs also found in your Threat Intelligence table for the current user|
|RiskyIPList|The list of IP addresses found in your Threat Intelligence table for the current user (this is a string not an array, the IP addresses are separated with a comma)|

## Sample Return

```
{
  "AnalyzedEntities": 2,
  "FailedMFATotalCount": 31,
  "HighestRiskyUser": "low",
  "MFAFraudTotalCount": 1,
  "RiskyIPTotalCount": 3
  "DetailedResults": [
    {
      "FailedMFACount": 0,
      "MFAFraudCount": 1,
      "RiskyIPCount": 1,
      "RiskyIPList": "124.150.248.3",
      "UserId": "17de02b6-b883-4f4f-9acd-02ec09d160cd",
      "UserPrincipalName": "alice@contoso.com",
      "UserRiskLevel": "none"
    },
    {
      "FailedMFACount": 31,
      "MFAFraudCount": 0,
      "RiskyIPCount": 2,
      "RiskyIPList": "3.96.17.217, 62.146.38.48",
      "UserId": "7ec8eef7-784d-4afd-91a1-1fd433bfc3ee",
      "UserPrincipalName": "john@contoso.com",
      "UserRiskLevel": "low"
    }
  ]
}
```

## Quick Deployment

[![Deploy to Azure](https://aka.ms/deploytoazurebutton)](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Fbriandelmsft%2FSentinelAutomationModules%2Fmain%2FModules%2FAADRisksModule%2Fazuredeploy.json)

## Post Deployment

* Grant the Logic app managed identity access to the Log Analytics API application permissions Data.Read (GrantPermissions.ps1)
* Grant the Logic app managed identity access to the Microsoft Graph application permissions User.Read.All (GrantPermissions.ps1)
* Grant the Logic app managed identity access to the Microsoft Graph application permissions IdentityRiskyUser.Read.All (GrantPermissions.ps1)
* Grant the Logic app Azure Sentinel Responder RBAC role on the resource group containing Azure Sentinel (GrantPermissions.ps1)
