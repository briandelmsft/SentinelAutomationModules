# Sentinel Triage AssistanT (STAT) :hospital: - How it Works

> [!NOTE]
> STAT documentation is being relocated to the builin [Wiki](https://github.com/briandelmsft/SentinelAutomationModules/wiki)

The Sentinel Triage AssistanT consists of 3 components

* Sentinel Playbook (Logic App)
* Logic Apps Custom Connector
* STAT Function

## Sentinel Playbook (Logic App)

When a Sentinel incidient is created that requires triage, a Sentinel Playbook will be started using an [automation rule](https://docs.microsoft.com/azure/sentinel/automate-incident-handling-with-automation-rules).  This playbook will start with a Sentinel Incident trigger and be used to call the Sentinel Triage AssistanT through the Logic Apps Custom Connector.  Once the triage information is receieved from STAT, this Playbook can then determine the outcome of the incident.

Here is a high level view of the information flow using STAT:

![STAT Information Flow](images/statoverview.png)

## Logic Apps Custom Connector

The Logic Apps Custom Connector (STAT Connector) serves as the user interface of STAT.  All automations built on the STAT platform will use this custom connector to retrieve relevant information about the incident or alert and return that information into the Sentinel Playbook for a determination to be made.  The STAT Connector works in a similar way to built-in Logic App connectors so if you already have experience with Logic Apps this will be a familiar interface.

## STAT Function

Today a series of 13 modules have been released for STAT.  These modules also operate behind the scenes but it is important to understand their capabilites to make the best use of the solution.  Each module is responsible for getting specfic insights into the entities associated with the incident or alert and returning those insights in a easy to use format back to the STAT Connector.

When using STAT, the first module you should call from the STAT Connector is the Base Module.  The Base Module performs some enrichment activities to prepare the incident data for the rest of the STAT solution.  All other modules will require inputs from this Base module so they should be called after the Base Module has processed the incident data.

An example of the use of multiple modules can be found in the [Sample](sample.md) playbook included during the deployment.

More information about the automation modules can be located within the [Modules](/Modules/) folders.

---
[Documentation Home](readme.md)
