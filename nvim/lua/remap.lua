-- generate uuid
vim.keymap.set("n", "<leader>u", "i\"<C-r>=system('uuidgen')[:-2]<CR>\",<Esc>")
