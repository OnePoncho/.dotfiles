vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.hlsearch = false
vim.opt.clipboard = "unnamedplus"
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.wrap = false
vim.opt.termguicolors = true
vim.opt.completeopt = "menuone,noselect"
vim.undofile = true
vim.opt.swapfile = false
vim.opt.backup = fasle
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.bo.softtabstop = 2
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.winborder = "rounded"

vim.g.mapleader = " "
-- generate uuid
vim.keymap.set("n", "<leader>u", "i\"<C-r>=system('uuidgen')[:-2]<CR>\",<Esc>")
-- generate println debug for variable under cursor
vim.keymap.set("n", '<leader>pd', 'yiwoprintln!("{:#?}", <Esc>pa);<Esc>:w<Enter>')
-- generate println for variable under cursor
vim.keymap.set("n", '<leader>pl', 'yiwoprintln!("{:?}", <Esc>pa);<Esc>:w<Enter>')
-- diagnostic
vim.keymap.set('n', '<leader>dp', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
vim.keymap.set('n', '<leader>dn', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
vim.keymap.set('n', '<leader>do', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
-- cursor stays in the centre of the screen during these commands
vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set('n', '<C-d>', '<C-d>zz', { noremap = true })
vim.keymap.set('n', '<C-u>', '<C-u>zz', { noremap = true })
vim.keymap.set('n', 'n', 'nzz', { noremap = true })
vim.keymap.set('n', '<C-i>', '<C-i>zz', { noremap = true })
vim.keymap.set('n', '<C-o>', '<C-o>zz', { noremap = true })
--  copy entire file contents
vim.keymap.set("n", "<leader>cc", "ggyG")
-- format buffer with lsp
vim.keymap.set("n", "<leader>lf", vim.lsp.buf.format)
-- Pick files mini.pick
vim.keymap.set("n", "<leader>ff", ":Pick files<CR>")

vim.pack.add({
  { src = "https://github.com/navarasu/onedark.nvim" },
  { src = "https://github.com/neovim/nvim-lspconfig" },
  { src = "https://github.com/mason-org/mason.nvim" },
  { src = "https://github.com/max397574/better-escape.nvim" },
  { src = "https://github.com/nvim-treesitter/nvim-treesitter" },
  { src = "https://github.com/windwp/nvim-autopairs" },
  { src = "https://github.com/preservim/nerdcommenter" },
  { src = "https://github.com/echasnovski/mini.pick" },
})

vim.cmd("colorscheme onedark")

vim.lsp.enable({ "lua_ls", "rust_analyzer", "gopls" })
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(ev)
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    if client:supports_method("textDocument/completion") then
      vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
    end
  end,
})

require "mason".setup()
require "nvim-autopairs".setup()
require "mini.pick".setup()
require "nvim-treesitter.configs".setup({
  ensure_installed = { "rust", "go", "python", "typescript", "javascript", "kotlin" },
  highlight = { enable = true }
})
require "better_escape".setup {
  default_mappings = false,
  mappings = {
    i = {
      j = {
        k = "<Esc>" },
      k = { j = "<Esc>" },
    },
    c = {
      j = { k = "<Esc>" },
      k = { j = "<Esc>" },
    },
    t = {
      j = { k = "<Esc>" },
      k = { j = "<Esc>" },
    },
  },
}
