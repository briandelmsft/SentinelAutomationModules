# Run-KQLQuery

## Description
This module allows you to run custom KQL queries against Microsoft Sentinel or Microsoft 365 Advanced Hunting.  In these queries you can filter the results based on the entities data from you Microsoft Sentinel Incident

## Suported Entity Types
* Account
* IP Address
* Host

## Trigger Parameters

|Parameter|Expected Values|Description|
|---|---|---|
|AddIncidentComments|True/False (Default:True)|When set to true, the results of the query will be added to the Sentinel Incident Comments.  A maximum of 10 search results will be included|
|Base Module Body|Body (dynamic content)|The Body should be selected from the Dynamic content of the Base-Module response|
|KQL Query|The KQL Query you wish to execute|
|LookbackInDays|1-90|This defines how far back to look back in the data, note this is limited to 30 days for Microsoft 365 Advanced Hunting|
|QueryDescription|Text String (optional)|This description will be added to the incident comments to provide additional context on the query|
|RunQueryAgainst|Sentinel/M365|This defines if the KQL query will run against the Microsoft Sentinel data or the M365 Defender Advanced Hunting data|

## Building your KQL Query

In your KQL query you will have access to 3 tables built from the entity data of your Sentinel Incident.  You can use these tables through join or where clauses in your query to locate the results you are looking for.

For best results, limit your query results to as few columns of data as possible.  Including many columns may result in the ability to add comments to the incident to fail.  Also, while you query may return many records and the count will always be returned, on the the first 10 records will include detailed column data.  Consider using project and/or summarize in your query to optimize the returned results to just the data that is needed.

### Sentinel Query Special Considerations

* Only the first 10 records will be returned in the detailed results array.  When using this array, such as when using the option to AddIncidentComments consider using the sort function so the most important records are returned in the first 10. This does not impact the ResultsCount that is returned.
* It is recommended to limit the number of column data returned to what is needed.  Consider the use of project or summarize to do this.
* If you need your query to assess multiple time ranges, for example comparing the last day of data to the last week of data, ensure to set the LookbackInDays to the larger time window and incoroporate the more granular time windows through filter in your KQL query.

### M365 Query Special Considerations

* Only the first 10 records will be returned in the detailed results array.  When using this array, such as when using the option to AddIncidentComments consider using the sort or summarize functions so the most important records are returned in the first 10. This does not impact the ResultsCount that is returned.
* It is recommended to limit the number of column data returned to what is needed.  Consider the use of project or summarize to do this.
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

***hostEntities***

|FQDN|Hostname|
|---|---|
|computer01.contoso.com|computer01|

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

### The following scalar value is available to you in Sentinel queries

***incidentArmId***

incidentArmId will contain the string value of the Incident ARM Id such as: '/subscriptions/subId/resourceGroups/rgName/providers/Microsoft.OperationalInsights/workspaces/workspacename/providers/Microsoft.SecurityInsights/Incidents/incidentId'

This can be used if you want to retrieve the current incident details in a KQL query, such as the RelatedAnalyticRuleIds, AlertIds or other incident properties

```
SecurityIncident
| where IncidentUrl endswith incidentArmId
| summarize arg_max(TimeGenerated, *) by IncidentNumber
| project Title, Severity, Status, RelatedAnalyticRuleIds, AlertIds
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

## Advanced Deployment

Deployment of the Sentinel Triage AssistanT should typically be performed from the [deployment template](/Deploy/readme.md), however in some cases you may wish to deploy an individual module below.

[![Deploy to Azure](https://aka.ms/deploytoazurebutton)](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Fbriandelmsft%2FSentinelAutomationModules%2Fmain%2FModules%2FKQLModule%2Fazuredeploy.json)

## Post Deployment

* Grant the Logic app managed identity access to the Log Analytics API application permissions Data.Read (GrantPermissions.ps1)
* Grant the Logic app managed identity access to the Microsoft 365 Security API permissions AdvancedHunting.Read.All (GrantPermissions.ps1)
* Grant the Logic app Microsoft Sentinel Responder RBAC role on the resource group containing Microsoft Sentinel (GrantPermissions.ps1)
