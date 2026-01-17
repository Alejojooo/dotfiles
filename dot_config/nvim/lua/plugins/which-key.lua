return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  init = function()
    vim.o.timeout = true
    vim.o.timeoutlen = 300 -- Wait 300ms before showing the popup
  end,
  opts = {
    preset = "helix",
    spec = {
      mode = { "n", "v" },
      { "<leader>f", group = "File" },
      { "<leader>b", group = "Buffer" },
      { "<leader>g", group = "Git" },
      { "<leader>s", group = "Search" },
      { "<leader>w", group = "Window" },
      { "<leader>c", group = "Code" },

      -- Examples of grouping generic prefixes if you have them:
      { "[", group = "Prev" },
      { "]", group = "Next" },
      { "g", group = "Goto" },
    },

    -- Visual customization
    win = {
      border = "rounded", -- none, single, double, shadow
    },
    icons = {
      breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
      separator = "", -- symbol used between a key and it's label
      group = "+", -- symbol prepended to a group
    },
  },
}
