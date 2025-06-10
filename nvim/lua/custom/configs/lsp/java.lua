-- Updated Java LSP configuration for Java 21+
local M = {}

function M.setup()
  local utils = require "custom.configs.lsp.utils"
  local lspconfig = require "lspconfig"
  local capabilities = utils.capabilities

  -- Java LSP (jdtls) setup with Java 21+ requirement
  lspconfig.jdtls.setup {
    capabilities = capabilities,
    root_dir = lspconfig.util.root_pattern(
    -- Single-module projects
      { "pom.xml", "build.gradle", ".git" },
      -- Multi-module projects
      { "pom.xml", "build.gradle" }
    ),
    settings = {
      java = {
        eclipse = {
          downloadSources = true,
        },
        configuration = {
          updateBuildConfiguration = "interactive",
          runtimes = {
            {
              name = "JavaSE-21",                           -- Updated to Java 21
              path = "/usr/lib/jvm/java-21-openjdk-amd64/", -- Adjust path for Java 21
              default = true,
            },
          },
        },
        maven = {
          downloadSources = true,
        },
        implementationsCodeLens = {
          enabled = true,
        },
        referencesCodeLens = {
          enabled = true,
        },
        references = {
          includeDecompiledSources = true,
        },
        format = {
          enabled = true,
          settings = {
            url = vim.fn.stdpath "config" .. "/lang-servers/intellij-java-google-style.xml",
            profile = "GoogleStyle",
          },
        },
      },
      signatureHelp = { enabled = true },
      completion = {
        favoriteStaticMembers = {
          "org.hamcrest.MatcherAssert.assertThat",
          "org.hamcrest.Matchers.*",
          "org.hamcrest.CoreMatchers.*",
          "org.junit.jupiter.api.Assertions.*",
          "java.util.Objects.requireNonNull",
          "java.util.Objects.requireNonNullElse",
          "org.mockito.Mockito.*",
        },
      },
      contentProvider = { preferred = "fernflower" },
      extendedClientCapabilities = {
        progressReportProvider = {
          ["textDocument/didChange"] = true,
        },
      },
      sources = {
        organizeImports = {
          starThreshold = 9999,
          staticStarThreshold = 9999,
        },
      },
      codeGeneration = {
        toString = {
          template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}",
        },
        useBlocks = true,
      },
    },
    on_attach = function(client, bufnr)
      -- Call the common on_attach if available
      if utils.on_attach then
        utils.on_attach(client, bufnr)
      end

      -- Java-specific keymappings
      local map = function(mode, lhs, rhs, desc)
        vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
      end

      -- Basic Java keymappings
      map("n", "<leader>jt", "<cmd>lua vim.lsp.buf.type_definition()<CR>", "Java Type Definition")
      map("n", "<leader>jr", "<cmd>lua vim.lsp.buf.rename()<CR>", "Java Rename")
      map("n", "<leader>jf", "<cmd>lua vim.lsp.buf.format({ async = true })<CR>", "Format Java Code")
      map("n", "<leader>ja", "<cmd>lua vim.lsp.buf.code_action()<CR>", "Java Code Actions")
      map("n", "<leader>jo", "<cmd>lua require('jdtls').organize_imports()<CR>", "Organize Imports")
      map("n", "<leader>jv", "<cmd>lua require('jdtls').extract_variable()<CR>", "Extract Variable")
      map("v", "<leader>jv", "<cmd>lua require('jdtls').extract_variable(true)<CR>", "Extract Variable (Visual)")
      map("n", "<leader>jm", "<cmd>lua require('jdtls').extract_method()<CR>", "Extract Method")
      map("v", "<leader>jm", "<cmd>lua require('jdtls').extract_method(true)<CR>", "Extract Method (Visual)")
      map("n", "<leader>jc", "<cmd>lua require('jdtls').extract_constant()<CR>", "Extract Constant")
      map("v", "<leader>jc", "<cmd>lua require('jdtls').extract_constant(true)<CR>", "Extract Constant (Visual)")

      -- Test related keymappings
      map("n", "<leader>jtc", "<cmd>lua require('jdtls').test_class()<CR>", "Test Class")
      map("n", "<leader>jtm", "<cmd>lua require('jdtls').test_nearest_method()<CR>", "Test Nearest Method")

      -- Java-specific commands
      vim.cmd [[command! -buffer -nargs=? JdtCompile lua require('jdtls').compile(<f-args>)]]
      vim.cmd [[command! -buffer -nargs=0 JdtUpdateConfig lua require('jdtls').update_projects_config()]]
      vim.cmd [[command! -buffer -nargs=0 JdtJol lua require('jdtls').jol()]]
      vim.cmd [[command! -buffer -nargs=0 JdtBytecode lua require('jdtls').javap()]]
      vim.cmd [[command! -buffer -nargs=+ JdtJshell lua require('jdtls').jshell(<f-args>)]]
    end,
  }
end

return M
