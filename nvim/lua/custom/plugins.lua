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
  "folke/zen-mode.nvim",
    lazy = true,
    ft = { "markdown" },
cmd = "ZenMode",
    dependencies = {
      {
        "folke/twilight.nvim",
        cmd = "Twilight",
        opts = {
          treesitter = false,
          dimming = {
            alpha = 0.45,
          },
        },
      },
    },
    keys = {
      { "<leader>wt", "<cmd>Twilight<cr>", desc = "Toggle twilight" },
      { "<leader>wz", "<cmd>ZenMode<cr>", desc = "Toggle zen mode " },
    },
  opts = {
      window = {
        width = .60,
        options = {
          signcolumn = "no",
          number = false,
          relativenumber = true,
          cursorline = true,
          foldcolumn = "0",
          list = true,
        },
      },
      plugins = {
        options = {
          ruler = true,
          showcmd = true,
          laststatus = 2,
        },
        tmux = {
          enabled = true,
        },
        kitty = {
          enabled = true,
          font = "+4",
        },
      }
  }
},
{
  "epwalsh/obsidian.nvim",
  version = "*",  -- recommended, use latest release instead of latest commit
  lazy = true,
  ft = "markdown",
  -- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
  -- event = {
  --   -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
  --   -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/**.md"
  --   "BufReadPre path/to/my-vault/**.md",
  --   "BufNewFile path/to/my-vault/**.md",
  -- },
  dependencies = {
    -- Required.
    "nvim-lua/plenary.nvim",

    -- see below for full list of optional dependencies 👇
  },
  opts = {
    workspaces = {
      {
        name = "main",
        path = "~/Desktop/obsidian-vault",
      },
    },

    templates = {
        folder = "~/Desktop/obsidian-vault/Templates",
      }

    -- see below for full list of options 👇
  },
  },
{
    'JellyApple102/easyread.nvim',
    lazy = true,
    ft = "markdown",
    opts = {
      fileTypes = { "markdown" },
    }
},
  {
    "theprimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("harpoon"):setup()
    end,
    keys = {
      { "<leader>A", function() require("harpoon"):list():add() end, desc = "harpoon file", },
      { "<leader>a", function() local harpoon = require("harpoon") harpoon.ui:toggle_quick_menu(harpoon:list()) end, desc = "harpoon quick menu", },
      { "<leader>1", function() require("harpoon"):list():select(1) end, desc = "harpoon to file 1", },
      { "<leader>2", function() require("harpoon"):list():select(2) end, desc = "harpoon to file 2", },
      { "<leader>3", function() require("harpoon"):list():select(3) end, desc = "harpoon to file 3", },
      { "<leader>4", function() require("harpoon"):list():select(4) end, desc = "harpoon to file 4", },
      { "<leader>5", function() require("harpoon"):list():select(5) end, desc = "harpoon to file 5", },
    },
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
