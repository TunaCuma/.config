-- HTML, Emmet and markup related language servers
local M = {}

function M.setup()
  local utils = require "custom.configs.lsp.utils"

  -- Check if emmet_language_server is already configured
  if not utils.lspconfig.emmet_language_server then
    utils.configs.emmet_language_server = {
      default_config = {
        cmd = { utils.node_path .. "/bin/emmet-language-server", "--stdio" },
        filetypes = {
          "html",
          "typescriptreact",
          "javascriptreact",
          "javascript",
          "typescript",
          "javascript.jsx",
          "typescript.tsx",
          "css",
          "astro",
          "eruby",
          "htmldjango",
          "less",
          "pug",
          "sass",
          "scss",
          "svelte",
          "vue",
        },
        root_dir = utils.util.root_pattern("package.json", ".git"),
        settings = {
          vue = {
            extends = "javascriptreact",
          },
          javascript = {
            extends = "javascriptreact",
          },
        },
      },
    }
  end

  -- Setup emmet_language_server
  utils.lspconfig.emmet_language_server.setup {
    on_attach = utils.on_attach,
    capabilities = utils.capabilities,
    settings = {
      vue = {
        extends = "javascriptreact",
      },
      javascript = {
        extends = "javascriptreact",
      },
    },
  }
end

return M
