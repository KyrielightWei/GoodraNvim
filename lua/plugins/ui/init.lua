return {
    { "nvim-lualine/lualine.nvim",
        event = "VeryLazy",
        name = "lualine",
        opts = require("plugins.ui.config").lualine_opt(plugin)
    },

    {
        "kyazdani42/nvim-web-devicons"
    },

    {
        "nvim-telescope/telescope.nvim",
        name = "telescope",
        opts = require("plugins.ui.config").telescope_opt()
    }
}
