---@class M
---@field ui table
---@field plugins string

local M = {}
M.ui = {
  theme = "onedark",

  -- Override to make comments red
  hl_override = {
    -- Additional comment highlight groups
    ["@comment"] = { fg = "#FF3333" },
  },
}
M.plugins = "custom.plugins"
return M
