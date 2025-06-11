-- C# LSP configuration (OmniSharp)
local M = {}

function M.setup()
  local utils = require "custom.configs.lsp.utils"
  local lspconfig = require "lspconfig"
  local capabilities = utils.capabilities

  lspconfig.omnisharp.setup {
    capabilities = capabilities,
    cmd = { "omnisharp", "--languageserver", "--hostPID", tostring(vim.fn.getpid()) },
    root_dir = lspconfig.util.root_pattern("*.sln", "*.csproj", ".git"),

    -- OmniSharp settings
    settings = {
      omnisharp = {
        useModernNet = true, -- Set to false if using legacy .NET Framework
        enableRoslynAnalyzers = true,
        enableEditorConfigSupport = true,
        enableImportCompletion = true,
        enableMsBuildLoadProjectsOnDemand = true,
        organizeImportsOnFormat = true,
      },
    },

    -- Custom on_attach function for OmniSharp-specific keybindings
    on_attach = function(client, bufnr)
      -- Call the common on_attach if available in your utils
      if utils.on_attach then
        utils.on_attach(client, bufnr)
      end

      -- OmniSharp specific keymaps can be added here
      local map = function(mode, lhs, rhs, desc)
        vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
      end

      -- Basic C# keymappings
      map("n", "<leader>cst", "<cmd>lua vim.lsp.buf.type_definition()<CR>", "C# Type Definition")
      map("n", "<leader>csr", "<cmd>lua vim.lsp.buf.rename()<CR>", "C# Rename")
      map("n", "<leader>csf", "<cmd>lua vim.lsp.buf.format({ async = true })<CR>", "Format C# Code")
      map("n", "<leader>csa", "<cmd>lua vim.lsp.buf.code_action()<CR>", "C# Code Actions")
    end,
  }
end

return M
