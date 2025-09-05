-- Lua language server configuration
local M = {}

function M.setup()
  local utils = require "custom.configs.lsp.utils"

  -- Setup Lua language server
  utils.lspconfig.lua_ls.setup {
    on_attach = utils.on_attach,
    capabilities = utils.capabilities,
    settings = {
      Lua = {
        runtime = {
          -- LuaJIT in the case of Neovim
          version = "LuaJIT",
          -- Setup your lua path
          path = vim.split(package.path, ";"),
        },
        diagnostics = {
          -- Get the language server to recognize the `vim` global
          globals = { "vim" },
        },
        workspace = {
          -- Make the server aware of Neovim runtime files
          library = {
            [vim.fn.expand "$VIMRUNTIME/lua"] = true,
            [vim.fn.stdpath "config" .. "/lua"] = true,
          },
        },
        -- Do not send telemetry data containing a randomized but unique identifier
        telemetry = {
          enable = false,
        },
      },
    },
  }
end

return M
