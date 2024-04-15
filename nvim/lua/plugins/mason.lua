return {
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "lua-language-server",
        "stylua",
        "shfmt",
        "python-lsp-server",
        "pyright",
        "rust-analyzer",
      },
    },
  },
}
