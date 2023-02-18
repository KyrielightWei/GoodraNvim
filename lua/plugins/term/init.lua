local M = {}

-- local Terminal = require('toggleterm.terminal').Terminal

-- function M.ob_terminal_init()
--     local debug_build = Terminal:new({ cmd = "./build.sh debug --init --ob-make", hidden = true, direction = "float",
--         count = 1 })
--     local release_build = Terminal:new({ cmd = "./build.sh release --init --ob-make", hidden = true, direction = "float",
--         count = 2 })
-- end

return {
    {
        "akinsho/toggleterm.nvim",
        config = function(LazyPlugins, opts)
            M.ob_terminal_init()
            require("toggleterm").setup {
                hide_numbers = true, -- hide the number column in toggleterm buffers
                shade_filetypes = {},
                autochdir = false, -- when neovim changes it current directory the terminal will change it's own when next it's opened
                shade_terminals = true, -- NOTE: this option takes priority over highlights specified so if you specify Normal highlights you should set this to false
                start_in_insert = true,
                insert_mappings = true, -- whether or not the open mapping applies in insert mode
                terminal_mappings = true, -- whether or not the open mapping applies in the opened terminals
                persist_size = true,
                persist_mode = true, -- if set to true (default) the previous terminal mode will be remembered
                close_on_exit = true, -- close the terminal window when the process exits
                shell = "bash", --vim.o.shell, -- change the default shell
                auto_scroll = true, -- automatically scroll to the bottom on terminal output
                -- This field is only relevant if direction is set to 'float'
            }
        end
    },
}
