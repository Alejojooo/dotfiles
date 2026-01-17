vim.diagnostic.config({
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = " ",
      [vim.diagnostic.severity.WARN] = " ",
      [vim.diagnostic.severity.HINT] = " ",
      [vim.diagnostic.severity.INFO] = " ",
    },
  },
  -- I don't prefer seeing errors inline.
  -- virtual_text = {
  --   prefix = "● ",
  --   source = "if_many",
  -- },
  update_in_insert = false,
  severity_sort = true,
  float = {
    border = "rounded",
    source = "always", -- Show where the error came from
  },
})
