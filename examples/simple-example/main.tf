terraform {
  required_providers {
  }
}

provider "azurerm" {
  features {
  }
}

module "role_definitions" {
  source                = "../.."
  role_definitions_path = "role_definitions/"
}

data "azurerm_client_config" "current" {}

resource "local_file" "foo" {
  content  = <<EOF
    {
      "properties": {
        "roleName": "Log Analytics Reader Test",
        "description": "Log Analytics Reader can view and search all monitoring data as well as and view monitoring settings, including viewing the configuration of Azure diagnostics on all Azure resources.",
        "assignableScopes": [
            "/subscriptions/${data.azurerm_client_config.current.subscription_id}"
        ],
        "permissions": [
          {
            "actions": [
                "*/read",
                "Microsoft.OperationalInsights/workspaces/analytics/query/action",
                "Microsoft.OperationalInsights/workspaces/search/action",
                "Microsoft.Support/*"
            ],
            "notActions": [
                "Microsoft.OperationalInsights/workspaces/sharedKeys/read"
            ],
            "dataActions": [],
            "notDataActions": []
          }
        ]
      }
    }
  EOF
  filename = "role_definitions/myRoleDefinition.json"
}
