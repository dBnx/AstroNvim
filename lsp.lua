return {
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
        timeout_ms = 900 -- default format timeout
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
        rust_analyzer = function(_, opts)
            opts.on_attach = function(_, bufnr)
                -- Hover actions
                vim.keymap.set("n", "<C-space>",
                               require'rust-tools'.hover_actions.hover_actions,
                               {buffer = bufnr})
                -- Code action groups
                vim.keymap.set("n", "<Leader>a",
                               require'rust-tools'.code_action_group
                                   .code_action_group, {buffer = bufnr})
            end
            require("rust-tools").setup {server = opts}
        end,
        clangd = function(_, opts)
            require("clangd_extensions").setup {server = opts}
        end
    }
}
