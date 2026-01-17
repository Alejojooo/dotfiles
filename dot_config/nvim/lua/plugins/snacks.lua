return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  opts = {
    indent = {
      animate = {
        enabled = false,
      },
    },
    input = { enabled = true },
    lazygit = {},
    notifier = { enabled = true },
    picker = {
      enabled = true,
      layout = {
        preset = "default",
      },
      -- Behavior
      matcher = {
        fuzzy = true, -- Use fuzzy matching
        smart_case = true, -- Smart case sensitivity
      },
      win = {
        input = {
          keys = {
            ["<C-d>"] = { "preview_scroll_down", mode = { "i", "n" } },
            ["<C-u>"] = { "preview_scroll_up", mode = { "i", "n" } },
          },
        },
      },
    },
  },
    -- stylua: ignore start
    keys = {
        -- Top Pickers & Explorer
        { "<leader><space>", function() Snacks.picker.smart() end, desc = "Smart find files" },
        { "<leader>,", function() Snacks.picker.buffers() end, desc = "Buffers" },
        { "<leader>/", function() Snacks.picker.grep() end, desc = "Grep" },
        { "<leader>:", function() Snacks.picker.command_history() end, desc = "Command history" },
        { "<leader>n", function() Snacks.picker.notifications() end, desc = "Notification history" },

        -- Files
        { "<leader>ff", function() Snacks.picker.files() end, desc = "Find files" },
        { "<leader>fg", function() Snacks.picker.git_files() end, desc = "Find git files" },
        { "<leader>fr", function() Snacks.picker.recent() end, desc = "Recent" },

        -- Git
        { "<leader>gl", function() Snacks.picker.git_log() end, desc = "Git log" },
        { "<leader>gs", function() Snacks.picker.git_status() end, desc = "Git status" },

        -- Grep
        { "<leader>sb", function() Snacks.picker.lines() end, desc = "Buffer lines" },
        { "<leader>sB", function() Snacks.picker.grep_buffers() end, desc = "Grep open buffers" },
        { "<leader>sw", function() Snacks.picker.grep_word() end, desc = "Visual selection or word" },

        -- Search
        { '<leader>s"', function() Snacks.picker.registers() end, desc = "Registers" },
        { "<leader>sa", function() Snacks.picker.autocmds() end, desc = "Autocmds" },
        { "<leader>sc", function() Snacks.picker.command_history() end, desc = "Command history" },
        { "<leader>sC", function() Snacks.picker.commands() end, desc = "Commands" },
        { "<leader>sd", function() Snacks.picker.diagnostics() end, desc = "Diagnostics" },
        { "<leader>sh", function() Snacks.picker.help() end, desc = "Help pages" },
        { "<leader>sk", function() Snacks.picker.keymaps() end, desc = "Keymaps" },
    },
  -- stylua: ignore end
}
