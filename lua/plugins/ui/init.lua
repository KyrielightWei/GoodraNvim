return {
    { "nvim-lualine/lualine.nvim",
        event = "VeryLazy",
        name = "lualine",
        opts = require("plugins.ui.config").lualine_opt(plugin)
    },
    {
        "nvim-tree/nvim-web-devicons",
    },
    {
        "nvim-tree/nvim-tree.lua",
        dependencies = {
            "nvim-tree/nvim-web-devicons"
        },
        opts = require("plugins.ui.config").nvim_tree_opt(),
    },
    {
        "nvim-telescope/telescope.nvim",
        name = "telescope",
        opts = require("plugins.ui.config").telescope_opt(),
        -- config = require("plugins.ui.config").telescope_fzf_config(LazyPlugin , opts)
    },
    {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
        config = require("plugins.ui.config").telescope_fzf_config(LazyPlugin, opts)
    },
    {
        "GustavoKatel/telescope-asynctasks.nvim",
    },
    {
        "romgrk/barbar.nvim",
        dependencies = {
            "nvim-tree/nvim-web-devicons"
        },
        opts = require("plugins.ui.config").barbar_opts(),
        config = require("plugins.ui.config").barbar_config(lazy_config, opts)
    },

    {
        "lewis6991/gitsigns.nvim",
        opts = require("plugins.ui.config").git_sign_opt()
    },

    {
        "haringsrob/nvim_context_vt",
        opts = require("plugins.ui.config").nvim_context_vt_opt()
    },

    {
        "folke/trouble.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
    },

    {
        "glepnir/dashboard-nvim",
        event = 'VimEnter',
        config =
        require("plugins.ui.config").dashboard_config()
        ,
        dependencies = { { 'nvim-tree/nvim-web-devicons' } }
    },

    {
        "lukas-reineke/indent-blankline.nvim",
        opts = {
            -- char = "▏",
            -- char = "│",
            filetype_exclude = { "help", "alpha", "dashboard", "neo-tree", "Trouble", "lazy" },
            show_trailing_blankline_indent = false,
            show_current_context = true,
        },
    }
}
