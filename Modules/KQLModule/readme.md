# Run-KQLQuery

## Description
This module allows you to run custom KQL queries against Microsoft Sentinel or Microsoft 365 Advanced Hunting.  In these queries you can filter the results based on the entities data from you Microsoft Sentinel Incident

## Suported Entity Types
* Account
* IP Address

## Trigger Parameters

|Parameter|Expected Values|Description|
|---|---|---|
|Base Module Body|Body (dynamic content)|The Body should be selected from the Dynamic content of the Base-Module response|
|KQL Query|The KQL Query you wish to execute|
|LookbackInDays|1-90|This defines how far back to look back in the data, note this is limited to 30 days for Microsoft 365 Advanced Hunting|
|RunQueryAgainst|Sentinel/M365|This defines if the KQL query will run against the Microsoft Sentinel data or the M365 Defender Advanced Hunting data|

## Building your KQL Query

In your KQL query you will have access to 2 tables built from the entity data of your Sentinel Incident.  You can use these tables through join or where clauses in your query to locate the results you are looking for.

### Sentinel Query Special Considerations

* When querying against Microsoft Sentinel only the first 5 columns of data will be returned in the DetailedResults array.  You can use project or summarize statements to limit your return to the columns you are most interested in.
* If you need your query to assess multiple time ranges, for example comparing the last day of data to the last week of data, ensure to set the LookbackInDays to the larger time window and incoroporate the more granular time windows through filter in your KQL query.

### M365 Query Special Considerations

* When querying Microsoft 365 Security advanced hunting the LookbackInDays parameter is ignored.  To limit your query to a specific time period please include a time filter in your KQL query syntax such as:

```
DeviceLogonEvents
| where Timestamp > ago(7d)
```

### The following entity tables are available to you in both Sentinel and M365 Queries

***accountEntities***

|UserPrincipalName|SamAccountName|ObjectSID|AADUserId|ManagerUPN|
|---|---|---|---|---|
|user@contoso.com|user|S-1-5-21-565368899-1117343155-2447612341-32656|f4ab0870-413b-4716-845c-426821fc9e96|manager@contoso.com|

***ipEntities***

|IPAddress|Latitude|Longitude|Country|State|
|---|---|---|---|---|
|40.82.187.199|43.64280|-79.38705|canada|ontario|

These tables can be used in your KQL queries in any way you like.  For example, if you wanted to check if any of the users in your Incident have failed to login to Azure AD due to a bad password more than 10 times, you could write a query like this:

```
accountEntities
| join kind=inner (SigninLogs | where ResultType == 50126 | summarize FailureCount=count() by UserPrincipalName | where FailureCount >= 10) on UserPrincipalName
```

If you would prefer to use a where statement instead of a join, the following query would produce a similar result:

```
let UPNs = accountEntities | project UserPrincipalName;
SigninLogs
| where UserPrincipalName in (UPNs) and ResultType == 50126
| summarize FailureCount=count() by UserPrincipalName
| where FailureCount >= 10
```

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
      "Result1Column1Name": "Column1Value",
      "Result1Column2Name": "Column2Value",
      "Result1Column3Name": "Column3Value",
      "Resul1tColumn4Name": "Column4Value",
      "Result1Column5Name": "Column5Value"
    },
    {
      "Result2Column1Name": "Column1Value",
      "Result2Column2Name": "Column2Value",
      "Result2Column3Name": "Column3Value",
      "Resul12Column4Name": "Column4Value",
      "Result2Column5Name": "Column5Value"
    }
  ],
  "ResultsCount": 2,
  "ResultsFound": true,
}
```

## Quick Deployment

[![Deploy to Azure](https://aka.ms/deploytoazurebutton)](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Fbriandelmsft%2FSentinelAutomationModules%2Fmain%2FModules%2FKQLModule%2Fazuredeploy.json)

## Post Deployment

* Grant the Logic app managed identity access to the Log Analytics API application permissions Data.Read (GrantPermissions.ps1)
* Grant the Logic app managed identity access to the Microsoft 365 Security API permissions AdvancedHunting.Read.All (GrantPermissions.ps1)
* Grant the Logic app Microsoft Sentinel Responder RBAC role on the resource group containing Microsoft Sentinel (GrantPermissions.ps1)
