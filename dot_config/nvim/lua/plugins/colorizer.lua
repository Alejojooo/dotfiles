return {
  "catgoose/nvim-colorizer.lua",
  event = "BufReadPre",
  opts = {
    filetypes = {
      "html",
      "css",
      "javascript",
      "typescript",
      "typescriptreact",
    },
    user_default_options = {
      names = true,
      css = true,
      tailwind = true,
      mode = "background",
    },
  },
}
