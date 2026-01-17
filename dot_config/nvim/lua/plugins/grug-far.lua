return {
  "MagicDuck/grug-far.nvim",
  keys = {
    {
      "<leader>sr",
      function()
        require("grug-far").open({ transient = true })
      end,
      mode = { "n", "v" },
      desc = "Search and Replace",
    },
  },
}
