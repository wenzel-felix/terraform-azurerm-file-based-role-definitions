output "role_definition_map" {
  value = { for definition in azurerm_role_definition.main : definition.name => definition }
}