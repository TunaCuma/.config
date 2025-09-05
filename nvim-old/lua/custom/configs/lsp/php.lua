-- PHP language server configuration
local M = {}

function M.setup()
  local utils = require "custom.configs.lsp.utils"

  utils.lspconfig.phpactor.setup {
    on_attach = utils.on_attach,
    capabilities = utils.capabilities,
    filetypes = { "php" },
    init_options = {
      ["language_server_phpstan.enabled"] = false,
      ["language_server_psalm.enabled"] = false,
    },
  }
end

return M
