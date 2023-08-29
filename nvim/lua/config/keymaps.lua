-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local keymap = vim.keymap

keymap.set("i", "jk", "<esc>")
keymap.set({ "n" }, "<leader>fs", "<cmd>w<cr><esc>", { desc = "Save file" })
keymap.set({ "n" }, "<localleader>h", "^", { desc = "go to header of line" })
keymap.set({ "n" }, "<localleader>l", "$", { desc = "go to end of line" })
