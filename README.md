# Microsoft Sentinel Triage AssistanT (STAT) v1 (Archived) :hospital:

## STAT v2 is now available

STAT v2 is now available in the main branch, all future deployments should use v2.  However, v1 can still be updated through this branch of the repository.


The Microsoft Sentinel Triage AssistanT (STAT) is a Logic Apps Custom Connector that calls on a library of Automation [Modules](/Modules/) that can be used from Incident based Microsoft Sentinel playbooks.  This connector and modules simplify automation by moving complex automation tasks into these callable modules so they can be performed consistently and with ease from the Logic Apps Connector.

Using the Microsoft Sentinel Triage AssistanT starts by calling the Base Module.  This module prepares and enriches Incident and entity data for each of the triage modules which consumes this data.  Once the Base Module has been called the triage modules can be used to perform analysis against the entities related to the Microsoft Sentinel incident.  These triage modules will return an easy to use, well documented result so you can evaluate the outputs and quickly make decisions about how to handle an incident.

Project goals include:

* Reducing the time (and cost) of building Microsoft Sentinel Automation
* Reducing the time to test Microsoft Sentinel Automation through the use of consistent callable modules
* Increasing SOC efficiency by triaging Incidents before they reach an analyst

Many of the Microsoft Sentinel playbook templates available today focus on Notification, Incident Enrichment and Remediation.  This project focuses on the triage and analysis of an incident to provide additional confidence in the quality of the incident before taking actions.  When the incident is determined to be low quality (likely a benign positive), it can be closed or lowered in severity through these automation flows.  When the incident is determined to be of higher quality, it can be raised in severity, assigned to an analyst or even trigger a remediation task.

The full solution is available for deployment in the [Deployment](/Deploy/) section and additional documentation can be found in [Docs](/Docs/).

If you have any questions about this project or would like to provide suggestions to the STAT project maintainers please open an [issue](https://github.com/briandelmsft/SentinelAutomationModules/issues/new/choose).
