return {
  {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    branch = "main",
    build = ":TSUpdate",
    config = function()
      local ts = require("nvim-treesitter")
      local parsers = require("config.packages").parsers

      ts.setup({ install_dir = vim.fn.stdpath("data") .. "/site" })
      ts.install(parsers)

      vim.api.nvim_create_autocmd("FileType", {
        group = vim.api.nvim_create_augroup("nvim-treesitter", { clear = true }),
        pattern = "*",
        callback = function(args)
          local ok = pcall(vim.treesitter.start)

          if ok then
            local winid = vim.api.nvim_get_current_win()
            vim.wo[winid].foldmethod = "expr"
            vim.wo[winid].foldexpr = "v:lua.vim.treesitter.foldexpr()"
            vim.wo[winid].foldlevel = 99

            vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
          end
        end
      })
    end
  },
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    dependencies = { "williamboman/mason.nvim" },
    opts = {
      ensure_installed = vim.list_extend(require("config.packages").formatters, require("config.packages").linters),
      auto_update = true,
      run_on_start = true,
    },
  },
}
