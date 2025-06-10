-- C/C++ language server configuration
local M = {}

function M.setup()
  local utils = require "custom.configs.lsp.utils"

  -- Setup clangd for C/C++
  utils.lspconfig.clangd.setup {
    on_attach = utils.on_attach,
    capabilities = utils.capabilities,
    cmd = {
      "clangd",
      "--background-index",
      "--clang-tidy",
      "--header-insertion=iwyu",
      "--completion-style=detailed",
      "--function-arg-placeholders",
      "--fallback-style=llvm",
    },
    filetypes = { "c", "cpp", "objc", "objcpp", "cuda", "proto" },
    root_dir = utils.util.root_pattern("compile_commands.json", "compile_flags.txt", ".git", "CMakeLists.txt"),
    single_file_support = true,
    -- Useful settings for better performance and features
    init_options = {
      compilationDatabasePath = "build",
      index = {
        threads = 0, -- Use all available threads
      },
      clangdFileStatus = true,
      usePlaceholders = true,
      completeUnimported = true,
      semanticHighlighting = true,
    },
  }
end

return M
