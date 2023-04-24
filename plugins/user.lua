return {
  -- You can also add new plugins here as well:
  -- Add plugins, the lazy syntax
  -- "andweeb/presence.nvim",
  -- {
  --   "ray-x/lsp_signature.nvim",
  --   event = "BufRead",
  --   config = function()
  --     require("lsp_signature").setup()
  --   end,
  -- },
  { "nvim-tree/nvim-web-devicons" },
  {
    "folke/trouble.nvim",
    requires = "nvim-tree/nvim-web-devicons",
    config = function()
      require("trouble").setup {
        icons = true,
        auto_open = true,
        auto_close = true,
        use_diagnostic_signs = true
      }
    end
  },
  {
    'saecki/crates.nvim',
    tag = 'v0.3.0',
    requires = { 'nvim-lua/plenary.nvim' },
    config = function()
      require('crates').setup()
    end,
  }

}
