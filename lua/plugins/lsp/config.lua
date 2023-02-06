local M = {}
local no_plugin = require("lazy_config").no_plugin_installed()

function M.cmp_opt()
    if no_plugin then
        return nil
    else
        local cmp = require("cmp")
        return {
            formatting = {
                format = require('lspkind').cmp_format({
                    mode = "symbol_text",
                })
            },
            mapping = {
                ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
                ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
                ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
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
                { name = 'treesitter' },
                { name = 'nvim_lsp_signature_help' },
            }),

        }
    end
end

function M.cmp_config(LazyPlugin, opt)
    if no_plugin then
    else
        local cmp = require("cmp")
        cmp.setup(opt)
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
        return true
    else
        require('lspconfig').ccls.setup {
            on_attach = function(client, bufnr)
                local map_opts = { noremap = true, silent = true }
                vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>k', '<cmd>lua vim.lsp.buf.signature_help()<CR>',
                    map_opts)
                vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', map_opts)
            end;
            capabilities = { require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities()) },
            cmd = { "ccls" };
            filetypes = { "c", "cpp", "ipp", "cuda", "ic", "objc", "objcpp" };
            root_dir = require("lspconfig.util").root_pattern("compile_commands.json", ".ccls", ".git", ".svn");
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
        }
    end
end

return M
