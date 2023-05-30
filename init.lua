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
    lsp = {
        -- customize lsp formatting options
        formatting = {
            -- control auto formatting on save
            format_on_save = {
                enabled = true, -- enable or disable format on save globally
                allow_filetypes = { -- enable format on save for specified filetypes only
                    -- "go",
                },
                ignore_filetypes = { -- disable format on save for specified filetypes
                    -- "python",
                }
            },
            disabled = { -- disable formatting capabilities for the listed language servers
                -- disable lua_ls formatting capability if you want to use StyLua to format your lua code
                -- "lua_ls",
            },
            timeout_ms = 1000 -- default format timeout
            -- filter = function(client) -- fully override the default formatting function
            --   return true
            -- end
        },
        -- enable servers that you already have installed without mason
        servers = {
            -- "pyright"
        },
        config = {
            clangd = {capabilities = {offsetEncoding = "utf-8"}},
            texlab = {
                auxDirectory = "build",
                bibtexFormatter = "texlab",
                build = {
                    executable = "tectonic",
                    args = {
                        "-X", "compile", "%f", "--outdir", "build", "--synctex",
                        "--keep-logs", "--keep-intermediates"
                    },
                    forwardSearchAfter = true,
                    onSave = true
                },
                chktex = {onEdit = true, onOpenAndSave = true},
                diagnosticsDelay = 300,
                formatterLineLength = 100,
                forwardSearch = {executable = "okular", args = {"%p"}},
                latexFormatter = "latexindent",
                latexindent = {modifyLineBreaks = true}
            }
        },
        setup_handlers = {
            clangd = function(_, opts)
                require("clangd_extensions").setup {server = opts}
            end,
            rust_analyzer = function(_, opts)
                opts.on_attach = function(_, bufnr)
                    -- Hover actions
                    vim.keymap.set("n", "<C-space>",
                                   require'rust-tools'.hover_actions
                                       .hover_actions, {buffer = bufnr})
                    -- Code action groups
                    vim.keymap.set("n", "<Leader>a",
                                   require'rust-tools'.code_action_group
                                       .code_action_group, {buffer = bufnr})
                end
                require("rust-tools").setup {server = opts}
            end
        }
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

        local notify = vim.notify
        vim.notify = function(msg, ...)
            if msg:match("warning: multiple different client offset_encodings") then
                return
            end

            notify(msg, ...)
        end
    end
}
