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
    {"nvim-tree/nvim-web-devicons"}, --
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
    }, --
    {
        'saecki/crates.nvim',
        event = {"BufRead Cargo.toml"},
        tag = 'v0.3.0',
        requires = {'nvim-lua/plenary.nvim'},
        config = function() require('crates').setup() end
    }, --
    {
        "L3MON4D3/LuaSnip",
        config = function(plugin, opts)
            vim.cmd("hi link LuasnipInsertNodePassive GruvboxRed")
            vim.cmd("hi link LuasnipSnippetPassive GruvboxBlue")
            -- include the default astronvim config that calls the setup call
            opts.enable_autosnippets = true
            opts.delete_check = 'InsertLeave'
            require "plugins.configs.luasnip"(plugin, opts)
            require("luasnip.loaders.from_vscode").lazy_load {
                paths = {"./lua/user/snippets"}
            }
            require("luasnip.loaders.from_lua").lazy_load({
                paths = "./lua/user/snippets"
            })
            require("luasnip.loaders.from_snipmate").lazy_load({
                paths = "./lua/user/snippets"
            })
        end
    }, --
    {
        "nvim-neorg/neorg",
        build = ":Neorg sync-parsers",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function()
          require("neorg").setup {
            load = {
              ["core.defaults"] = {},
              ["core.concealer"] = {},
              ["core.dirman"] = {
                config = {
                  workspaces = {
                            home = "~/Sync/Notes/home",
                            work = "~/Sync/Notes/work",
                            uni = "~/Sync/Notes/uni",
                            projects = "~/Sync/Notes/projects",
                            fragments = "~/Sync/Notes/fragments"
                  },
                  default_workspace = "home",
                },
              },
            },
          }

          vim.wo.foldlevel = 99
          vim.wo.conceallevel = 2
        end,
      }, --
    {
        "SeniorMars/typst.nvim" --
    }
}
