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

require("lazy").setup(
    {
        -- require("plugins.common"),
        require("plugins.colorschema"),
        -- require("plugins.ui"),
        require("plugins.lsp"),
    },
    require("lazy_config"))
