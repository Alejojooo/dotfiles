local lsp_servers = {
  "astro",
  "cssls",
  "html",
  "jsonls",
  "lua_ls",
  "markdown_oxide",
  "tailwindcss",
  "ts_ls",
  "yamlls",
}

local parsers = {
  "astro",
  "bash",
  "c",
  "css",
  "diff",
  "html",
  "javascript",
  "jsdoc",
  "json",
  "lua",
  "luadoc",
  "luap",
  "markdown",
  "markdown_inline",
  "printf",
  "python",
  "query",
  "regex",
  "toml",
  "tsx",
  "typescript",
  "vim",
  "vimdoc",
  "xml",
  "yaml",
}

local linters = {
  "eslint_d",
  "jsonlint",
}

local linters_by_ft = {
  astro = { "eslint_d" },
  javascript = { "eslint_d" },
  json = { "jsonlint" },
  typescript = { "eslint_d" },
  typescriptreact = { "eslint_d" },
  yaml = { "eslint_d" },
}

local formatters = {
  "prettierd",
  "stylua",
}

local formatters_by_ft = {
  astro = { "prettierd" },
  css = { "prettierd" },
  html = { "prettierd" },
  javascript = { "prettierd" },
  json = { "prettierd" },
  lua = { "stylua" },
  typescript = { "prettierd" },
  typescriptreact = { "prettierd" },
  yaml = { "prettierd" },
}

return {
  lsp_servers = lsp_servers,
  parsers = parsers,
  linters = linters,
  linters_by_ft = linters_by_ft,
  formatters = formatters,
  formatters_by_ft = formatters_by_ft,
}
