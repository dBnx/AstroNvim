return {
    -- Configure AstroNvim updates
    updater = {
        remote = "origin", -- remote to use
        channel = "stable", -- "stable" or "nightly"
        version = "latest", -- "latest", tag name, or regex search like "v1.*" to only do updates before v2 (STABLE ONLY)
        branch = "nightly", -- branch name (NIGHTLY ONLY)
        commit = nil, -- commit hash (NIGHTLY ONLY)
        pin_plugins = nil, -- nil, true, false (nil will pin plugins on stable only)
        skip_prompts = false, -- skip prompts about breaking changes
        show_changelog = true, -- show the changelog after performing an update
        auto_quit = false, -- automatically quit the current session after a successful update
        remotes = { -- easily add new remotes to track
            --   ["remote_name"] = "https://remote_url.come/repo.git", -- full remote url
            --   ["remote2"] = "github_user/repo", -- GitHub user/repo shortcut,
            --   ["remote3"] = "github_user", -- GitHub user assume AstroNvim fork
        }
    },
    -- Set colorscheme to use
    colorscheme = "astrodark",
    -- Diagnostics configuration (for vim.diagnostics.config({...})) when diagnostics are on
    diagnostics = {
        virtual_text = true,
        underline = true,
        severity_sort = true,
        update_in_insert = true
    },
    -- Configure require("lazy").setup() options
    lazy = {
        defaults = {lazy = true},
        performance = {
            rtp = {
                -- customize default disabled vim plugins
                disabled_plugins = {
                    "tohtml", "gzip", "matchit", "zipPlugin", "netrwPlugin",
                    "tarPlugin"
                }
            }
        }
    },
    -- This function is run last and is a good place to configuring
    -- augroups/autocommands and custom filetypes also this just pure lua so
    -- anything that doesn't fit in the normal config locations above can go here
    polish = function()
        vim.g['tex_flavor'] = 'latex'
        vim.keymap.set("v", "J", ":m .+1<cr>gv=gv", {silent = true})
        vim.keymap.set("v", "K", ":m .-2<cr>gv=gv", {silent = true})

        vim.api.nvim_create_autocmd("BufRead", {
            group = vim.api
                .nvim_create_augroup("CmpSourceCargo", {clear = true}),
            pattern = "Cargo.toml",
            callback = function()
                require('cmp').setup.buffer({sources = {{name = "crates"}}})
            end
        })

        vim.filetype.add {
            extension = {wgsl = "wgsl"}
            -- filename = {
            --   ["Foofile"] = "fooscript",
            -- },
            -- pattern = {
            --   ["~/%.config/foo/.*"] = "fooscript",
            -- },
        }

        vim.cmd([[
        set signcolumn=yes
        autocmd CursorHold * lua vim.diagnostic.open_float(nil, { focusable = false })
        autocmd FileType make set noexpandtab shiftwidth=8 softtabstop=0
        ]])

        require('neorg').setup {
            load = {
                ["core.defaults"] = {},
                ["core.concealer"] = {},
                ["core.completion"] = {},
                ["core.dirman"] = {
                    config = {
                        workspaces = {
                            home = "~/Sync/Notes/home",
                            work = "~/Sync/Notes/work",
                            uni = "~/Sync/Notes/uni",
                            projects = "~/Sync/Notes/projects",
                            fragments = "~/Sync/Notes/fragments"
                        }
                    }
                }
            }
        }

        -- Filter out offset encoding warnings, they spam the whole screen
        local notify = vim.notify
        vim.notify = function(msg, ...)
            if msg:match("warning: multiple different client offset_encodings") then
                return
            end

            notify(msg, ...)
        end
    end
}
