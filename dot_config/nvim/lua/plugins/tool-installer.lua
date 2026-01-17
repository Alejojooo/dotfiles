return {
  "WhoIsSethDaniel/mason-tool-installer.nvim",
  dependencies = { "williamboman/mason.nvim" },
  opts = {
    ensure_installed = vim.list_extend(require("config.packages").formatters, require("config.packages").linters),
    auto_update = true,
    run_on_start = true,
  },
}
