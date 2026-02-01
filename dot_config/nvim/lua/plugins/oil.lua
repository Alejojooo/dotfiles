return {
  "stevearc/oil.nvim",
  lazy = false,
  dependencies = { { "nvim-mini/mini.icons", opts = {} } },
  opts = {
    default_file_explorer = true,
    columns = {
      "icon",
      -- "permissions",
      -- "size",
      -- "mtime",
    },
    view_options = {
      show_hidden = true, -- Show hidden files (.git, .env, etc.)
      is_always_hidden = function(name, bufnr)
        return name == ".." or name == ".git"
      end,
    },
    keymaps = {
      ["g?"] = "actions.show_help",
      ["<CR>"] = "actions.select",
      ["<C-s>"] = "actions.select_vsplit",
      ["<C-h>"] = false,
      ["<C-t>"] = "actions.select_tab",
      ["<C-p>"] = "actions.preview",
      ["<C-c>"] = "actions.close",
      ["<C-l>"] = false,
      ["-"] = "actions.parent",
      ["_"] = "actions.open_cwd",
      ["`"] = "actions.cd",
      ["~"] = "actions.tcd",
      ["gs"] = "actions.change_sort",
      ["gx"] = "actions.open_external",
      ["g."] = "actions.toggle_hidden",
    },
    use_default_keymaps = false,
  },
  keys = {
    { "-", "<cmd>Oil<cr>", desc = "Open Parent Directory" },
  },
}
