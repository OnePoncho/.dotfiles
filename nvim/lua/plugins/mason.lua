return {
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "stylua",
        "pylsp",
        "rust_analyzer",
      },
    },
  },
}
