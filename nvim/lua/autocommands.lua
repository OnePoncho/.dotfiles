vim.api.nvim_create_augroup("neotree_start", { clear = true })
vim.api.nvim_create_autocmd("BufEnter", {
  desc = "Open Neo-Tree on startup with directory",
  group = "neotree_start",
  callback = function()
    local stats = vim.loop.fs_stat(vim.api.nvim_buf_get_name(0))
    if stats and stats.type == "directory" then require("neo-tree.setup.netrw").hijack() end
  end,
})
