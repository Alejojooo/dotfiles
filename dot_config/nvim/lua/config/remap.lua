vim.g.mapleader = " "
vim.g.maplocalleader = " "

local keymap = vim.keymap.set

-- Delete single character without copying into register
keymap("n", "x", '"_x')

-- Increment/decrement numbers
keymap("n", "<leader>+", "<C-a>", { desc = "Increment number" })
keymap("n", "<leader>-", "<C-x>", { desc = "Decrement number" })

-- Scroll navigation
-- keymap("n", "<C-u>", "<C-u>zz", { desc = "Scroll up" })
-- keymap("n", "<C-d>", "<C-d>zz", { desc = "Scroll down" })

-- Window split
keymap("n", "<leader>wv", "<C-w>v", { desc = "Split window vertically" })
keymap("n", "<leader>wh", "<C-w>s", { desc = "Split window horizontally" })
keymap("n", "<leader>we", "<C-w>=", { desc = "Make panes equal size" })
keymap("n", "<leader>wx", "<cmd>close<CR>", { desc = "Close pane" })
keymap("n", "<leader>wm", "<C-w>|<C-w>_", { desc = "Max out current pane" })

-- Navigate between splits with CTRL + hjkl
keymap("n", "<C-h>", "<C-w>h", { desc = "Move to upper window" })
keymap("n", "<C-j>", "<C-w>j", { desc = "Move to lower window" })
keymap("n", "<C-k>", "<C-w>k", { desc = "Move to left window" })
keymap("n", "<C-l>", "<C-w>l", { desc = "Move to right window" })

-- Buffers
-- stylua: ignore start
keymap("n", "<leader>bd", function() Snacks.bufdelete() end, { desc = "Delete buffer" })
keymap("n", "<leader>bo", function() Snacks.bufdelete.other() end, { desc = "Delete other buffers" })
-- stylua: ignore end
keymap("n", "<S-h>", ":bnext<CR>", { desc = "Next buffer" })
keymap("n", "<S-l>", ":bprevious<CR>", { desc = "Previous buffer" })

-- Stay in indent mode
keymap("v", "<", "<gv")
keymap("v", ">", ">gv")

-- Move text up and down
keymap("n", "<A-j>", "<cmd>execute 'move .+' . v:count1<cr>==", { desc = "Move line up" })
keymap("n", "<A-k>", "<cmd>execute 'move .-' . (v:count1 + 1)<cr>==", { desc = "Move line down" })
keymap("i", "<A-j>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move line up" })
keymap("i", "<A-k>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move line up" })
keymap("v", "<A-j>", ":<C-u>execute \"'<,'>move '>+\" . v:count1<cr>gv=gv", { desc = "Move line up" })
keymap("v", "<A-k>", ":<C-u>execute \"'<,'>move '<-\" . (v:count1 + 1)<cr>gv=gv", { desc = "Move line up" })

-- Files
keymap("n", "<leader>fn", "<cmd>enew<CR>", { desc = "New File" })
keymap("n", "<leader>fs", "<cmd>write<CR>", { desc = "Save File" })
keymap({ "i", "x", "n", "s" }, "<C-s>", "<cmd>w<cr><esc>", { desc = "Save file" })
keymap("n", "<leader>fS", "<cmd>write<CR><cmd>quit<CR>", { desc = "Save File and Quit" })
keymap("n", "<leader>fu", "<cmd>edit!<CR>", { desc = "Undo All Changes in File" })

-- Clear search and stop snippet on escape
keymap({ "i", "n", "s" }, "<esc>", function()
  vim.cmd("noh")
  return "<esc>"
end, { expr = true, desc = "Escape and clear hlsearch" })

-- Diagnostic
-- stylua: ignore start
vim.keymap.set("n", "gl", vim.diagnostic.open_float, { desc = "Show line diagnostics" })
vim.keymap.set("n", "<leader>xx", function() Snacks.picker.diagnostics_buffer() end, { desc = "Buffer Diagnostics" })
vim.keymap.set("n", "<leader>xX", function() Snacks.picker.diagnostics() end, { desc = "Workspace Diagnostics" })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Next Diagnostic" })
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Prev Diagnostic" })
-- stylua: ignore end

-- Lazygit
-- stylua: ignore
keymap("n", "<leader>gg", function() Snacks.lazygit() end, { desc = "Lazygit" })

-- Zen mode
keymap("n", "<leader>z", "<cmd>ZenMode<CR>", { desc = "Zen Mode" })

-- Others
keymap({ "n", "v", "x" }, "<A-z>", function()
  if vim.opt.wrap then
    vim.opt.wrap = false
    return
  end
  vim.opt.wrap = true
end, { desc = "Toggle line wrap" })
