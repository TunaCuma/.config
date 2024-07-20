local plugins = {
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "plugins.configs.lspconfig"
      require "custom.configs.lspconfig"
    end,
  },
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "eslint-lsp",
        "prettierd",
        "tailwindcss-language-server",
        "typescript-language-server",
        "emmet-language-server",
      },
    },
  },
  {
    "williamboman/mason-lspconfig.nvim",
    after = "mason.nvim"
  },
  {
    "ThePrimeAgen/vim-be-good",
    cmd = "VimBeGood"
  },
  {
    "nvim-treesitter/nvim-treesitter-context",
    event = "BufReadPost"
  },
  {
    "mbbill/undotree",
    cmd = "UndotreeToggle"
  },
  {
    "tpope/vim-fugitive",
    cmd = { "Git", "Gstatus", "Gcommit", "Gpush" }
  },
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    lazy = false,
    config = function()
      require("copilot").setup({
        panel = {
          auto_refresh = true
        },
        suggestion = {
          auto_trigger = true,
          hide_during_completion = true,
          keymap = {
            accept = "<Tab>",
            accept_word = "<M-k>",
            -- accept_line = false,
            -- next = "<M-ü>",
            -- prev = "<M-ğ>",
            dismiss = "<S-Tab>",
          }
        }
      })
    end,
  },
  {
    "nvimtools/none-ls.nvim",
    event = "VeryLazy",
    opts = function()
      return require "custom.configs.null-ls"
    end,
  },
  {
    "windwp/nvim-ts-autotag",
    ft = {"javascript", "javascriptreact", "typescript", "typescriptreact"},
    config = function()
      require("nvim-ts-autotag").setup()
    end,
  },
  {
    'stevearc/oil.nvim',
    opts = {},
    -- Optional dependencies
    dependencies = { { "echasnovski/mini.icons", opts = {} } },
    -- dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if prefer nvim-web-devicons
    config = function()
      require("oil").setup({
        skip_confirm_for_simple_edits = true,
        lsp_file_methods = {
            -- Time to wait for LSP file operations to complete before skipping
            timeout_ms = 500000,
            -- Set to true to autosave buffers that are updated with LSP willRenameFiles
            -- Set to "unmodified" to only save unmodified buffers
            autosave_changes = "unmodified",
          },
      })
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function()
      local opts = require "plugins.configs.treesitter"
      opts.ensure_installed = {
        "lua",
        "javascript",
        "typescript",
        "tsx",
        "css"
      }
      return opts
    end,
  }
}
return plugins
