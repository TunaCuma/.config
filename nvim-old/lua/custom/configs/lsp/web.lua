-- Web development related language servers (JS, TS, Vue, CSS)
local M = {}

function M.setup()
  local utils = require "custom.configs.lsp.utils"

  -- TypeScript with Vue support
  utils.lspconfig.ts_ls.setup {
    init_options = {
      plugins = {
        {
          name = "@vue/typescript-plugin",
          location = utils.vue_ls_path,
          languages = { "vue" },
        },
      },
    },
    on_attach = utils.on_attach,
    capabilities = utils.capabilities,
    filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue" },
  }

  -- CSS Language Server
  utils.lspconfig.cssls.setup {
    cmd = { utils.node_path .. "/bin/vscode-css-language-server", "--stdio" },
    on_attach = utils.on_attach,
    capabilities = utils.capabilities,
  }

  -- Setup TailwindCSS and ESLint
  utils.setup_servers { "tailwindcss", "eslint" }

  -- Commented out Volar config in case you want to re-enable it later
  --[[
  utils.lspconfig.volar.setup {
    on_attach = utils.on_attach,
    capabilities = utils.capabilities,
    filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue", "json" },
    init_options = {
      typescript = {
        tsdk = utils.node_path .. "/lib/node_modules/typescript/lib",
      },
    },
    settings = {
      vue = {
        format = {
          enable = false,
        },
        htmlFormatEnable = false,
      },
      typescript = {
        format = {
          enable = false,
        },
      },
      javascript = {
        format = {
          enable = false,
        },
      },
      ["vue-semantic-server"] = {
        format = {
          enable = false,
        },
      },
      ["vue-language-server"] = {
        format = {
          enable = false,
        },
      },
    },
  }
  --]]
end

return M
