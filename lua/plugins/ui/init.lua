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
    }

}