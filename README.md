# Sentinel Triage AssistanT (STAT) :hospital:

The Microsoft Sentinel Triage AssistanT (STAT) is a Logic Apps Custom Connector that calls on a library of Automation [Modules](/Modules/) that can be used from Incident based Microsoft Sentinel playbooks.  This connector and modules will simplify automation by moving the complex tasks into these callable modules so they can be performed consistently and with ease from the Logic Apps Connector.

Using the Sentinel Triage AssistanT starts by calling the Base Module.  This module prepares and enriches Incident and entity data for each of the triage modules which consumes this data and performs analysis against the entities related to the incident the automation is triaging.  These triage modules will return an easy to use, well documented schema so you can evaluate the outputs and quickly make decisions about how to handle an incident.

Project goals include:

* Reducing the time (and cost) of building Microsoft Sentinel Automation
* Reducing the time to test Microsoft Sentinel Automation through the use of consistent callable modules
* Increasing SOC efficiency by triaging Incidents before they reach an analyst

Many of the Microsoft Sentinel playbook templates available today focus on Notification, Incident Enrichment and Remediation.  This project focuses on the triage and analysis of an incident to provide additional confidence in the quality of the incident before taking actions.  When the incident is determined to be low quality (likely a benign positive), it can be closed or lowered in severity through these automation flows.  When the incident is determined to be of higher quality, it can be raised in severity, assigned to an analyst or even trigger a remediation task.

The full solution is available for deployment in the [Deployment](/Deploy/) section.  Please note this solution is still under active development and subject to frequent and significant changes.  This is an early build of this solution and is subject to bugs and significant change as we work to provide an initial preview release early in 2022.
