local M = {}
local no_plugin = require("lazy_config").no_plugin_installed()

function M.lualine_opt(LazyPlugin)
    if no_plugin then
    else
        local icons = require("lazy_config").icons

        local function fg(name)
            return function()
                ---@type {foreground?:number}?
                local hl = vim.api.nvim_get_hl_by_name(name, true)
                return hl and hl.foreground and { fg = string.format("#%06x", hl.foreground) }
            end
        end

        return {
            options = {
                theme = "auto",
                globalstatus = true,
                disabled_filetypes = { statusline = { "dashboard", "lazy", "alpha" } },
            },
            sections = {
                lualine_a = { "mode" },
                lualine_b = { "branch" },
                lualine_c = {
                    {
                        "diagnostics",
                        symbols = {
                            error = icons.diagnostics.Error,
                            warn = icons.diagnostics.Warn,
                            info = icons.diagnostics.Info,
                            hint = icons.diagnostics.Hint,
                        },
                    },
                    { "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 } },
                    { "filename", path = 1, symbols = { modified = "  ", readonly = "", unnamed = "" } },
                    -- stylua: ignore
                    -- {
                    --   function() return require("nvim-navic").get_location() end,
                    --   cond = function() return package.loaded["nvim-navic"] and require("nvim-navic").is_available() end,
                    -- },
                },
                lualine_x = {
                    -- stylua: ignore
                    -- {
                    --   function() return require("noice").api.status.command.get() end,
                    --   cond = function() return package.loaded["noice"] and require("noice").api.status.command.has() end,
                    --   color = fg("Statement")
                    -- },
                    -- -- stylua: ignore
                    -- {
                    --   function() return require("noice").api.status.mode.get() end,
                    --   cond = function() return package.loaded["noice"] and require("noice").api.status.mode.has() end,
                    --   color = fg("Constant") ,
                    -- },
                    {
                        require("lazy.status").updates,
                        cond = require("lazy.status").has_updates,
                        color = fg("Special")
                    },
                    {
                        "diff",
                        symbols = {
                            added = icons.git.added,
                            modified = icons.git.modified,
                            removed = icons.git.removed,
                        },
                    },
                },
                lualine_y = {
                    { "progress", separator = "",                   padding = { left = 1, right = 0 } },
                    { "location", padding = { left = 0, right = 1 } },
                },
                lualine_z = {
                    function()
                        return " " .. os.date("%R")
                    end,
                },
            },
            winbar = {
                lualine_a = {
                    {
                        'filename',
                        path = 1,
                    }
                },
                lualine_b = {
                    {
                        function() return require("nvim-navic").get_location() end,
                        cond = function() return package.loaded["nvim-navic"] and require("nvim-navic").is_available() end
                    }
                },
                lualine_c = {
                },
                lualine_x = {},
                lualine_y = {},
                lualine_z = {}
            },
            inactive_winbar = {
                lualine_a = {},
                lualine_b = {},
                lualine_c = { 'filename' },
                lualine_x = {},
                lualine_y = {},
                lualine_z = {}
            },
            extensions = { "neo-tree" },
        }
    end
end

function M.telescope_opt()
    if no_plugin then
    else
        local actions = require('telescope.actions')
        return {
            --local opts = {noremap = true, slient = true}
            defaults = {
                -- Default configuration for telescope goes here:
                -- config_key = value,
                -- path_display = "smart";
                -- theme = everforest,
                color_devicons = true,
                -- Format path as "file.txt (path\to\file\)"
                path_display = function(opts, path)
                    -- local tail = require("telescope.utils").path_tail(path)
                    local smart = require("telescope.utils").path_smart(path)
                    return string.format("%s", smart)
                end,
                mappings = {
                    i = {
                        ["<C-n>"] = actions.move_selection_next,
                        ["<C-p>"] = actions.move_selection_previous,
                        ["<C-c>"] = actions.close,
                        ["<Down>"] = actions.move_selection_next,
                        ["<Up>"] = actions.move_selection_previous,
                        ["<CR>"] = actions.select_default,
                        ["<leader>x"] = actions.select_horizontal,
                        ["<leader>v"] = actions.select_vertical,
                        ["<leader>t"] = actions.select_tab,
                        ["<C-u>"] = actions.preview_scrolling_up,
                        ["<C-d>"] = actions.preview_scrolling_down,
                        ["<PageUp>"] = actions.results_scrolling_up,
                        ["<PageDown>"] = actions.results_scrolling_down,
                        ["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
                        ["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
                        ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
                        ["<M-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
                        ["<C-l>"] = actions.complete_tag,
                        ["<C-_>"] = actions.which_key, -- keys from pressing <C-/>
                        ["<C-w>"] = { "<c-s-w>", type = "command" },
                    },

                    n = {
                        ["<esc>"] = actions.close,
                        ["<CR>"] = actions.select_default,
                        ["<leader>x"] = actions.select_horizontal,
                        ["<leader>v"] = actions.select_vertical,
                        ["<leader>t"] = actions.select_tab,
                        ["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
                        ["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
                        ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
                        ["<M-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
                        ["j"] = actions.move_selection_next,
                        ["k"] = actions.move_selection_previous,
                        ["H"] = actions.move_to_top,
                        ["M"] = actions.move_to_middle,
                        ["L"] = actions.move_to_bottom,
                        ["<Down>"] = actions.move_selection_next,
                        ["<Up>"] = actions.move_selection_previous,
                        ["gg"] = actions.move_to_top,
                        ["G"] = actions.move_to_bottom,
                        ["<C-u>"] = actions.preview_scrolling_up,
                        ["<C-d>"] = actions.preview_scrolling_down,
                        ["<PageUp>"] = actions.results_scrolling_up,
                        ["<PageDown>"] = actions.results_scrolling_down,
                        ["?"] = actions.which_key,
                    },
                }
            },
            pickers = {
                -- Default configuration for builtin pickers goes here:
                -- picker_name = {
                --   picker_config_key = value,
                --   ...
                -- }
                -- Now the picker_config_key will be applied every time you call this
                -- builtin picker
            },
            extensions = {
                -- Your extension configuration goes here:
                -- extension_name = {
                --   extension_config_key = value,
                -- }
                -- please take a look at the readme of the extension you want to configure
                fzf = {
                    fuzzy = true,                   -- false will only do exact matching
                    override_generic_sorter = true, -- override the generic sorter
                    override_file_sorter = true,    -- override the file sorter
                    case_mode = "smart_case",       -- or "ignore_case" or "respect_case"
                    -- the default case_mode is "smart_case"
                },
                -- file_browser = {
                --   theme = "ivy",
                --   -- picker = {
                --   --   cwd_to_path = true,
                --   -- },
                --   mappings = {
                --     ["i"] = {
                --       -- your custom insert mode mappings
                --     },
                --     ["n"] = {
                --       -- your custom normal mode mappings
                --     },
                --   },
            },
        }
    end
end

local function nvim_tree_on_attach(bufnr)
    local api = require "nvim-tree.api"

    local function opts(desc)
        return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
    end
    -- default mappings
    api.config.mappings.default_on_attach(bufnr)

    -- custom mappings
    -- vim.keymap.set('n', '<C-t>', api.tree.change_root_to_parent,        opts('Up'))
    vim.keymap.set('n', '?', api.tree.toggle_help, opts('Help'))
end

function M.nvim_tree_opt()
    if no_plugin then
    else
        return {
            on_attach = nvim_tree_on_attach,
            tab = {
                sync = {
                    open = false,
                    close = false,
                    ignore = {},
                },
            },
            disable_netrw = true,
            respect_buf_cwd = true,
            update_focused_file = {
                enable      = true,
                update_cwd  = false,
                ignore_list = {}
            },
            -- 不显示 git 状态图标
            git = {
                enable = true,
                ignore = false,
                show_on_dirs = true,
                timeout = 400,
            },
            view = {
                -- mappings =
                -- {
                --     custom_only = true,
                --     -- list = {
                --     --     { key = { "<CR>", "o", "<2-LeftMouse>" }, action = "edit" },
                --     --     { key = "<leader>e", action = "edit_in_place" },
                --     --     { key = { "O" }, action = "edit_no_picker" },
                --     --     { key = { "<2-RightMouse>", "<C-]>" }, action = "cd" },
                --     --     { key = "<leader>v", action = "vsplit" },
                --     --     { key = "<leader>x", action = "split" },
                --     --     { key = "<leader>t", action = "tabnew" },
                --     --     { key = "<", action = "prev_sibling" },
                --     --     { key = ">", action = "next_sibling" },
                --     --     { key = "P", action = "parent_node" },
                --     --     { key = "<BS>", action = "close_node" },
                --     --     { key = "<Tab>", action = "preview" },
                --     --     { key = "K", action = "first_sibling" },
                --     --     { key = "J", action = "last_sibling" },
                --     --     { key = "I", action = "toggle_git_ignored" },
                --     --     { key = "H", action = "toggle_dotfiles" },
                --     --     { key = "R", action = "refresh" },
                --     --     { key = "a", action = "create" },
                --     --     { key = "d", action = "remove" },
                --     --     { key = "D", action = "trash" },
                --     --     { key = "r", action = "rename" },
                --     --     { key = "<leader>r", action = "full_rename" },
                --     --     { key = "x", action = "cut" },
                --     --     { key = "c", action = "copy" },
                --     --     { key = "p", action = "paste" },
                --     --     { key = "y", action = "copy_name" },
                --     --     { key = "Y", action = "copy_path" },
                --     --     { key = "gy", action = "copy_absolute_path" },
                --     --     { key = "[c", action = "prev_git_item" },
                --     --     { key = "]c", action = "next_git_item" },
                --     --     { key = "-", action = "dir_up" },
                --     --     { key = "s", action = "system_open" },
                --     --     { key = "q", action = "close" },
                --     --     { key = "g?", action = "toggle_help" },
                --     --     { key = "W", action = "collapse_all" },
                --     --     { key = "S", action = "search_node" },
                --     --     { key = "<leader>k", action = "toggle_file_info" },
                --     --     { key = ".", action = "run_file_command" },
                --     -- }
                -- },
                float = {
                    enable = false,
                    quit_on_focus_loss = true,
                    open_win_config = {
                        relative = "editor",
                        border = "rounded",
                        width = 30,
                        height = 30,
                        row = 1,
                        col = 1,
                    },
                },
            },
            renderer = {
                add_trailing = false,
                group_empty = false,
                highlight_git = false,
                full_name = false,
                highlight_opened_files = "none",
                root_folder_modifier = ":~",
                indent_markers = {
                    enable = false,
                    icons = {
                        corner = "└",
                        edge = "│",
                        item = "│",
                        none = " ",
                    },
                },
                icons = {
                    webdev_colors = true,
                    git_placement = "before",
                    padding = " ",
                    symlink_arrow = " ➛ ",
                    show = {
                        file = true,
                        folder = true,
                        folder_arrow = true,
                        git = true,
                    },
                    glyphs = {
                        default = "",
                        symlink = "",
                        bookmark = "",
                        folder = {
                            arrow_closed = "",
                            arrow_open = "",
                            default = "",
                            open = "",
                            empty = "",
                            empty_open = "",
                            symlink = "",
                            symlink_open = "",
                        },
                        git = {
                            unstaged = "✗",
                            staged = "✓",
                            unmerged = "",
                            renamed = "➜",
                            untracked = "★",
                            deleted = "",
                            ignored = "◌",
                        },
                    },
                },
                special_files = { "Cargo.toml", "Makefile", "README.md", "readme.md" },
                symlink_destination = true,
            },
        }
    end
end

function M.telescope_fzf_config(LazyPlugin, opts)
    if no_plugin then
    else
        -- require("telescope").setup(opts)
        require('telescope').load_extension('fzf')
    end
end

function M.rainbow_config(LazyPlugin, opts)
  if no_plugin then
  else 
    -- require("rainbow-delimiters.setup").setup({
    --       strategy = {
    --         [''] = 'rainbow-delimiters.strategy.global',
    --         vim = 'rainbow-delimiters.strategy.local',
    --       },
    --       query = {
    --         [''] = 'rainbow-delimiters.strategy.global',
    --         vim = 'rainbow-delimiters.strategy.local',
    --       },
    --       highlight = {
    --         'RainbowDelimiterRed',
    --         'RainbowDelimiterYellow',
    --         'RainbowDelimiterBlue',
    --         'RainbowDelimiterOrange',
    --         'RainbowDelimiterGreen',
    --         'RainbowDelimiterViolet',
    --         'RainbowDelimiterCyan',
    --       },
    -- })
  end
end

function M.barbar_opts()
    if no_plugin then
    else
        return {
            -- -- Enable/disable animations
            -- animation = true,
            -- -- Enable/disable auto-hiding the tab bar when there is a single buffer
            -- auto_hide = false,
            -- -- Enable/disable current/total tabpages indicator (top right corner)
            -- tabpages = true,
            -- -- Enable/disable close button
            -- closable = true,
            -- -- Enables/disable clickable tabs
            -- --  - left-click: go to buffer
            -- --  - middle-click: delete buffer
            -- clickable = true,
            -- -- Excludes buffers from the tabline
            -- exclude_ft = { 'javascript' },
            -- exclude_name = { 'package.json' },
            -- -- Enable/disable icons
            -- -- if set to 'numbers', will show buffer index in the tabline
            -- -- if set to 'both', will show buffer index and icons in the tabline
            -- icons = true,
            -- -- If set, the icon color will follow its corresponding buffer
            -- -- highlight group. By default, the Buffer*Icon group is linked to the
            -- -- Buffer* group (see Highlighting below). Otherwise, it will take its
            -- -- default value as defined by devicons.
            -- icon_custom_colors = false,
            -- -- Configure icons on the bufferline.
            -- icon_separator_active = '▎',
            -- icon_separator_inactive = '▎',
            -- icon_close_tab = '',
            -- icon_close_tab_modified = '●',
            -- icon_pinned = '車',
            -- -- If true, new buffers will be inserted at the start/end of the list.
            -- -- Default is to insert after current buffer.
            -- insert_at_end = false,
            -- insert_at_start = false,
            -- -- Sets the maximum padding width with which to surround each tab
            -- maximum_padding = 1,
            -- -- Sets the maximum buffer name length.
            -- maximum_length = 30,
            -- -- If set, the letters for each buffer in buffer-pick mode will be
            -- -- assigned based on their name. Otherwise or in case all letters are
            -- -- already assigned, the behavior is to assign letters in order of
            -- -- usability (see order below)
            -- semantic_letters = true,
            -- -- New buffer letters are assigned in this order. This order is
            -- -- optimal for the qwerty keyboard layout but might need adjustement
            -- -- for other layouts.
            -- letters = 'asdfjkl;ghnmxcvbziowerutyqpASDFJKLGHNMXCVBZIOWERUTYQP',
            -- -- Sets the name of unnamed buffers. By default format is "[Buffer X]"
            -- -- where X is the buffer number. But only a static string is accepted here.
            -- no_name_title = nil,
        }
    end
end

function M.barbar_config(LazyPlugin, opts)
    if no_plugin then
    else
        require 'bufferline'.setup(opts)
    end
end

function M.rainbow_opt()
    if no_plugin then
    else
        return {

        }
    end
end

function M.git_sign_opt()
    if no_plugin then
    else
        return {
            signs                        = {
                add          = { text = '┃' },
                change       = { text = '┃' },
                delete       = { text = '_' },
                topdelete    = { text = '‾' },
                changedelete = { text = '~' },
                untracked    = { text = '┆' },
            },
            signs_staged                 = {
                add          = { text = '┃' },
                change       = { text = '┃' },
                delete       = { text = '_' },
                topdelete    = { text = '‾' },
                changedelete = { text = '~' },
                untracked    = { text = '┆' },
            },
            signs_staged_enable          = true,
            signcolumn                   = true,  -- Toggle with `:Gitsigns toggle_signs`
            numhl                        = true,  -- Toggle with `:Gitsigns toggle_numhl`
            linehl                       = false, -- Toggle with `:Gitsigns toggle_linehl`
            word_diff                    = false, -- Toggle with `:Gitsigns toggle_word_diff`
            watch_gitdir                 = {
                interval = 1000,
                follow_files = true
            },
            attach_to_untracked          = true,
            current_line_blame           = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
            current_line_blame_opts      = {
                virt_text = true,
                virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
                delay = 1000,
                ignore_whitespace = false,
            },
            current_line_blame_formatter = '<author>, <author_time:%Y-%m-%d> - <summary>',
            sign_priority                = 6,
            update_debounce              = 10,
            status_formatter             = nil, -- Use default
            max_file_length              = 40000,
            preview_config               = {
                -- Options passed to nvim_open_win
                border = 'single',
                style = 'minimal',
                relative = 'cursor',
                row = 0,
                col = 1
            },
        }
    end
end

function M.nvim_context_vt_opt()
    if no_plugin then
    else
        return {
            -- Enable by default. You can disable and use :NvimContextVtToggle to maually enable.
            -- Default: true
            enabled = true,
            -- Override default virtual text prefix
            -- Default: '-->'
            prefix = '炙',
            -- Override the internal highlight group name
            -- Default: 'ContextVt'
            -- highlight = 'CustomContextVt',

            -- Disable virtual text for given filetypes
            -- Default: { 'markdown' }
            disable_ft = { 'markdown' },
            -- Disable display of virtual text below blocks for indentation based languages like Python
            -- Default: false
            disable_virtual_lines = false,
            -- Same as above but only for spesific filetypes
            -- Default: {}
            disable_virtual_lines_ft = { 'yaml' },
            -- How many lines required after starting position to show virtual text
            -- Default: 1 (equals two lines total)
            min_rows = 1,
            -- Same as above but only for spesific filetypes
            -- Default: {}
            min_rows_ft = {},
            -- -- Custom virtual text node parser callback
            -- -- Default: nil
            -- custom_parser = function(node, ft, opts)
            --   local ts_utils = require('nvim-treesitter.ts_utils')

            --   -- If you return `nil`, no virtual text will be displayed.
            --   if node:type() == 'function' then
            --     return nil
            --   end

            --   -- This is the standard text
            --   return '--> ' .. ts_utils.get_node_text(node)[1]
            -- end,

            -- -- Custom node validator callback
            -- -- Default: nil
            -- custom_validator = function(node, ft, opts)
            --   -- Internally a node is matched against min_rows and configured targets
            --   local default_validator = require('nvim_context_vt.utils').default_validator
            --   if default_validator(node, ft) then
            --     -- Custom behaviour after using the internal validator
            --     if node:type() == 'function' then
            --       return false
            --     end
            --   end

            --   return true
            -- end,

            -- -- Custom node virtual text resolver callback
            -- -- Default: nil
            -- custom_resolver = function(nodes, ft, opts)
            --   -- By default the last node is used
            --   return nodes[#nodes]
            -- end,
        }
    end
end

function M.indent_blankline_config()
    if no_plugin then
    else
        require("ibl").setup({
            exclude = {
                filetypes = { "lspinfo", "help", "TelescopeResult", "dashboard", "neo-tree", "Trouble", "lazy" },
                buftypes = { "terminal" },
            }
        })
    end
end

local art = {

    "",
    "",
    "        ⢀⣴⡾⠃⠄⠄⠄⠄⠄⠈⠺⠟⠛⠛⠛⠛⠻⢿⣿⣿⣿⣿⣶⣤⡀  ",
    "      ⢀⣴⣿⡿⠁⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⣸⣿⣿⣿⣿⣿⣿⣿⣷ ",
    "     ⣴⣿⡿⡟⡼⢹⣷⢲⡶⣖⣾⣶⢄⠄⠄⠄⠄⠄⢀⣼⣿⢿⣿⣿⣿⣿⣿⣿⣿ ",
    "    ⣾⣿⡟⣾⡸⢠⡿⢳⡿⠍⣼⣿⢏⣿⣷⢄⡀⠄⢠⣾⢻⣿⣸⣿⣿⣿⣿⣿⣿⣿ ",
    "  ⣡⣿⣿⡟⡼⡁⠁⣰⠂⡾⠉⢨⣿⠃⣿⡿⠍⣾⣟⢤⣿⢇⣿⢇⣿⣿⢿⣿⣿⣿⣿⣿ ",
    " ⣱⣿⣿⡟⡐⣰⣧⡷⣿⣴⣧⣤⣼⣯⢸⡿⠁⣰⠟⢀⣼⠏⣲⠏⢸⣿⡟⣿⣿⣿⣿⣿⣿ ",
    " ⣿⣿⡟⠁⠄⠟⣁⠄⢡⣿⣿⣿⣿⣿⣿⣦⣼⢟⢀⡼⠃⡹⠃⡀⢸⡿⢸⣿⣿⣿⣿⣿⡟ ",
    " ⣿⣿⠃⠄⢀⣾⠋⠓⢰⣿⣿⣿⣿⣿⣿⠿⣿⣿⣾⣅⢔⣕⡇⡇⡼⢁⣿⣿⣿⣿⣿⣿⢣ ",
    " ⣿⡟⠄⠄⣾⣇⠷⣢⣿⣿⣿⣿⣿⣿⣿⣭⣀⡈⠙⢿⣿⣿⡇⡧⢁⣾⣿⣿⣿⣿⣿⢏⣾ ",
    " ⣿⡇⠄⣼⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠟⢻⠇⠄⠄⢿⣿⡇⢡⣾⣿⣿⣿⣿⣿⣏⣼⣿ ",
    " ⣿⣷⢰⣿⣿⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⢰⣧⣀⡄⢀⠘⡿⣰⣿⣿⣿⣿⣿⣿⠟⣼⣿⣿ ",
    " ⢹⣿⢸⣿⣿⠟⠻⢿⣿⣿⣿⣿⣿⣿⣿⣶⣭⣉⣤⣿⢈⣼⣿⣿⣿⣿⣿⣿⠏⣾⣹⣿⣿ ",
    " ⢸⠇⡜⣿⡟⠄⠄⠄⠈⠙⣿⣿⣿⣿⣿⣿⣿⣿⠟⣱⣻⣿⣿⣿⣿⣿⠟⠁⢳⠃⣿⣿⣿ ",
    "  ⣰⡗⠹⣿⣄⠄⠄⠄⢀⣿⣿⣿⣿⣿⣿⠟⣅⣥⣿⣿⣿⣿⠿⠋  ⣾⡌⢠⣿⡿⠃ ",
    " ⠜⠋⢠⣷⢻⣿⣿⣶⣾⣿⣿⣿⣿⠿⣛⣥⣾⣿⠿⠟⠛⠉            ",
    "",
    ""
}

function M.dashboard_config()
    if no_plugin then
    else
        require('dashboard').setup {
            theme = 'hyper', --  theme is doom and hyper default is hyper
            config = {

                header = art,
            }, --  config used for theme
            hide = {
                --   statusline,    -- hide statusline default is true
                tabline, -- hide the tabline
                winbar,  -- hide winbar
            },
            preview = {
                command,     -- preview command
                file_path,   -- preview file path
                file_height, -- preview file height
                file_width,  -- preview file width
            },
        }
    end
end

function M.alpha_nvim_config()
    if no_plugin then
    else
        local alpha = require("alpha")
        local dashboard = require("alpha.themes.dashboard")

        math.randomseed(os.time())

        local function pick_color()
            local colors = { "String", "Identifier", "Keyword", "Number" }
            return colors[math.random(#colors)]
        end

        local function footer()
            local datetime = os.date(" %d-%m-%Y   %H:%M:%S")
            local version = vim.version()
            local nvim_version_info = "   v" .. version.major .. "." .. version.minor .. "." .. version.patch

            return datetime .. "  " .. nvim_version_info
        end

        -- local logo = {
        --     "",
        --     "",
        --     "        ⢀⣴⡾⠃⠄⠄⠄⠄⠄⠈⠺⠟⠛⠛⠛⠛⠻⢿⣿⣿⣿⣿⣶⣤⡀  ",
        --     "      ⢀⣴⣿⡿⠁⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⣸⣿⣿⣿⣿⣿⣿⣿⣷ ",
        --     "     ⣴⣿⡿⡟⡼⢹⣷⢲⡶⣖⣾⣶⢄⠄⠄⠄⠄⠄⢀⣼⣿⢿⣿⣿⣿⣿⣿⣿⣿ ",
        --     "    ⣾⣿⡟⣾⡸⢠⡿⢳⡿⠍⣼⣿⢏⣿⣷⢄⡀⠄⢠⣾⢻⣿⣸⣿⣿⣿⣿⣿⣿⣿ ",
        --     "  ⣡⣿⣿⡟⡼⡁⠁⣰⠂⡾⠉⢨⣿⠃⣿⡿⠍⣾⣟⢤⣿⢇⣿⢇⣿⣿⢿⣿⣿⣿⣿⣿ ",
        --     " ⣱⣿⣿⡟⡐⣰⣧⡷⣿⣴⣧⣤⣼⣯⢸⡿⠁⣰⠟⢀⣼⠏⣲⠏⢸⣿⡟⣿⣿⣿⣿⣿⣿ ",
        --     " ⣿⣿⡟⠁⠄⠟⣁⠄⢡⣿⣿⣿⣿⣿⣿⣦⣼⢟⢀⡼⠃⡹⠃⡀⢸⡿⢸⣿⣿⣿⣿⣿⡟ ",
        --     " ⣿⣿⠃⠄⢀⣾⠋⠓⢰⣿⣿⣿⣿⣿⣿⠿⣿⣿⣾⣅⢔⣕⡇⡇⡼⢁⣿⣿⣿⣿⣿⣿⢣ ",
        --     " ⣿⡟⠄⠄⣾⣇⠷⣢⣿⣿⣿⣿⣿⣿⣿⣭⣀⡈⠙⢿⣿⣿⡇⡧⢁⣾⣿⣿⣿⣿⣿⢏⣾ ",
        --     " ⣿⡇⠄⣼⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠟⢻⠇⠄⠄⢿⣿⡇⢡⣾⣿⣿⣿⣿⣿⣏⣼⣿ ",
        --     " ⣿⣷⢰⣿⣿⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⢰⣧⣀⡄⢀⠘⡿⣰⣿⣿⣿⣿⣿⣿⠟⣼⣿⣿ ",
        --     " ⢹⣿⢸⣿⣿⠟⠻⢿⣿⣿⣿⣿⣿⣿⣿⣶⣭⣉⣤⣿⢈⣼⣿⣿⣿⣿⣿⣿⠏⣾⣹⣿⣿ ",
        --     " ⢸⠇⡜⣿⡟⠄⠄⠄⠈⠙⣿⣿⣿⣿⣿⣿⣿⣿⠟⣱⣻⣿⣿⣿⣿⣿⠟⠁⢳⠃⣿⣿⣿ ",
        --     "  ⣰⡗⠹⣿⣄⠄⠄⠄⢀⣿⣿⣿⣿⣿⣿⠟⣅⣥⣿⣿⣿⣿⠿⠋  ⣾⡌⢠⣿⡿⠃ ",
        --     " ⠜⠋⢠⣷⢻⣿⣿⣶⣾⣿⣿⣿⣿⠿⣛⣥⣾⣿⠿⠟⠛⠉            ",
        --     "",
        --     ""
        -- }
        --
        local logo = {
            "",
            "",
            "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣴⡆⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
            "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣾⣿⣧⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
            "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣾⣿⣿⣿⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
            "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡾⠋⠉⠀⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
            "⠀⠀⠀⠀⠀⠀⠀⠀⠀⣼⠃⠀⠀⠀⡇⠀⠀⠀⠀⠀⠀⣠⠖⠲⢤⡖⠒⣆⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
            "⠀⠀⠀⠀⠀⠀⠀⠀⢀⡏⠀⠀⠀⠀⡇⠀⠀⠀⠀⠀⠀⡏⠀⠀⠀⠀⠀⢀⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
            "⠀⠀⠀⠀⢀⣀⠀⠀⢸⠀⠀⠀⠀⠀⡇⠀⠀⠀⠀⠀⠀⠸⣄⠀⠁⣠⠞⠉⠀⠀⠀⠀⠀⠀⠀⠀⢀⣀⣀⣠⣤⣤⣤⣤⠀⠀",
            "⠀⡞⠉⠻⠁⢹⠀⠀⡏⠀⠀⠀⠀⢸⠃⠀⠀⠀⠀⠀⠀⠀⠀⠹⣶⠋⠀⠀⠀⠀⣀⡤⠴⠒⠊⠉⠉⠀⠀⣿⣿⣿⠿⠋⠀⠀",
            "⠀⠳⢤⡀⠀⡞⠁⠀⡇⠀⠀⢀⡠⠼⠴⠒⠒⠒⠒⠦⠤⠤⣄⣀⠀⢀⣠⠴⠚⠉⠀⠀⠀⠀⠀⠀⠀⠀⣼⠿⠋⠁⠀⠀⠀⠀",
            "⠀⠀⠀⠈⠷⡏⠀⠀⣇⠔⠂⠈⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢨⠿⠋⠀⠀⠀⠀⠀⠀⠀⠀⣀⡤⠖⠋⠁⠀⠀⠀⠀⠀⠀⠀",
            "⠀⠀⠀⠀⠀⠀⠀⢰⠋⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⣠⠤⠒⠋⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
            "⠀⠀⠀⠀⠀⠀⢀⡟⠀⣠⣄⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠉⢻⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣠⣤⣤⡤⠤⢴",
            "⠀⠀⠀⠀⠀⠀⣸⠁⣾⣿⣀⣽⡆⠀⠀⠀⠀⠀⠀⠀⢠⣾⠉⢿⣦⠀⠀⠀⢸⡀⠀⠀⢀⣠⠤⠔⠒⠋⠉⠉⠀⠀⠀⠀⢀⡞",
            "⠀⠀⠀⠀⠀⢀⡏⠀⠹⠿⠿⠟⠁⠀⠰⠦⠀⠀⠀⠀⠸⣿⣿⣿⡿⠀⠀⠀⢘⡧⠖⠋⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡼⠀",
            "⠀⠀⠀⠀⠀⣼⠦⣄⠀⠀⢠⣀⣀⣴⠟⠶⣄⡀⠀⠀⡀⠀⠉⠁⠀⠀⠀⠀⢸⠇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣸⠁⠀",
            "⠀⠀⠀⠀⢰⡇⠀⠈⡇⠀⠀⠸⡾⠁⠀⠀⠀⠉⠉⡏⠀⠀⠀⣠⠖⠉⠓⢤⢸⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣰⠃⠀⠀",
            "⠀⠀⠀⠀⠀⢧⣀⡼⠃⠀⠀⠀⢧⠀⠀⠀⠀⠀⢸⠃⠀⠀⠀⣧⠀⠀⠀⣸⢹⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡰⠃⠀⠀⠀",
            "⠀⠀⠀⠀⠀⠈⢧⡀⠀⠀⠀⠀⠘⣆⠀⠀⠀⢠⠏⠀⠀⠀⠀⠈⠳⠤⠖⠃⡟⠀⠀⠀⢾⠛⠛⠛⠛⠛⠛⠛⠛⠁⠀⠀⠀⠀",
            "⠀⠀⠀⠀⠀⠀⠀⠙⣆⠀⠀⠀⠀⠈⠦⣀⡴⠋⠀⠀⠀⠀⠀⠀⠀⠀⢀⣼⠙⢦⠀⠀⠘⡇⠀⠀⠀⠀⠀⠀⢀⣀⠀⠀⠀⠀",
            "⠀⠀⠀⠀⠀⠀⠀⢠⡇⠙⠦⣄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣠⠴⠋⠸⡇⠈⢳⡀⠀⢹⡀⠀⠀⠀⢀⡞⠁⠉⣇⣀⠀⠀",
            "⠀⠀⠀⠀⠀⠀⠀⡼⣀⠀⠀⠈⠙⠂⠀⠀⠀⠀⠀⠀⠀⠀⠀⠉⠀⠀⠀⠀⣷⠴⠚⠁⠀⣀⣷⠀⠀⠀⢠⠇⠀⠀⠀⠀⠀⣳",
            "⠀⠀⠀⠀⠀⠀⡴⠁⡏⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠘⣆⡴⠚⠉⠉⠀⠀⠀⠀⢸⠃⣀⣠⠤⠤⠖⠋",
            "⣼⢷⡆⠀⣠⡴⠧⣄⣇⠀⠀⠀⠀⡴⠚⠙⠲⠞⠛⠙⡆⠀⠀⠀⠀⠀⢀⡇⣠⣽⢦⣄⢀⣴⣶⠀⠋⠉⠀⠀⠀⠀⠀⠀⠀⠀",
            "⡿⣼⣽⡞⠁⠀⠀⠀⢹⡀⠀⠀⠀⢹⠀⠀⠀⠀⠀⠀⣸⠀⠀⠀⠀⠀⣼⠉⠁⠀⠀⢠⢟⣿⣿⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
            "⣷⠉⠁⢳⠀⠀⠀⠀⠈⣧⠀⠀⠀⠀⠙⢦⠀⠀⠀⡠⠁⠀⠀⠀⠀⣰⠃⠀⠀⠀⠀⠏⠀⠀⡿⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
            "⠹⡆⠀⠈⡇⠀⠀⠀⠀⠘⣆⠀⠀⠀⠀⠀⠹⣧⠞⠁⠀⠀⠀⠀⣰⠃⠀⠀⠀⠀⠀⠀⠀⣸⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
            "⠀⢳⡀⠀⠙⠀⠀⠀⠀⠀⠘⣆⠀⠀⠀⠀⠀⡇⠀⠀⠀⠀⠀⣰⠃⠀⠀⠀⠀⢀⡄⠀⢠⠇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
            "⠀⠀⢳⡀⣰⣀⣀⣀⠀⠀⠀⠘⣦⣀⠀⠀⠀⡇⠀⠀⠀⢀⡴⠃⠀⠀⠀⠀⠀⢸⡇⢠⠏⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
            "⠀⠀⠀⠉⠉⠀⠀⠈⠉⠉⠉⠙⠻⠿⠾⠾⠻⠓⢦⠦⡶⡶⠿⠛⠛⠓⠒⠒⠚⠛⠛⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
            "",
            "",
        }
        dashboard.section.header.val = logo
        dashboard.section.header.opts.hl = pick_color()

        dashboard.section.buttons.val = {
            dashboard.button("nvim_tree", "  File Explorer", ":NvimTreeToggle<CR>"),
            dashboard.button("Tele-F", "  Find File", "<space>f"),
            dashboard.button("Tele-S", "  Find Word", "<space>s"),
            dashboard.button("q", "  Quit", ":qa<cr>")
        }

        dashboard.section.footer.val = footer()
        dashboard.section.footer.opts.hl = "Constant"

        --         local mru = {
        --     type = "group",
        --     val = {
        --         { type = "padding", val = 1 },
        --         { type = "text", val = "MRU", opts = { hl = "SpecialComment" } },
        --         { type = "padding", val = 1 },
        --         {
        --             type = "group",
        --             val = function()
        --                 return { require("alpha.themes.startify").mru(5,false, 5) }
        --             end,
        --         },
        --     },
        -- }
        -- local mru_cwd = {
        --     type = "group",
        --     val = {
        --         { type = "padding", val = 1 },
        --         { type = "text",    val = require("alpha.themes.startify").mru_title, opts = { hl = "SpecialComment", shrink_margin = false } },
        --         { type = "padding", val = 1 },
        --         {
        --             type = "group",
        --             val = function()
        --                 return { require("alpha.themes.startify").mru(0, vim.fn.getcwd()) }
        --             end,
        --             opts = { shrink_margin = false },
        --         },
        --     },
        -- }
        --
        local utils = require("alpha.utils")
        local fnamemodify = vim.fn.fnamemodify
        local filereadable = vim.fn.filereadable
        local leader = "SPC"

        local function button(sc, txt, keybind, keybind_opts)
            local sc_ = sc:gsub("%s", ""):gsub(leader, "<leader>")

            local opts = {
                position = "center",
                shortcut = "[" .. sc .. "] ",
                cursor = 1,
                -- width = 50,
                align_shortcut = "left",
                hl_shortcut = { { "Operator", 0, 1 }, { "Number", 1, #sc + 1 }, { "Operator", #sc + 1, #sc + 2 } },
                shrink_margin = false,
            }
            if keybind then
                keybind_opts = vim.F.if_nil(keybind_opts, { noremap = true, silent = true, nowait = true })
                opts.keymap = { "n", sc_, keybind, keybind_opts }
            end

            local function on_press()
                local key = vim.api.nvim_replace_termcodes(keybind .. "<Ignore>", true, false, true)
                vim.api.nvim_feedkeys(key, "t", false)
            end

            return {
                type = "button",
                val = txt,
                on_press = on_press,
                opts = opts,
            }
        end

        local file_icons = {
            enabled = true,
            highlight = true,
            -- available: devicons, mini, to use nvim-web-devicons or mini.icons
            -- if provider not loaded and enabled is true, it will try to use another provider
            provider = "mini",
        }

        local function icon(fn)
            if file_icons.provider ~= "devicons" and file_icons.provider ~= "mini" then
                vim.notify("Alpha: Invalid file icons provider: " .. file_icons.provider .. ", disable file icons",
                    vim.log.levels.WARN)
                file_icons.enabled = false
                return "", ""
            end

            local ico, hl = utils.get_file_icon(file_icons.provider, fn)
            if ico == "" then
                file_icons.enabled = false
                vim.notify("Alpha: Mini icons or devicons get icon failed, disable file icons", vim.log.levels.WARN)
            end
            return ico, hl
        end

        local function file_button(fn, sc, short_fn, autocd)
            short_fn = vim.F.if_nil(short_fn, fn)
            local ico_txt
            local fb_hl = {}
            if file_icons.enabled then
                local ico, hl = icon(fn)
                local hl_option_type = type(file_icons.highlight)
                if hl_option_type == "boolean" then
                    if hl and file_icons.highlight then
                        table.insert(fb_hl, { hl, 0, #ico })
                    end
                end
                if hl_option_type == "string" then
                    table.insert(fb_hl, { file_icons.highlight, 0, #ico })
                end
                ico_txt = ico .. "  "
            else
                ico_txt = ""
            end
            local cd_cmd = (autocd and " | cd %:p:h" or "")
            local file_button_el = button(sc, ico_txt .. short_fn,
                "<cmd>e " .. vim.fn.fnameescape(fn) .. cd_cmd .. " <CR>")
            local fn_start = short_fn:match(".*[/\\]")
            if fn_start ~= nil then
                table.insert(fb_hl, { "Comment", #ico_txt, #fn_start + #ico_txt })
            end
            file_button_el.opts.hl = fb_hl
            return file_button_el
        end

        --- @param start number
        --- @param cwd string? optional
        --- @param items_number number? optional number of items to generate, default = 10
        local function mru(start, cwd, items_number, opts)
            opts = opts or require("alpha.themes.startify").mru_opts
            items_number = vim.F.if_nil(items_number, 10)
            local oldfiles = {}
            for _, v in pairs(vim.v.oldfiles) do
                if #oldfiles == items_number then
                    break
                end
                local cwd_cond
                if not cwd then
                    cwd_cond = true
                else
                    cwd_cond = vim.startswith(v, cwd)
                end
                local ignore = (opts.ignore and opts.ignore(v, utils.get_extension(v))) or false
                if (filereadable(v) == 1) and cwd_cond and not ignore then
                    oldfiles[#oldfiles + 1] = v
                end
            end

            local tbl = {}
            for i, fn in ipairs(oldfiles) do
                local short_fn
                if cwd then
                    short_fn = fnamemodify(fn, ":.")
                else
                    short_fn = fnamemodify(fn, ":~")
                end
                local file_button_el = file_button(fn, tostring(i + start - 1), short_fn, opts.autocd)
                tbl[i] = file_button_el
            end
            return {
                type = "group",
                val = tbl,
                opts = {
                    --   position = "center",
                },
            }
        end



        local function dashboard_mru()
            return {
                type = "group",
                val = {
                    { type = "padding", val = 1 },
                    { type = "text",    val = "MRU", opts = { hl = "SpecialComment" } },
                    { type = "padding", val = 1 },
                    {
                        type = "group",
                        val = function()
                            return { require("alpha.themes.startify").mru(5, false, 5) }
                        end,
                    },
                },
                opts = {
                    position = "center",
                },
            }
        end

        local function dashboard_mru_cwd()
            return {
                type = "group",
                val = {
                    { type = "padding", val = 1 },
                    { type = "text",    val = "MRU " .. vim.fn.getcwd(), opts = { position = "center", hl = "SpecialComment", shrink_margin = false } },
                    { type = "padding", val = 1 },
                    {
                        type = "group",
                        val = function()
                            return { mru(0, vim.fn.getcwd(), 5) }
                        end,
                        opts = {

                        },
                    },
                    { type = "padding", val = 1 },
                },
                opts = {
                    -- position = "center",
                },
            }
        end

        dashboard.config.layout = {
            { type = "padding", val = 2 },
            dashboard.section.header,
            { type = "padding", val = 2 },
            dashboard.section.buttons,
            dashboard_mru_cwd(),
            -- dashboard_mru(),
            dashboard.section.footer,
        }

        alpha.setup(dashboard.opts)

        vim.cmd([[ autocmd FileType alpha setlocal nofoldenable ]])
    end
end

return M
