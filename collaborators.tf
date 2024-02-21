# little hack to refresh collobarators on every apply
#   source: https://stackoverflow.com/a/73752527/129269
resource "value_unknown_proposer" "default" {}
resource "value_is_known" "collaborators" {
  value            = local.collaborators
  guid_seed        = var.repository
  proposed_unknown = value_unknown_proposer.default.value
}

resource "github_repository_collaborator" "collaborator" {
  repository = resource.github_repository.this.name
  for_each   = value_is_known.collaborators.result ? local.collaborators : []
  username   = each.value
  permission = "push"
}
