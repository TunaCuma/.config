-- TODO
-- add the following plugins
-- 1. flash.nvim
-- 2. nvim-spectre
-- 3. nvim-dap
-- 5. quickfix
local plugins = {
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "plugins.configs.lspconfig"
      require "custom.configs.lspconfig"
    end,
  },
  {
    "jellydn/hurl.nvim",
    dependencies = {
      "MunifTanjim/nui.nvim",
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      -- Optional, for markdown rendering with render-markdown.nvim
      {
        "MeanderingProgrammer/render-markdown.nvim",
        opts = {
          file_types = { "markdown" },
        },
        ft = { "markdown" },
      },
    },
    ft = { "hurl" },
    opts = {
      -- Show debugging info
      debug = false,
      -- Show notification on run
      show_notification = false,
      -- Show response in popup or split
      mode = "split",
      -- Default formatter
      formatters = {
        json = { "jq" }, -- Make sure you have install jq in your system, e.g: brew install jq
        html = {
          "prettier",    -- Make sure you have install prettier in your system, e.g: npm install -g prettier
          "--parser",
          "html",
        },
        xml = {
          "tidy", -- Make sure you have installed tidy in your system, e.g: brew install tidy-html5
          "-xml",
          "-i",
          "-q",
        },
      },
      -- Default mappings for the response popup or split views
      mappings = {
        close = "q",          -- Close the response popup or split view
        next_panel = "<C-n>", -- Move to the next response popup window
        prev_panel = "<C-p>", -- Move to the previous response popup window
      },
    },
    keys = {
      -- Run API request
      { "<leader>J",  "<cmd>HurlRunner<CR>",        desc = "Run All requests" },
      { "<leader>j",  "<cmd>HurlRunnerAt<CR>",      desc = "Run Api request" },
      { "<leader>te", "<cmd>HurlRunnerToEntry<CR>", desc = "Run Api request to entry" },
      { "<leader>tE", "<cmd>HurlRunnerToEnd<CR>",   desc = "Run Api request from current entry to end" },
      { "<leader>tm", "<cmd>HurlToggleMode<CR>",    desc = "Hurl Toggle Mode" },
      { "<leader>tv", "<cmd>HurlVerbose<CR>",       desc = "Run Api in verbose mode" },
      { "<leader>tV", "<cmd>HurlVeryVerbose<CR>",   desc = "Run Api in very verbose mode" },
      -- Run Hurl request in visual mode
      { "<leader>h",  ":HurlRunner<CR>",            desc = "Hurl Runner",                              mode = "v" },
    },
  },
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "luacheck",
        "eslint-lsp",
        "prettierd",
        "tailwindcss-language-server",
        "typescript-language-server",
        "vue-language-server",
        "emmet-language-server",
        "lua-language-server",
      },
    },
  },
  {
    "mg979/vim-visual-multi",
    branch = "master",
    lazy = false,
    init = function()
      vim.g.VM_maps = {
        ["Find Under"] = "<C-n>",
      }
    end,
  },
  {
    "Aasim-A/scrollEOF.nvim",
    lazy = false,
    config = function()
      -- This is where you can configure scrollEOF.nvim
      require("scrollEOF").setup {
        -- Example settings: You can customize these options
        pattern = "*",           -- Default is '*'
        insert_mode = false,     -- Default is false
        disabled_filetypes = {}, -- Default is empty list
        disabled_modes = {},     -- Default is empty list
      }
    end,
  },
  {
    "Febri-i/snake.nvim",
    dependencies = {
      "Febri-i/fscreen.nvim",
    },
    opts = {},
    cmd = "SnakeStart",
    keys = {
      { "<leader>ss", "<cmd>SnakeStart<cr>", desc = "Start Snake Game" },
    },
  },
  {
    "williamboman/mason-lspconfig.nvim",
    after = "mason.nvim",
  },
  {
    "folke/trouble.nvim",
    opts = {}, -- for default options, refer to the configuration section for custom setup.
    cmd = "Trouble",
    keys = {
      {
        "<leader>dx",
        "<cmd>Trouble diagnostics toggle<cr>",
        desc = "Diagnostics (Trouble)",
      },
      {
        "<leader>dX",
        "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
        desc = "Buffer Diagnostics (Trouble)",
      },
      {
        "<leader>cs",
        "<cmd>Trouble symbols toggle focus=false<cr>",
        desc = "Symbols (Trouble)",
      },
      {
        "<leader>cl",
        "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
        desc = "LSP Definitions / references / ... (Trouble)",
      },
      {
        "<leader>dL",
        "<cmd>Trouble loclist toggle<cr>",
        desc = "Location List (Trouble)",
      },
      {
        "<leader>dQ",
        "<cmd>Trouble qflist toggle<cr>",
        desc = "Quickfix List (Trouble)",
      },
    },
  },
  {
    "folke/zen-mode.nvim",
    lazy = true,
    ft = { "markdown" },
    cmd = "ZenMode",
    keys = {
      { "<leader>wt", "<cmd>Twilight<cr>", desc = "Toggle twilight" },
      { "<leader>wz", "<cmd>ZenMode<cr>",  desc = "Toggle zen mode " },
    },
    opts = {
      window = {
        width = 0.60,
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
      },
    },
  },
  {
    "MeanderingProgrammer/render-markdown.nvim",
    opts = {
      heading = {
        backgrounds = {
          "RenderMarkdownH1Bg",
          "RenderMarkdownH5Bg",
          "RenderMarkdownH3Bg",
          "RenderMarkdownH4Bg",
          "RenderMarkdownH5Bg",
          "RenderMarkdownH6Bg",
        },
        foregrounds = {
          "RenderMarkdownH1",
          "RenderMarkdownH5",
          "RenderMarkdownH3",
          "RenderMarkdownH4",
          "RenderMarkdownH5",
          "RenderMarkdownH6",
        },
      },
      latex = {
        enabled = true,
        converter = "latex2text",
        highlight = "RenderMarkdownMath",
        top_pad = 0,
        bottom_pad = 0,
      },
    },
    dependencies = { "nvim-treesitter/nvim-treesitter", "echasnovski/mini.nvim" }, -- if you use the mini.nvim suite
    ft = { "markdown" },
    keys = {
      { "<leader>rm", "<cmd>RenderMarkdown toggle<cr>", desc = "Render markdown" },
    },
  },
  {
    "epwalsh/obsidian.nvim",
    version = "*", -- recommended, use latest release instead of latest commit
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
      },
      ui = {
        enable = false,
      },

      -- see below for full list of options 👇
    },
    keys = {
      { "<leader>op", "<cmd>ObsidianPasteImg<cr>", desc = "Paste Obsidian image" },
    },
  },
  -- {
  --     'JellyApple102/easyread.nvim',
  --     lazy = true,
  --     ft = "markdown",
  --     opts = {
  --       fileTypes = { "markdown" },
  --     },
  -- keys = {
  --       { "<leader>er", "<cmd>EasyreadToggle<cr>", desc = "Toggle easyread" },
  --     },
  -- },
  {
    -- Add easytables.nvim plugin
    {
      "Myzel394/easytables.nvim",
      config = function()
        require("easytables").setup {
          -- Your custom configuration for easytables
        }
      end,
      -- Optional: Add lazy loading settings if needed
      -- For example, load on specific commands or file types
      -- event = "VeryLazy", -- Uncomment to lazy load on event
      cmd = { "EasyTablesCreateNew", "EasyTablesImportThisTable" }, -- Uncomment to lazy load on commands
      keys = {
        { "<leader>tc", "<cmd>EasyTablesCreateNew 4x4<cr>",   desc = "Create new table" },
        { "<leader>ti", "<cmd>EasyTablesImportThisTable<cr>", desc = "Import table" },
        { "<leader>ts", "<cmd>ExportTable<cr>",               desc = "Export table" },
      },
    },
  },
  {
    "vhyrro/luarocks.nvim",
    priority = 1001, -- this plugin needs to run before anything else
    opts = {
      rocks = { "magick" },
    },
  },
  {
    "3rd/image.nvim",
    event = "VeryLazy",
    dependencies = {
      {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
      },
    },
    opts = {
      backend = "kitty",
      integrations = {
        markdown = {
          enabled = true,
          resolve_image_path = function(document_path, image_path, fallback)
            -- Define the base path of your vault
            local vault_base_path = "~/Desktop/obsidian-vault"

            -- Concatenate the vault base path with the image_path
            local adjusted_path = vault_base_path .. "/" .. image_path

            -- Return the adjusted absolute path
            return adjusted_path
          end,
          clear_in_insert_mode = false,
          download_remote_images = true,
          only_render_image_at_cursor = true,
          filetypes = { "markdown", "vimwiki" }, -- markdown extensions (ie. quarto) can go here
        },
        neorg = {
          enabled = true,
          clear_in_insert_mode = true,
          download_remote_images = true,
          only_render_image_at_cursor = false,
          filetypes = { "norg" },
        },
      },
      max_width = nil,
      max_height = nil,
      max_width_window_percentage = nil,
      max_height_window_percentage = 50,
      kitty_method = "normal",
    },
  },
  {
    "theprimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("harpoon"):setup()
    end,
    keys = {
      {
        "<leader>A",
        function()
          require("harpoon"):list():add()
        end,
        desc = "harpoon file",
      },
      {
        "<leader>a",
        function()
          local harpoon = require "harpoon"
          harpoon.ui:toggle_quick_menu(harpoon:list())
        end,
        desc = "harpoon quick menu",
      },
      {
        "<leader>1",
        function()
          require("harpoon"):list():select(1)
        end,
        desc = "harpoon to file 1",
      },
      {
        "<leader>2",
        function()
          require("harpoon"):list():select(2)
        end,
        desc = "harpoon to file 2",
      },
      {
        "<leader>3",
        function()
          require("harpoon"):list():select(3)
        end,
        desc = "harpoon to file 3",
      },
      {
        "<leader>4",
        function()
          require("harpoon"):list():select(4)
        end,
        desc = "harpoon to file 4",
      },
      {
        "<leader>5",
        function()
          require("harpoon"):list():select(5)
        end,
        desc = "harpoon to file 5",
      },
    },
  },
  {
    "ThePrimeAgen/vim-be-good",
    cmd = "VimBeGood",
  },
  {
    "nvim-treesitter/nvim-treesitter-context",
    event = "BufReadPost",
  },
  {
    "mbbill/undotree",
    cmd = "UndotreeToggle",
  },
  {
    "tpope/vim-fugitive",
    cmd = { "Git", "Gstatus", "Gcommit", "Gpush" },
  },
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    lazy = true,
    config = function()
      require("copilot").setup {
        panel = {
          auto_refresh = true,
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
          },
        },
      }
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
    ft = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
    config = function()
      require("nvim-ts-autotag").setup()
    end,
  },
  {
    "stevearc/oil.nvim",
    opts = {},
    -- Optional dependencies
    dependencies = { { "echasnovski/mini.icons", opts = {} } },
    -- dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if prefer nvim-web-devicons
    config = function()
      require("oil").setup {
        skip_confirm_for_simple_edits = true,
        lsp_file_methods = {
          -- Time to wait for LSP file operations to complete before skipping
          timeout_ms = 500000,
          -- Set to true to autosave buffers that are updated with LSP willRenameFiles
          -- Set to "unmodified" to only save unmodified buffers
          autosave_changes = "unmodified",
        },
        view_options = {
          -- Show files and directories that start with "."
          show_hidden = true,
          -- This function defines what is considered a "hidden" file
          is_hidden_file = function(name, bufnr)
            return vim.startswith(name, ".")
          end,
          -- This function defines what will never be shown, even when `show_hidden` is set
          is_always_hidden = function(name, bufnr)
            return (name == "..")
          end,
        },
      }
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
        "css",
      }
      return opts
    end,
  },
}
return plugins
