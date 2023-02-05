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
                    { require("lazy.status").updates, cond = require("lazy.status").has_updates,
                        color = fg("Special") },
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
                    { "progress", separator = "", padding = { left = 1, right = 0 } },
                    { "location", padding = { left = 0, right = 1 } },
                },
                lualine_z = {
                    function()
                        return " " .. os.date("%R")
                    end,
                },
            },
            extensions = { "neo-tree" },
        }
    end
end

function M.telescope_opt()
    local actions = require('telescope.actions')
    if no_plugin then
    else
        return {
            --local opts = {noremap = true, slient = true}
            defaults = {
                -- Default configuration for telescope goes here:
                -- config_key = value,
                -- path_display = "smart";
                theme = everforest,
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
                fuzzy = true,                    -- false will only do exact matching
                override_generic_sorter = true,  -- override the generic sorter
                override_file_sorter = true,     -- override the file sorter
                case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
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
        }
    end
end

function M.nvim_tree()


end

return M
