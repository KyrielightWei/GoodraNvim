local lazypath = vim.fn.stdpath("data") .. "/lazy_data/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

local lazy_config = require("lazy_config")

-- local plugin_path = lazy_config.get_plugin_path()

-- vim.opt.rtp:prepend(plugin_path)
vim.opt.rtp:append(require("lazy_config").plugin_path .. "/lspkind.nvim/")
vim.opt.rtp:append(require("lazy_config").plugin_path .. "/nvim-cmp/")
vim.opt.rtp:append(require("lazy_config").plugin_path .. "/cmp-nvim-lsp/")
vim.opt.rtp:append(require("lazy_config").plugin_path .. "/nvim-lspconfig/")
vim.opt.rtp:append(require("lazy_config").plugin_path .. "/telescope/")
vim.opt.rtp:append(require("lazy_config").plugin_path .. "/plenary.nvim/")
vim.opt.rtp:append(require("lazy_config").plugin_path .. "/telescope-fzf-native.nvim/")
vim.opt.rtp:append(require("lazy_config").plugin_path .. "/barbar.nvim/")
vim.opt.rtp:append(require("lazy_config").plugin_path .. "/nvim-web-devicons/")
vim.opt.rtp:append(require("lazy_config").plugin_path .. "/formatter.nvim/")
require("lazy").setup(
    {
        "nvim-lua/plenary.nvim",
        "skywind3000/asynctasks.vim",
        "skywind3000/asyncrun.vim",
        "numToStr/Comment.nvim",
        -- "kyazdani42/nvim-web-devicons",
        -- require("plugins.common"),
        require("plugins.colorscheme"),
        -- require("plugins.ui"),
        require("plugins.lsp"),
        require("plugins.ui"),
    },
    lazy_config.get_config())
