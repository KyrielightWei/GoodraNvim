return {
    {
        "xero/miasma.nvim",
        lazy = false,
        priority = 1000,
    },
    {
        "sainnhe/gruvbox-material",
        config = function()
            vim.g.gruvbox_material_better_performance = 1
        end,
    },
    "sainnhe/everforest",
    "savq/melange-nvim",
    "Mofiqul/dracula.nvim",
    "sainnhe/sonokai",
    {
        "catppuccin/nvim",
        name = "catppuccin",
        opts = {
            integrations = {
                cmp = true,
                gitsigns = true,
                nvimtree = true,
                telescope = true,
                ts_rainbow = true,
                native_lsp = {
                    enabled = true,
                },
                lsp_trouble = true,


                -- For more plugins integrations please scroll down (https://github.com/catppuccin/nvim#integrations)
            },
        }
    },
    {
        "rebelot/kanagawa.nvim",
        opts = {
            compile = true,   -- enable compiling the colorscheme
            undercurl = true, -- enable undercurls
            commentStyle = { italic = false },
            functionStyle = {},
            keywordStyle = { italic = true },
            statementStyle = { bold = true },
            typeStyle = {},
            transparent = false,   -- do not set background color
            dimInactive = false,   -- dim inactive window `:h hl-NormalNC`
            terminalColors = true, -- define vim.g.terminal_color_{0,17}
            colors = {             -- add/modify theme and palette colors
                palette = {},
                theme = { wave = {}, lotus = {}, dragon = {}, all = {} },
            },
            overrides = function(colors) -- add/modify highlights
                return {}
            end,
            theme = "wave",    -- Load "wave" theme when 'background' option is not set
            background = {     -- map the value of 'background' option to a theme
                dark = "wave", -- try "dragon" !
                light = "lotus"
            },
        }
    }
}
