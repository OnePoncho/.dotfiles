  
return {
  {
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      "nvim-telescope/telescope-live-grep-args.nvim",
      {
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'make',
      },
    },

    keys = {
      { "<leader>ff", "<cmd>Telescope find_files<cr>",                            desc = "[F]ind [F]iles" },
      { "<leader>fh", "<cmd>Telescope find_files hidden=true no_ignore=true<cr>", desc = "[F]ind [H]idden" },
      { "<leader>fg", "<cmd>Telescope live_grep_args<cr>",                        desc = "[F]ind by [G]rep" },
      { "<leader>df", "<cmd>Telescope diagnostics<cr>",                           desc = "[D]iagnostics find by [F]ile" },
      {
        "<C-r>",
        mode = "i",
        function()
          require('telescope.builtin').resume()
        end,
        desc = "Resume previous search"
      },
    },
    config = function(_, opts)
      local telescope = require('telescope')
      vim.cmd [[ autocmd User TelescopePreviewerLoaded setlocal wrap ]]
      telescope.setup(opts)
      telescope.load_extension('fzf')
      telescope.load_extension("live_grep_args")
    end


  }

}

