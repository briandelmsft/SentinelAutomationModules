# Get-AADUserRisksInfo

## Description
This module will retrieve the level of risk of the users in Azure AD Identity Protection as well as the following information if requested:
* Number of MFA fraud report for the specified entities
* Number of MFA failure (the user denied the MFA request or the MFA request timed out) for the specified entities

## Suported Entity Types
* Accounts

## Trigger Parameters

Trigger name: **triage**

|Parameter|Expected Values|Description|
|---|---|---|
|AddIncidentComments|Yes/No|When set to yes, the results of the query will be added to the Sentinel Incident Comments|
|Entities|EnrichedEntities (dynamic content)|This should be selected from the Dynamic content of the incident creation rule trigger|
|LookbackInDays|1-90|This defines how far back to look through the SecurityAlert tables in Sentinel|
|MFAFailureLookup|Yes/No|This enables the lookup the SigninLogs table for MFA failures|
|MFAFraudLookup|Yes/No|This enables the lookup the AuditLogs table for MFA fraud reports|


## Return Properties

|Property|Description|
|---|---|
|AnalyzedEntities|Returns the number of entities analyzed (returns 0 if no Account entities were found)|
|HighestRiskyUser|Returns the highest risk level found in Azure AD for all entities(returns unknown if no Account entities were found)|
|FailedMFATotalCount|Returns the total failed MFA request in the SigninLogs table for all entities (returns 0 if no Account entities were found)|
|MFAFraudTotalCount|Returns the total MFA fraud reports in the AuditLogs table for all entities (returns 0 if no Account entities were found)|
|DetailedResults|An array containing the details for each entity|

## Sample Return

```
{
  "AnalyzedEntities": 2,
  "FailedMFATotalCount": 31,
  "HighestRiskyUser": "low",
  "MFAFraudTotalCount": 1,
  "DetailedResults": [
    {
      "UserFailedMFACount": 0,
      "UserMFAFraudCount": 1,
      "UserId": "17de02b6-b883-4f4f-9acd-02ec09d160cd",
      "UserPrincipalName": "alice@contoso.com",
      "UserRiskLevel": "none"
    },
    {
      "UserFailedMFACount": 31,
      "UserMFAFraudCount": 0,
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
* Grant the Logic app Microsoft Sentinel Responder RBAC role on the resource group containing Microsoft Sentinel (GrantPermissions.ps1)
