return {
	"epwalsh/obsidian.nvim",
	version = "*",
	lazy = true,
	ft = "markdown",
	cmd = { "ObsidianNewFromTemplate" },
	dependencies = {
		"nvim-lua/plenary.nvim",
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
	},
	keys = {
		{
			"<leader>op",
			function()
				-- Generate filename automatically
				local current_file = vim.fn.expand("%:t:r") -- current file name without extension
				local current_dir = vim.fn.expand("%:p:h:t") -- current directory name
				local timestamp = os.date("%Y%m%d_%H%M%S") -- date and time

				-- Create the filename: directory_filename_timestamp (without .png)
				local filename = string.format("%s_%s_%s", current_dir, current_file, timestamp)

				-- Replace any spaces or special characters with underscores
				filename = filename:gsub("[%s%W]", "_"):gsub("_+", "_")

				-- Execute ObsidianPasteImg with the generated filename and .png extension
				vim.cmd("ObsidianPasteImg " .. filename .. ".png")
			end,
			desc = "Paste Obsidian image with auto-generated name",
		},
		{
			"<leader>ot",
			function()
				local current_file = vim.fn.expand("%:t:r")
				local current_dir = vim.fn.expand("%:p:h:t")
				local timestamp = os.date("%Y%m%d_%H%M%S")
				local filename = string.format("%s_%s_%s", current_dir, current_file, timestamp)
				filename = filename:gsub("[%s%W]", "_"):gsub("_+", "_")

				-- Paste the image first
				vim.cmd("ObsidianPasteImg " .. filename .. ".png")

				-- Wait for the file to be written, then process OCR
				vim.defer_fn(function()
					local vault_path = vim.fn.expand("~/Desktop/obsidian-vault")
					local img_path = vault_path .. "/assets/imgs/" .. filename .. ".png"

					print("Looking for image at: " .. img_path)

					-- Check if file exists
					if vim.fn.filereadable(img_path) == 0 then
						print("Error: Image file not found at: " .. img_path)
						return
					end

					-- Run Tesseract OCR
					print("Running OCR...")
					local cmd = string.format("tesseract '%s' stdout 2>&1", img_path)
					local handle = io.popen(cmd)
					local ocr_text = handle:read("*a")
					handle:close()

					print("OCR output length: " .. #ocr_text)

					-- Insert the transcribed text if any
					if ocr_text and #ocr_text > 0 then
						ocr_text = ocr_text:gsub("^%s+", ""):gsub("%s+$", "")
						if #ocr_text > 0 then
							print("Inserting OCR text")
							-- Move to end of file and add content below
							vim.cmd("normal G")
							vim.api.nvim_put({ "" }, "l", false, true)
							vim.api.nvim_put({ "**Transcribed text:**" }, "l", false, true)
							vim.api.nvim_put({ "```" }, "l", false, true)
							for line in ocr_text:gmatch("[^\r\n]+") do
								vim.api.nvim_put({ line }, "l", false, true)
							end
							vim.api.nvim_put({ "```" }, "l", false, true)
						else
							print("OCR returned empty text after cleaning")
						end
					else
						print("No OCR text generated")
					end
				end, 1000)
			end,
			desc = "Paste image with OCR transcription",
		},
		{
			"<leader>oy",
			function()
				-- Get the image path from the markdown link under cursor
				local line = vim.api.nvim_get_current_line()
				local img_path = line:match("%[.-%]%((.-)%)")

				if not img_path then
					print("No image link found on current line")
					return
				end

				-- Resolve relative path to absolute path
				local vault_path = vim.fn.expand("~/Desktop/obsidian-vault")
				local full_path = vault_path .. "/" .. img_path
				full_path = vim.fn.fnamemodify(full_path, ":p") -- normalize path

				if vim.fn.filereadable(full_path) == 0 then
					print("Error: Image file not found at: " .. full_path)
					return
				end

				-- Use osascript to copy image to pasteboard
				local cmd = string.format(
					"osascript -e 'set the clipboard to (read (POSIX file \"%s\") as «class PNGf»)'",
					full_path
				)

				local result = os.execute(cmd)
				if result == 0 then
					print("Image copied to clipboard!")
				else
					print("Error copying image to clipboard")
				end
			end,
			desc = "Copy image to clipboard",
		},
	},
}
