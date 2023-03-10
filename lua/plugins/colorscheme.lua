return {
    {
        "sainnhe/gruvbox-material",
        config = function()
            vim.g.gruvbox_material_better_performance = 1
        end,
    },
    "sainnhe/everforest",
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
    }
}
