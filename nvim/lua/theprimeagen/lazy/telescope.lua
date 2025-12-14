return {
	"nvim-telescope/telescope.nvim",
	tag = "0.1.5",
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
	config = function()
		local actions = require("telescope.actions")
		require("telescope").setup({
			defaults = {
				path_display = { "truncate" },
				mappings = {
					i = {
						["<Esc>"] = actions.close,
					},
				},
			},
		})
		local builtin = require("telescope.builtin")
		-- Track test directory filter state
		local exclude_tests = true
		local function get_vimgrep_args()
			local base_args = {
				"rg",
				"--color=never",
				"--no-heading",
				"--with-filename",
				"--line-number",
				"--column",
				"--smart-case",
			}

			if exclude_tests then
				return vim.list_extend(base_args, {
					"--glob",
					"!*test*",
					"--glob",
					"!**/__tests__/**",
					"--glob",
					"!scripts/DAPS-script/**",
					"--glob",
					"!scripts/udemy-data-contracts/**",
				})
			else
				return base_args
			end
		end
		vim.keymap.set("n", "<leader>pf", builtin.git_files, {})
		vim.keymap.set("n", "<C-p>", builtin.find_files, {})
		vim.keymap.set("n", "<leader>pws", function()
			local word = vim.fn.expand("<cword>")
			builtin.grep_string({ search = word, vimgrep_arguments = get_vimgrep_args() })
		end)
		vim.keymap.set("n", "<leader>pWs", function()
			local word = vim.fn.expand("<cWORD>")
			builtin.grep_string({ search = word, vimgrep_arguments = get_vimgrep_args() })
		end)
		vim.keymap.set("n", "<leader>ps", function()
			builtin.grep_string({ search = vim.fn.input("Grep > "), vimgrep_arguments = get_vimgrep_args() })
		end)
		vim.keymap.set("n", "<leader>pk", function()
			require("telescope.builtin").live_grep({ vimgrep_arguments = get_vimgrep_args() })
		end, { desc = "Live grep" })
		vim.keymap.set("n", "<leader>pt", function()
			exclude_tests = not exclude_tests
			vim.notify("Test files " .. (exclude_tests and "excluded" or "included"), vim.log.levels.INFO)
		end, { desc = "Toggle test file filtering" })
		vim.keymap.set("n", "<leader>vh", builtin.help_tags, {})
	end,
}
