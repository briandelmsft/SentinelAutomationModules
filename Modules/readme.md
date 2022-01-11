# Automation Modules Home

Automation Modules make it easier to perform routine tasks by using a common set of callable Logic Apps.  Modules should typically be deployed through the [deployment template](/Deploy/readme.md), but individual deployment templates and other information on each module can be found in these subdirectories.

## Available Modules

* Base
* Azure Active Directory Risks
* File Insights
* Kusto Query Language (KQL)
* Microsoft Defender for Cloud Apps (MCAS)
* Microsoft Defender for Endpoint
* Office 365 Out of Office
* Microsoft Sentinel Related Alerts
* Microsoft Sentinel Threat Intelligence
* Microsoft Sentinel User Entity Behavior Analytics
* Microsoft Sentinel Watchlists

### Base Module

The Base module processes incident data and prepares it for consumption by other modules.  This includes enriching entity data with Azure AD lookups and IP data with Geo location information.

### Azure Active Directory Risks

The Azure Active Directory Risks module will retrieve the level of risk of the users in Azure AD Identity Protection as well as MFA Fraud Reports and MFA Failures.

### File Insights

The File Insights module will check if the entities are found as email attachments and will run the FileProfile() function on the provided hashes.

### Kusto Query Language (KQL)

The KQL module allows you to run custom KQL queries against Microsoft Sentinel or Microsoft 365 Security Advanced Hunting using the entity data from the Microsoft Sentinel incident.

### Microsoft Defender for Cloud Apps (MCAS)

The Microsoft Defender for Cloud Apps module will get the MCAS Investigation Score of the account entities of the incidient.

### Microsoft Defender for Endpoint

The Microsoft Defender for Endpoint module will return the risk score and exposure level from Microsoft Defender for Endpoint of all the machines on which a user logged on interactively and for all machines with specified IP addresses.

### Office 365 Out of Office

The Out Of Office module takes user entity data and determines if the user has an Out of Office message set on their Office 365 mailbox.

### Microsoft Sentinel Related Alerts

The Related Alerts module takes the incident entity data and determines if other alerts about those same entities exist in Microsoft Sentinel within a specified timeframe.

### Microsoft Sentinel Threat Intelligence

The Threat Intelligence module takes the incident entities and allows you to cross refernce them against data in the ThreatIntelligenceIndicator table.

### Microsoft Sentinel User Entity Behavior Analytics

The UEBA module allows you to take user entity data and lookup those users in the BehaviorAnalytics table to identity activities performed by the user that deviate from their previous patterns of behavior.

### Microsoft Sentinel Watchlists

The Microsoft Sentinel Watchlists module allows you to compare entity data from an incident against a watchlist to determine if that entity is present.  This supports watchlists containing columns with UserPrincipalNames, IP Addresses, or CIDR address blocks.