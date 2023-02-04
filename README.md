# terraform-azurerm-file-based-role-definitions

This terraform module allows the user to create Azure custom roles based on json files compatible with the default Azure json format for roles. By providing this setup the terraform code itself is highly minimized while also allowing better overview through a fully customizable file structure.

Here are some example structure:

simple:
```bash
.
├── main.tf
├── variables.tf
├── output.tf
└── role_definitions/
    ├── role_definition1.json
    └── role_definition2.json
```

complex:
```bash
.
├── main.tf
├── variables.tf
├── output.tf
└── role_assignments/
    ├── root_role1.json
    ├── root_role2.json
    ├── management_group1/
    │   ├── mgnt1_role1.json
    │   ├── mgnt1_role2.json
    │   └── management_group3/
    │       ├── subscription1/
    │       │   └── sub1_role1.json
    │       └── subscription2/
    │           └── sub2_role1.json
    └── management_group2/
        ├── mgnt2_role1.json
        └── mgnt2_role1.json
```

The individual json-files represent each a role object like so:

```
    {
        "properties": {
            "roleName": "Owner",
            "description": "Grants full access to manage all resources, including the ability to assign roles in Azure RBAC.",
            "assignableScopes": [
                "/"
            ],
            "permissions": [
                {
                    "actions": [
                        "*"
                    ],
                    "notActions": [],
                    "dataActions": [],
                    "notDataActions": []
                }
            ]
        }
    }
```
> **_NOTE:_**  
The **id** included in the json files of existing roles is generated on creation and thereby not required. Nevertheless, if you copy other role files which include the **id**, it will be ignored.