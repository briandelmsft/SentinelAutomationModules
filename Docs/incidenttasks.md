# Sentinel Triage AssistanT (STAT) :hospital: - Incident Tasks (Preview)

Microsoft Sentinel now supports the addition of [tasks](https://learn.microsoft.com/azure/sentinel/work-with-tasks) to incidents.  Tasks have a more prominent place in the incident interface than comments do so it can help draw attention to important steps for an analyst to follow.

STAT now has limited support to add incident tasks to the corresponding incident.

Tasks will only be added if there is a finding from STAT.  For example, if the KQL module is used and no records are found based on your search, no task will be added to the incident.

To use the Incident Tasks feature, when adding a supported module to your Logic app, select the *Add new parameter* option and check off *AddIncidentTask* and *IncidentTaskInstructions*.

|Setting|Description|
|---|---|
|AddIncidentTask|When true, an incident task will be added if this module finds any relevant data|
|IncidentTaskInstructions|The instructions placed here will be added to the incident task for your analyst to review|

## Supported Modules

Incident tasks are currently supported in the following modules.  Additional module support will be added in the future.:

* AAD Risks Module
* KQL Module
* Related Alerts Module
* Threat Intel Module
* UEBA Module
* Watchlist Module

## Incident Tasks Example


---
[Documentation Home](readme.md)