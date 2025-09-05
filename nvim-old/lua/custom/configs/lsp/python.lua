-- Python language server configuration
local M = {}

function M.setup()
  local utils = require "custom.configs.lsp.utils"

  -- Setup Jedi Language Server for Python
  utils.lspconfig.jedi_language_server.setup {
    on_attach = utils.on_attach,
    capabilities = utils.capabilities,
    -- Optional settings based on the documentation
    settings = {
      jedi = {
        jediSettings = {
          autoImportModules = {},
          caseInsensitiveCompletion = true,
          debug = false,
        },
        completion = {
          disableSnippets = false,
          resolveEagerly = false,
          ignorePatterns = {},
        },
        diagnostics = {
          enable = true,
          didOpen = true,
          didChange = true,
          didSave = true,
        },
        hover = {
          enable = true,
        },
        workspace = {
          extraPaths = {},
          symbols = {
            ignoreFolders = { ".nox", ".tox", ".venv", "__pycache__", "venv" },
            maxSymbols = 20,
          },
        },
      },
    },
  }
end

return M
