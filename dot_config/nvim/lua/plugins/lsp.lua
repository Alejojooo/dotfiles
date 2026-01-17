return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "saghen/blink.cmp",
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
    },
    config = function()
      local lspconfig = require("lspconfig")
      local mason = require("mason")
      local mason_lspconfig = require("mason-lspconfig")
      local capabilities = require("blink.cmp").get_lsp_capabilities()

      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("LspConfig", {}),
        callback = function(ev)
          -- Helper functions to make mapping easier
          local opts = function(desc)
            return { buffer = ev.buf, desc = desc }
          end
          local keymap = vim.keymap.set

          -- Snacks integration
          keymap("n", "gd", function()
            Snacks.picker.lsp_definitions()
          end, opts("Go to definition"))

          keymap("n", "gi", function()
            Snacks.picker.lsp_implementations()
          end, opts("Go to implementation"))

          keymap("n", "gr", function()
            Snacks.picker.lsp_references()
          end, opts("Go to references"))

          keymap("n", "gy", function()
            Snacks.picker.lsp_type_definitions()
          end, opts("Go to type definitions"))

          keymap("n", "<leader>ss", function()
            Snacks.picker.lsp_type_definitions()
          end, opts("Search buffer symbols"))

          keymap("n", "<leader>sS", function()
            Snacks.picker.lsp_type_definitions()
          end, opts("Search workspace symbols"))

          -- Standard mappings
          keymap("n", "K", vim.lsp.buf.hover, opts("Hover info"))
          keymap("n", "<leader>r", vim.lsp.buf.rename, opts("Rename"))
          keymap("n", "<leader>ca", vim.lsp.buf.code_action, opts("Code actions"))
        end,
      })

      mason.setup()
      mason_lspconfig.setup({
        ensure_installed = require("config.packages").lsp_servers,
        automatic_installation = true,
        handlers = {
          function(server_name)
            lspconfig[server_name].setup({
              capabilities = capabilities,
            })
          end,
        },
      })
    end,
  },
  {
    "saghen/blink.cmp",
    version = "*",
    opts = {
      keymap = {
        preset = "none",
        ["<Tab>"] = { "select_next", "snippet_forward", "fallback" },
        ["<S-Tab>"] = { "select_prev", "snippet_backward", "fallback" },
        ["<CR>"] = { "accept", "fallback" },
        ["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
        ["<C-b>"] = { "scroll_documentation_up", "fallback" },
        ["<C-f>"] = { "scroll_documentation_down", "fallback" },
      },
      appearance = {
        use_nvim_cmp_as_default = true,
        -- nerd_font_variant = "mono",
      },
      completion = {
        menu = { auto_show = true },
        documentation = { auto_show = true, auto_show_delay_ms = 500 },
      },
      sources = {
        default = { "lsp", "path", "snippets", "buffer" },
      },
    },
  },
}
