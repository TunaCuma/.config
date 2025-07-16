local M = {}

function M.setup()
  local lspconfig = require "lspconfig"
  local utils = require "custom.configs.lsp.utils"
  local capabilities = utils.capabilities

  lspconfig.kotlin_language_server.setup {
    capabilities = capabilities,
    on_attach = utils.on_attach,
    root_dir = lspconfig.util.root_pattern("settings.gradle", "settings.gradle.kts", ".git"),
  }
end

return M
