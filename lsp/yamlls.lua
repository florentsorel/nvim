return {
  root_markers = { ".git" },
  settings = {
    yaml = {
      schemaStore = {
        enable = true,
        url = "https://www.schemastore.org/api/json/catalog.json",
      },
      schemas = {
        kubernetes = { "k8s/*.yaml", "k8s/*.yml" },
        ["https://json.schemastore.org/github-workflow.json"] = ".github/workflows/*.{yml,yaml}",
        ["https://json.schemastore.org/github-action.json"] = ".github/actions/*/action.{yml,yaml}",
        ["https://json.schemastore.org/docker-compose.json"] = "docker-compose*.{yml,yaml}",
        ["https://docs.renovatebot.com/renovate-schema.json"] = { "renovate.json", ".renovaterc", ".renovaterc.json" },
        ["https://json.schemastore.org/dependabot-2.0.json"] = ".github/dependabot.{yml,yaml}",
      },
      validate = true,
      format = { enable = false }, -- handled by prettier via conform
    },
  },
}
