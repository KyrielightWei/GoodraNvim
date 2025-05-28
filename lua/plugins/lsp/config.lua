local M = {}
local no_plugin = require("lazy_config").no_plugin_installed()

function M.cmp_opt()
    if no_plugin then
        return nil
    else
        local cmp = require("cmp")
        return {
            snippet = {
                -- REQUIRED - you must specify a snippet engine
                expand = function(args)
                    --   vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
                    require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
                    -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
                    -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
                end,
            },
            window = {
                completion = {
                    winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,Search:None",
                    col_offset = -3,
                    side_padding = 0,
                },
            },
            formatting = {
                fields = { "kind", "abbr", "menu" },
                format = function(entry, vim_item)
                    local kind = require("lspkind").cmp_format({ mode = "symbol_text", maxwidth = 50 })(entry, vim_item)
                    local strings = vim.split(kind.kind, "%s", { trimempty = true })
                    kind.kind = " " .. (strings[1] or "") .. " "
                    kind.menu = "    (" .. (strings[2] or "") .. ")"

                    return kind
                end,
            },
            mapping = {
                ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
                ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
                ['<C-o>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
                -- ['<C-y>'] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
                ['<Tab>'] = function(fallback)
                    if cmp.visible() then
                        cmp.select_next_item()
                    else
                        fallback()
                    end
                end,
                ['<C-e>'] = cmp.mapping({
                    i = cmp.mapping.abort(),
                    c = cmp.mapping.close(),
                }),
                -- ['<Tab>'] = cmp.mapping(cmp.mapping.select_next_item, {'i','c'}
                ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
            },
            sources = cmp.config.sources({
                { name = 'nvim_lsp' },
                { name = 'buffer' },
                { name = 'path' },
                { name = 'nvim_lua' },
                -- { name = 'nvim_lsp_document_symbol' },
                -- { name = 'treesitter' },
                { name = 'nvim_lsp_signature_help' },
            }),
        }
    end
end

function M.cmp_config(LazyPlugin, opts)
    if no_plugin then
    else
        local cmp = require("cmp")
        cmp.setup(opts)
        cmp.setup.cmdline('/', {
            mapping =
            {
                ['<Tab>'] = function(fallback)
                    if cmp.visible() then
                        cmp.select_next_item()
                    else
                        fallback()
                    end
                end,
            },
            sources = {
                { name = 'buffer' },
                { name = 'treesitter' },
                { name = 'nvim_lsp_document_symbol' },
            }
        })
        cmp.setup.cmdline(':', {
            mapping =
            {
                ['<Tab>'] = function(fallback)
                    if cmp.visible() then
                        cmp.select_next_item()
                    else
                        fallback()
                    end
                end,
            },
            -- cmp.mapping.preset.cmdline(),
            sources = cmp.config.sources({
                { name = 'path' }
            }, {
                { name = 'cmdline' }
            })
        })
    end
end

-- function M.lspconfig_opt()
--     if no_plugin then
--         return nil
--     else
--         return {
--             -- options for vim.diagnostic.config()
--             diagnostics = {
--                 underline = true,
--                 update_in_insert = false,
--                 virtual_text = { spacing = 4, prefix = "●" },
--                 severity_sort = true,
--             },
--             -- Automatically format on save
--             autoformat = false,
--             -- options for vim.lsp.buf.format
--             -- `bufnr` and `filter` is handled by the LazyVim formatter,
--             -- but can be also overriden when specified
--             format = {
--                 formatting_options = nil,
--                 timeout_ms = nil,
--             },
--             servers = {
--                 capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities());
--                 cmd = { "ccls" };
--                 filetypes = { "c", "cpp", "ipp", "cuda", "ic", "objc", "objcpp" };
--                 root_dir = require("lspconfig.util").root_pattern("compile_commands.json", ".ccls", ".git", ".svn");
--                 init_options = {
--                     compilationDatabaseCommand = "",
--                     compilationDatabaseDirectory = "",
--                     cache = {
--                         directory = ".ccls-cache",
--                         format = "json",
--                         hierarchicalPath = false,
--                         retainInMemory = 2
--                     },
--                     capabilities = {
--                         documentOnTypeFormattingProvider = {
--                             firstTriggerCharacter = "}",
--                             moreTriggerCharacter = {}
--                         },
--                         foldingRangeProvider = true,
--                         workspace = {
--                             workspaceFolders = {
--                                 supported = true,
--                                 changeNotifications = true
--                             }
--                         }
--                     },
--                     clang = {
--                         excludeArgs = {},
--                         extraArgs = {},
--                         pathMappings = {},
--                         resourceDir = ""
--                     },
--                     client = {
--                         diagnosticsRelatedInformation = true,
--                         hierarchicalDocumentSymbolSupport = true,
--                         linkSupport = true,
--                         snippetSupport = true
--                     },
--                     codeLens = {
--                         localVariables = true
--                     },
--                     completion = {
--                         caseSensitivity = 2,
--                         detailedLabel = true,
--                         dropOldRequests = true,
--                         duplicateOptional = true,
--                         filterAndSort = true,
--                         include = {
--                             blacklist = {},
--                             maxPathSize = 30,
--                             suffixWhitelist = {
--                                 ".h",
--                                 ".hpp",
--                                 ".hh",
--                                 ".inc"
--                             },
--                             whitelist = {}
--                         },
--                         maxNum = 100,
--                         placeholder = true
--                     },
--                     diagnostics = {
--                         blacklist = {},
--                         onChange = 1000,
--                         onOpen = 0,
--                         onSave = 0,
--                         spellChecking = true,
--                         whitelist = {}
--                     },
--                     highlight = {
--                         largeFileSize = 2097152,
--                         lsRanges = false,
--                         blacklist = {},
--                         whitelist = {}
--                     },
--                     index = {
--                         blacklist = {},
--                         comments = 2,
--                         initialNoLinkage = false,
--                         initialBlacklist = {},
--                         initialWhitelist = {},
--                         maxInitializerLines = 5,
--                         multiVersion = 0,
--                         multiVersionBlacklist = {},
--                         multiVersionWhitelist = {},
--                         name = {
--                             suppressUnwrittenScope = false
--                         },
--                         onChange = false,
--                         parametersInDeclarations = true,
--                         threads = 0,
--                         trackDependency = 2,
--                         whitelist = {},
--                     },
--                     request = {
--                         timeout = 5000
--                     },
--                     session = {
--                         maxNum = 10
--                     },
--                     workspaceSymbol = {
--                         caseSensitivity = 1,
--                         maxNum = 1000,
--                         sort = true
--                     },
--                     xref = {
--                         maxNum = 2000
--                     }
--                 };
--             }
--         }
--     end

-- end

function M.lspconfig_config(LazyPlugin, opts)
    if (no_plugin)
    then
    else
        vim.lsp.config('*', {
          root_markers = { '.git' },
          capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities()),
        })
        vim.lsp.config('clangd',{
            autostart = false,
            cmd = { "clangd" },
            filetypes = { "c", "cpp", "ipp", "cuda", "ic", "objc", "objcpp" },
            root_markers = { "compile_commands.json", ".ccls", ".git", ".svn" },
            on_attach = function(client, bufnr)
                local map_opts = { noremap = true, silent = true }
                vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>k', '<cmd>lua vim.lsp.buf.signature_help()<CR>',
                    map_opts)
                vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', map_opts)

                vim.api.nvim_buf_create_user_command(0, 'LspSwitchSourceHeader', function()
                  switch_source_header(0)
                end, { desc = 'Switch between source/header' })

                vim.api.nvim_buf_create_user_command(0, 'LspShowSymbolInfo', function()
                  symbol_info()
                end, { desc = 'Show symbol info' })

                vim.g.navic_silence = true
                if client.server_capabilities.documentSymbolProvider then
                    require("nvim-navic").attach(client, bufnr)
                end
            end,

        })
        vim.lsp.config('ccls', {
            autostart = false,
            cmd = { "ccls" },
            filetypes = { "c", "cpp", "ipp", "cuda", "ic", "objc", "objcpp" },
            root_markers = { "compile_commands.json", ".ccls", ".git", ".svn" },
            on_attach = function(client, bufnr)
                local map_opts = { noremap = true, silent = true }
                vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>k', '<cmd>lua vim.lsp.buf.signature_help()<CR>',
                    map_opts)
                vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', map_opts)

                vim.api.nvim_buf_create_user_command(0, 'LspSwitchSourceHeader', function()
                  switch_source_header(client, 0)
                end, { desc = 'Switch between source/header' })

                vim.api.nvim_buf_create_user_command(0, 'LspShowSymbolInfo', function()
                  symbol_info()
                end, { desc = 'Show symbol info' })

                vim.g.navic_silence = true
                if client.server_capabilities.documentSymbolProvider then
                    require("nvim-navic").attach(client, bufnr)
                end
            end,
            init_options = {
                compilationDatabaseCommand = "",
                compilationDatabaseDirectory = "",
                cache = {
                    directory = ".ccls-cache",
                    format = "json",
                    hierarchicalPath = false,
                    retainInMemory = 2
                },
                capabilities = {
                    documentOnTypeFormattingProvider = {
                        firstTriggerCharacter = "}",
                        moreTriggerCharacter = {}
                    },
                    foldingRangeProvider = true,
                    workspace = {
                        workspaceFolders = {
                            supported = true,
                            changeNotifications = true
                        }
                    }
                },
                clang = {
                    excludeArgs = {},
                    extraArgs = {},
                    pathMappings = {},
                    resourceDir = ""
                },
                client = {
                    diagnosticsRelatedInformation = true,
                    hierarchicalDocumentSymbolSupport = true,
                    linkSupport = true,
                    snippetSupport = true
                },
                codeLens = {
                    localVariables = true
                },
                completion = {
                    caseSensitivity = 2,
                    detailedLabel = true,
                    dropOldRequests = true,
                    duplicateOptional = true,
                    filterAndSort = true,
                    include = {
                        blacklist = {},
                        maxPathSize = 30,
                        suffixWhitelist = {
                            ".h",
                            ".hpp",
                            ".hh",
                            ".inc"
                        },
                        whitelist = {}
                    },
                    maxNum = 100,
                    placeholder = true
                },
                diagnostics = {
                    blacklist = {},
                    onChange = 1000,
                    onOpen = 0,
                    onSave = 0,
                    spellChecking = true,
                    whitelist = {}
                },
                highlight = {
                    largeFileSize = 2097152,
                    lsRanges = false,
                    blacklist = {},
                    whitelist = {}
                },
                index = {
                    blacklist = {},
                    comments = 2,
                    initialNoLinkage = false,
                    initialBlacklist = {},
                    initialWhitelist = {},
                    maxInitializerLines = 5,
                    multiVersion = 0,
                    multiVersionBlacklist = {},
                    multiVersionWhitelist = {},
                    name = {
                        suppressUnwrittenScope = false
                    },
                    onChange = false,
                    parametersInDeclarations = true,
                    threads = 0,
                    trackDependency = 2,
                    whitelist = {},
                },
                request = {
                    timeout = 5000
                },
                session = {
                    maxNum = 10
                },
                workspaceSymbol = {
                    caseSensitivity = 1,
                    maxNum = 1000,
                    sort = true
                },
                xref = {
                    maxNum = 2000
                }
            }
        })
        
        vim.lsp.enable('ccls')
    end
