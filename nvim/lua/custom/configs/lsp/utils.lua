-- Shared utilities for LSP configurations
local M = {}

-- Common variables
M.on_attach = require("plugins.configs.lspconfig").on_attach
M.capabilities = require("plugins.configs.lspconfig").capabilities
M.lspconfig = require "lspconfig"
M.configs = require "lspconfig/configs"
M.util = require "lspconfig/util"

-- Extend capabilities for snippet support
M.capabilities.textDocument.completion.completionItem.snippetSupport = true

-- Node executable paths
M.node_path = "/home/tuna/.nvm/versions/node/v20.15.0"
M.vue_ls_path = M.node_path .. "/lib/node_modules/@vue/language-server"

-- Helper function to setup multiple servers with the same config
M.setup_servers = function(servers, extra_options)
  extra_options = extra_options or {}

  for _, lsp in ipairs(servers) do
    local options = {
      on_attach = M.on_attach,
      capabilities = M.capabilities,
    }

    -- Merge any extra options
    for k, v in pairs(extra_options) do
      options[k] = v
    end

    M.lspconfig[lsp].setup(options)
  end
end

return M
