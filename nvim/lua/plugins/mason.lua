return {
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "lua-language-server",
        "stylua",
        "python-lsp-server",
        "rust_analyzer",
      },
    },
  },
}
