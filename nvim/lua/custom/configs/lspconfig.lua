
local on_attach = require("plugins.configs.lspconfig").on_attach
local capabilities = require("plugins.configs.lspconfig").capabilities
local lspconfig = require("lspconfig")
local configs = require("lspconfig/configs")
local util = require("lspconfig/util")

-- Extend capabilities for snippet support
capabilities.textDocument.completion.completionItem.snippetSupport = true

-- Check if emmet_language_server is already configured
if not lspconfig.emmet_language_server then
  configs.emmet_language_server = {
    default_config = {
      cmd = {"/home/tuna/.nvm/versions/node/v20.15.0/bin/emmet-language-server", "--stdio"},
      filetypes = {
        "html", "typescriptreact", "javascriptreact", "javascript",
        "typescript", "javascript.jsx", "typescript.tsx", "css",
        "astro", "eruby", "htmldjango", "less", "pug", "sass", "scss", "svelte", "vue"
      },
      root_dir = util.root_pattern("package.json", ".git"),
      settings = {
        javascript = {
          extends = "javascriptreact"
        }
      },
    },
  }
end

-- Setup emmet_language_server
lspconfig.emmet_language_server.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  settings = {
    javascript = {
      extends = "javascriptreact"
    }
  },
}



-- Setup other servers
local servers = {"tsserver", "tailwindcss", "eslint", "cssls"}

for _, lsp in ipairs(servers) do lspconfig[lsp].setup {
    on_attach = on_attach,
    capabilities = capabilities,
  }
end
