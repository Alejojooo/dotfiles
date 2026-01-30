return {
  {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    event = { "BufRead" },
    branch = "main",
    build = ":TSUpdate",
    opts = {
      ensure_installed = require("config.packages").parsers,
    },
    config = function(_, opts)
      -- Manual installation
      local ts = require("nvim-treesitter")
      local ensure_installed = require("config.packages").parsers
      local already_installed = ts.get_installed()
      local to_install = vim.iter(ensure_installed)
        :filter(function(parser)
          return not vim.tbl_contains(already_installed, parser)
        end)
        :totable()

      if #to_install > 0 then
        vim.notify("Installing Treesitter parsers...", vim.log.levels.INFO)
        ts.install(to_install)
      end

      -- Enable features
      vim.api.nvim_create_autocmd("FileType", {
        group = vim.api.nvim_create_augroup("NativeTreesitter", { clear = true }),
        pattern = "*",
        callback = function()
          local ok = pcall(vim.treesitter.start)

          -- If Treesitter started successfully, enable the other features:
          if ok then
            -- Indentation
            vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"

            -- Folding
            vim.opt_local.foldmethod = "expr"
            vim.opt_local.foldexpr = "v:lua.vim.treesitter.foldexpr()"
            vim.opt_local.foldlevel = 99
            vim.opt_local.foldlevelstart = 99
          end
        end,
      })
    end,
  },
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    dependencies = { "williamboman/mason.nvim" },
    opts = {
      ensure_installed = vim.list_extend(
        require("config.packages").formatters,
        require("config.packages").linters
      ),
      auto_update = true,
      run_on_start = true,
    },
  },
}
