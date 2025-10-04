vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.hlsearch = false
vim.opt.clipboard = "unnamedplus"
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.wrap = false
vim.opt.termguicolors = true
vim.opt.completeopt = "menuone,noinsert"
vim.opt.undofile = true
vim.opt.swapfile = false
vim.opt.backup = false
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
vim.keymap.set("n", '<leader>pd', 'yiwoprintln!("{:#?}", <Esc>pa);<Esc>:w<CR>')
-- generate println for variable under cursor
vim.keymap.set("n", '<leader>pl', 'yiwoprintln!("{:?}", <Esc>pa);<Esc>:w<CR>')
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
-- telescope keymaps
vim.keymap.set("n", "<leader>ff", "<CMD>Telescope find_files<CR>", { desc = "[F]ind [F]iles" })
vim.keymap.set("n", "<leader>fh", "<CMD>Telescope find_files hidden=true no_ignore=true<CR>",
  { desc = "[F]ind [H]idden" })
vim.keymap.set("n", "<leader>fg", "<CMD>Telescope live_grep_args<CR>", { desc = "[F]ind by [G]rep" })
vim.keymap.set("n", "<leader>df", "<CMD>Telescope diagnostics<CR>", { desc = "[D]iagnostics find by [F]ile" })
-- neotree keymaps
vim.keymap.set("n", "\\", "<CMD>Neotree reveal left<CR>")
-- lsp actions
vim.keymap.set('n', 'ga', vim.lsp.buf.code_action, { desc = '[G]oto [A]ction' })
vim.keymap.set('n', '<leader>rw', vim.lsp.buf.rename, { desc = '[R]ename [W]ord' })
vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { desc = '[G]oto [D]efinition' })

vim.pack.add({
  { src = "https://github.com/navarasu/onedark.nvim" },
  { src = "https://github.com/neovim/nvim-lspconfig" },
  { src = "https://github.com/mason-org/mason.nvim" },
  { src = "https://github.com/max397574/better-escape.nvim" },
  { src = "https://github.com/nvim-treesitter/nvim-treesitter" },
  { src = "https://github.com/windwp/nvim-autopairs" },
  { src = "https://github.com/preservim/nerdcommenter" },
  { src = "https://github.com/nvim-lua/plenary.nvim" },
  { src = "https://github.com/nvim-telescope/telescope.nvim" },
  { src = "https://github.com/nvim-telescope/telescope-live-grep-args.nvim" },
  { src = "https://github.com/nvim-telescope/telescope-fzf-native.nvim" },
  { src = "https://github.com/nvim-neo-tree/neo-tree.nvim" },
  { src = "https://github.com/nvim-tree/nvim-web-devicons" },
  { src = "https://github.com/MunifTanjim/nui.nvim" },
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
vim.api.nvim_create_autocmd("BufWritePre", {
  callback = function()
    vim.lsp.buf.format()
  end
})
require "mason".setup()
require "nvim-autopairs".setup()
require "neo-tree".setup({
  event_handlers = {
    {
      event = "file_opened",
      handler = function(_)
        require("neo-tree.command").execute({ action = "close" })
      end
    },
    {
      event = "vim_buffer_enter",
      handler = function()
        if vim.bo.filetype == "neo-tree" then
          vim.opt.relativenumber = true
          vim.opt.number = true
        end
      end,
    },
  },
})
require "nvim-treesitter.configs".setup({
  ensure_installed = { "rust", "go", "python", "typescript", "javascript", "kotlin", "bash"},
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
local function pack_clean()
  local active_plugins = {}
  local unused_plugins = {}

  for _, plugin in ipairs(vim.pack.get()) do
    active_plugins[plugin.spec.name] = plugin.active
  end

  for _, plugin in ipairs(vim.pack.get()) do
    if not active_plugins[plugin.spec.name] then
      table.insert(unused_plugins, plugin.spec.name)
    end
  end

  if #unused_plugins == 0 then
    print("No unused plugins.")
    return
  end

  local choice = vim.fn.confirm("Remove unused plugins?", "&Yes\n&No", 2)
  if choice == 1 then
    vim.pack.del(unused_plugins)
  end
end

--vim.keymap.set("n", "<leader>pc", pack_clean)
