# Sentinel Triage AssistanT (STAT) :hospital: - Authentication

The Microsoft Sentinel Triage AssistanT (STAT) makes use of multiple APIs such as the Microsoft Graph, Azure Resource Manager, Microsoft 365 Defender and more.  To access these APIs, the STAT function must authenticate against these services.

Multiple methods of authentication are supported by STAT and each of these methods requires different configuration on the STAT Function.  This configuration is typically deployed automatically during the STAT deployment, however it can be changed post deployment.

The type of identity used is determined the by the presence of Application Settings found under the Configuration menu of the STAT Function App.

## Authentication Types

### System Assigned Managed Identity

Using a system assigned managed identity is the default and recommend method to deploy STAT for most scenarios.  We recommend this approach because there is no need for the manual management of secrets, and the access given to STAT's identity can't be shared by other services running in the Azure tenant.

|Required Application Setting|Description|
|---|---|
|AZURE_TENANT_ID|The Azure AD Tenant GUID associated with the Azure subscription where the function resides|

> The presence of either of the following additional application settings may result in a different authentication method being selected: AZURE_CLIENT_ID or KEYVAULT_ENDPOINT

### User Assigned Managed Identity

Like a system assigned managed identity, with a user assigned managed there is no need for manual management of secrets.  The main difference with this identity type is that it can be shared across multiple services, giving those services the same access rights.

|Required Application Setting|Description|
|---|---|
|AZURE_TENANT_ID|The Azure AD Tenant GUID associated with the Azure subscription where the function resides|
|AZURE_CLIENT_ID|The Client ID GUID of the associated User Assigned Managed identity|

> The presence of either of the following additional application settings may result in a different authentication method being selected: AZURE_CLIENT_SECRET or KEYVAULT_ENDPOINT

### Service Principal

Using a Service Principal requires the administrators to manually manage and rotate the associated secrets, so it should be used only when necessary.  One scenario where this authentication method is necessary is multi-tenant environments such as for MSSP organizations.

|Required Application Setting|Description|
|---|---|
|AZURE_TENANT_ID|The Azure AD Tenant GUID associated with the Azure subscription where the function resides|
|AZURE_CLIENT_ID|The Client ID GUID of the selected Service Principal|
|AZURE_CLIENT_SECRET|A valid secret for the Service Principal identified in the AZURE_CLIENT_ID|

> The presence of the following additional application setting may result in a different authentication method being selected: KEYVAULT_ENDPOINT

### Service Principal with Key Vault Secret Storage

When using Service Principal authentication, you may wish to further protect the secret using Azure Key Vault.  To use Azure Key Vault you must first:

1.  Provision your own Azure Key Vault
2.  Determine how you want to authenticate against that Key Vault (System Assigned Managed Identity or User Assigned Managed Identity)
3.  Grant the selected identity access to the key vault via an access policy to retrieve secrets
4.  Store the Service Principal Secret in the key vault
5.  Manually configure STAT to use Key Vault via the STAT Function -> Configuration -> Application Settings

|Required Application Setting|Required|Description|
|---|---|---|
|AZURE_TENANT_ID|Yes|The Azure AD Tenant GUID associated with the Azure subscription where the function resides|
|AZURE_CLIENT_ID|No|The Client ID GUID of the User Assigned Managed Identity if using User Assigned Managed Identity to access Key Vault|
|KEYVAULT_ENDPOINT|Yes|The FQDN of the Keyvault containing the secret (Example: contoso.vault.azure.net)|
|KEYVAULT_SECRET_NAME|Yes|The name of the stored secret in Key Vault|
|KEYVAULT_CLIENT_ID|Yes|The Service Principal Client ID GUID associated with the secret stored in Key Vault|

## Authentication Precedence

If the configured application settings match with multiple authentication methods, the authentication method used with be selected in this order:

1.  Service Principal with Key Vault Secret Storage
2.  Service Principal
3.  User Assigned Managed Identity
4.  System Assigned Managed Identity

---
[Documentation Home](readme.md)
