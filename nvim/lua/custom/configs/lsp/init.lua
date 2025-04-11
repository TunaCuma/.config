-- Main LSP configuration entry point
local M = {}

-- Import all LSP module configurations
function M.setup()
  -- Load common utilities first
  local utils = require "custom.configs.lsp.utils"

  -- Load individual language server configurations
  require("custom.configs.lsp.web").setup()
  require("custom.configs.lsp.python").setup()
  require("custom.configs.lsp.php").setup()
  require("custom.configs.lsp.markup").setup()
  require("custom.configs.lsp.lua").setup()

  -- Any additional setup that needs to happen after all LSPs are configured
end

return M