end

function M.formatter_opts()
    if no_plugin then
    else
        local util = require "formatter.util"
        return {
            -- Enable or disable logging
            logging = false,
            -- Set the log level
            log_level = vim.log.levels.WARN,
            -- All formatter configurations are opt-in
            filetype = {
                cpp = {
                    -- require("formatter.filetypes.cpp").clangformat,
                    function()
                        return {
                            exe = "clang-format",
                            arg = { "--style=",
                                "\"{",
                                " BasedOnStyle: LLVM,",
                                " AccessModifierOffset: -2,",
                                " AlignEscapedNewlines: Left,",
                                " AlignOperands : true,",
                                " AlwaysBreakTemplateDeclarations: true,",
                                " BinPackArguments: true,",
                                " BinPackParameters: false,",
                                " BreakBeforeBinaryOperators: NonAssignment,",
                                " Standard: Auto,",
                                " IndentWidth: 2,",
                                " BreakBeforeBraces: Custom,",
                                " BraceWrapping:",
                                "    {AfterClass:      true,",
                                "    AfterControlStatement: false,",
                                "    AfterEnum:       true,",
                                "    AfterFunction:   true,",
                                "    AfterNamespace:  true,",
                                "    AfterObjCDeclaration: false,",
                                "    AfterStruct:     true,",
                                "    AfterUnion:      true,",
                                "    AfterExternBlock: true,",
                                "    BeforeCatch:     false,",
                                "    BeforeElse:      false,",
                                "    IndentBraces:    false,",
                                "    SplitEmptyFunction: false,",
                                "    SplitEmptyRecord: false,",
                                "    SplitEmptyNamespace: false},",
                                " ColumnLimit: 100,",
                                " AllowAllParametersOfDeclarationOnNextLine: false,",
                                " AlignAfterOpenBracket: true}\"",
                                -- "-assume-filename",
                                -- util.escape_path(util.get_current_buffer_file_name()),
                            },
                            stdin = true,
                        }
                    end
                },
                c = cpp,
                -- Formatter configurations for filetype "lua" go here
                -- and will be executed in order
                lua = {
                    -- "formatter.filetypes.lua" defines default configurations for the
                    -- "lua" filetype
                    require("formatter.filetypes.lua").stylua,

                    -- You can also define your own configuration
                    function()
                        -- Supports conditional formatting
                        if util.get_current_buffer_file_name() == "special.lua" then
                            return nil
                        end

                        -- Full specification of configurations is down below and in Vim help
                        -- files
                        return {
                            exe = "stylua",
                            args = {
                                "--search-parent-directories",
                                "--stdin-filepath",
                                util.escape_path(util.get_current_buffer_file_path()),
                                "--",
                                "-",
                            },
                            stdin = true,
                        }
                    end
                },

                -- Use the special "*" filetype for defining formatter configurations on
                -- any filetype
                ["*"] = {
                    -- "formatter.filetypes.any" defines default configurations for any
                    -- filetype
                    require("formatter.filetypes.any").remove_trailing_whitespace
                }
            },
        }
    end
end

return M
