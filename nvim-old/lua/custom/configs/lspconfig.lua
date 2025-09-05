-- Main LSP configuration file
-- This file now just delegates to the modular LSP configuration

-- Load and initialize all LSP configurations
return require("custom.configs.lsp").setup()
