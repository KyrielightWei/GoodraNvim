return {
    {
        "nvim-lualine/lualine.nvim",
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
        build =
        "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
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

    -- {
    --     "folke/trouble.nvim",
    --     dependencies = { "nvim-tree/nvim-web-devicons" },
    -- },

    -- {
    --     "glepnir/dashboard-nvim",
    --     event = 'VimEnter',
    --     config =
    --         require("plugins.ui.config").dashboard_config()
    --     ,
    --     dependencies = { { 'nvim-tree/nvim-web-devicons' } }
    -- },
    {
        'goolord/alpha-nvim',
    dependencies = {
        'echasnovski/mini.icons',
        'nvim-lua/plenary.nvim'
    },
    config = require("plugins.ui.config").alpha_nvim_config()
    },

    {
        "lukas-reineke/indent-blankline.nvim",
        main = "ibl",
        opts = require("plugins.ui.config").indent_blankline_config()
    },
    -- {
    --     "folke/todo-comments.nvim",
    --     dependencies = { "nvim-lua/plenary.nvim" },
    --     opts = {
    --         -- your configuration comes here
    --         -- or leave it empty to use the default settings
    --         -- refer to the configuration section below
    --     },
    -- },
    {
        "folke/noice.nvim",
        event = "VeryLazy",
        opts = {
            -- add any options here
        },
        dependencies = {
            -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
            "MunifTanjim/nui.nvim",
            -- OPTIONAL:
            --   `nvim-notify` is only needed, if you want to use the notification view.
            --   If not available, we use `mini` as the fallback
            "rcarriga/nvim-notify",
        }
    }
}
