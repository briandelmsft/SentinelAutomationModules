# Sentinel Triage AssistanT (STAT) :hospital:

The Microsoft Sentinel Triage AssistanT (STAT) is a library of callable Automation [Modules](/Modules/readme.md) that can be used from Incident based Azure Sentinel playbooks.  These modules will simplify automation by moving the complex tasks into these callable modules so they can be performed consistently and with ease from a parent playbook.

The Base Module prepares and enriches Incident and entity data for each of the triage modules which consumes this data and performs analysis against the entities related to the incident the automation is triaging.  These triage modules will return a easy to use, well documented schema so you can evaluate the outputs and quickly make decisions about how to handle an incident.

Project goals include:

* Reducing the time (and cost) of building Azure Sentinel Automation
* Reducing the time to test Azure Sentinel Automation through the use of consistent callable modules
* Increasing SOC efficiency by triaging Incidents before they reach an analyst

Many of the Azure Sentinel playbook templates available today focus on Notification, Incident Enrichment and Remediation.  This project focuses on the triage and analysis of an incident to provide additional confidence in the quality of the incident before taking actions.  When the incident is determined to be low quality (likely a benign positive), it can be closed or lowered in severity through these automation flows.  When the incident is determined to be of higher quality, it can be raised in severity, assigned to an analyst or even trigger a remediation task.

The full solution is available for deployment in the [Deployment](/Deploy/readme.md) section.  Please note there is no stable release currently available for this project.  This is an early build of this solution and is subject to bugs and significant change as we work to provide an initial preview release.
