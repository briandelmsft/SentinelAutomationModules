# STAT Custom Logic Apps Connector

This custom connector for logic apps will link the STAT modules together to provide an easy to use interface to call each module and handle the returned results.

## Pre-Requisites

To deploy this version of the connector you must have already deployed the Base Module and OOF Modules and have the resource IDs to each of those logic apps.

## Advanced Deployment

Deployment of the Sentinel Triage AssistanT should typically be performed from the [deployment template](/Deploy/readme.md), however in some cases you may wish to deploy just the connector template below.

[![Deploy to Azure](https://aka.ms/deploytoazurebutton)](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Fbriandelmsft%2FSentinelAutomationModules%2Fstatconnector%2FConnector%2Fazuredeploy.json)