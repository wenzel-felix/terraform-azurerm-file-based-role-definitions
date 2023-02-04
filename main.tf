locals {
  role_definition_files = fileset(var.role_definitions_path, "**/*.json")
  role_definitions_list = [for definition_file in local.role_definition_files : jsondecode(file("${var.role_definitions_path}${definition_file}"))]
  role_definitions_map  = { for definition in local.role_definitions_list : definition.properties.roleName => definition.properties }
}

resource "azurerm_role_definition" "main" {
  for_each    = local.role_definitions_map
  name        = each.key
  scope       = each.value.assignableScopes[0]
  description = each.value.description

  permissions {
    actions          = lookup(each.value.permissions[0], "actions", [])
    not_actions      = lookup(each.value.permissions[0], "notActions", [])
    data_actions     = lookup(each.value.permissions[0], "dataActions", [])
    not_data_actions = lookup(each.value.permissions[0], "notDataActions", [])
  }

  assignable_scopes = each.value.assignableScopes
}