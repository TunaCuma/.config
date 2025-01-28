-- Import necessary modules
local on_attach = require("plugins.configs.lspconfig").on_attach
local capabilities = require("plugins.configs.lspconfig").capabilities
local lspconfig = require "lspconfig"
local configs = require "lspconfig/configs"
local util = require "lspconfig/util"
local vue_language_server_path = "/home/tuna/.nvm/versions/node/v20.15.0/lib/node_modules/@vue/language-server"

-- Extend capabilities for snippet support
capabilities.textDocument.completion.completionItem.snippetSupport = true

-- Check if emmet_language_server is already configured
if not lspconfig.emmet_language_server then
  configs.emmet_language_server = {
    default_config = {
      cmd = { "/home/tuna/.nvm/versions/node/v20.15.0/bin/emmet-language-server", "--stdio" },
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
      root_dir = util.root_pattern("package.json", ".git"),
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
lspconfig.emmet_language_server.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  settings = {
    vue = {
      extends = "javascriptreact",
    },
    javascript = {
      extends = "javascriptreact",
    },
  },
}

lspconfig.volar.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue", "json" },
  init_options = {
    typescript = {
      tsdk = "/home/tuna/.nvm/versions/node/v20.15.0/lib/node_modules/typescript/lib",
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

lspconfig.ts_ls.setup {
  init_options = {
    plugins = {
      {
        name = "@vue/typescript-plugin",
        location = vue_language_server_path,
        languages = { "vue" },
      },
    },
  },
  filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue" },
}

-- Setup other servers
local servers = { "tailwindcss", "eslint", "cssls" }
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    capabilities = capabilities,
  }
end
lspconfig.cssls.setup {
  cmd = { "/home/tuna/.nvm/versions/node/v20.15.0/bin/vscode-css-language-server", "--stdio" },
  on_attach = on_attach,
  capabilities = capabilities,
}
-- Setup Lua language server
lspconfig.lua_ls.setup {
  on_attach = on_attach,
  capabilities = capabilities,
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
