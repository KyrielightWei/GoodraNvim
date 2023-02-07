-- class LazyConfig
local M = {}

M.plugin_path = vim.fn.stdpath("data") .. "/lazy_data/plugins"

M.icons = {
    diagnostics = {
        Error = " ",
        Warn = " ",
        Hint = " ",
        Info = " ",
    },
    git = {
        added = " ",
        modified = " ",
        removed = " ",
    },
    kinds = {
        Array = " ",
        Boolean = " ",
        Class = " ",
        Color = " ",
        Constant = " ",
        Constructor = " ",
        Enum = " ",
        EnumMember = " ",
        Event = " ",
        Field = " ",
        File = " ",
        Folder = " ",
        Function = " ",
        Interface = " ",
        Key = " ",
        Keyword = " ",
        Method = " ",
        Module = " ",
        Namespace = " ",
        Null = "ﳠ ",
        Number = " ",
        Object = " ",
        Operator = " ",
        Package = " ",
        Property = " ",
        Reference = " ",
        Snippet = " ",
        String = " ",
        Struct = " ",
        Text = " ",
        TypeParameter = " ",
        Unit = " ",
        Value = " ",
        Variable = " ",
    },
}

function M.no_plugin_installed()
  -- return true;
  return false;
end

function M.get_config()
  return {
      root = M.plugin_path, -- directory where plugins will be installed
      defaults = {
          lazy = false, -- should plugins be lazy-loaded?
          version = nil,
          -- version = "*", -- enable this to try installing the latest stable versions of plugins
      },
      -- leave nil when passing the spec as the first argument to setup()
      spec = nil, ---@type LazySpec
      lockfile = vim.fn.stdpath("config") .. "/lazy-lock.json", -- lockfile generated after running update.
      concurrency = nil, ---@type number limit the maximum amount of concurrent tasks
      git = {
          -- defaults for the `Lazy log` command
          -- log = { "-10" }, -- show the last 10 commits
          log = { "--since=3 days ago" }, -- show commits from the last 3 days
          timeout = 120, -- kill processes that take more than 2 minutes
          url_format = "https://github.com/%s.git",
          -- lazy.nvim requires git >=2.19.0. If you really want to use lazy with an older version,
          -- then set the below to false. This is should work, but is NOT supported and will
          -- increase downloads a lot.
          filter = true,
      },
      dev = {
          -- directory where you store your local plugin projects
          path = "~/projects",
          ---@type string[] plugins that match these patterns will use your local versions instead of being fetched from GitHub
          patterns = {}, -- For example {"folke"}
          fallback = false, -- Fallback to git when local plugin doesn't exist
      },
      install = {
          -- install missing plugins on startup. This doesn't increase startup time.
          missing = true,
          -- try to load one of these colorschemes when starting an installation during startup
          colorscheme = { "habamax" },
      },
      ui = {
          -- a number <1 is a percentage., >1 is a fixed size
          size = { width = 0.8, height = 0.8 },
          wrap = true, -- wrap the lines in the ui
          -- The border to use for the UI window. Accepts same border values as |nvim_open_win()|.
          border = "none",
          icons = {
              cmd = " ",
              config = "",
              event = "",
              ft = " ",
              init = " ",
              import = " ",
              keys = " ",
              lazy = "鈴 ",
              loaded = "●",
              not_loaded = "○",
              plugin = " ",
              runtime = " ",
              source = " ",
              start = "",
              task = "✔ ",
              list = {
                  "●",
                  "➜",
                  "★",
                  "‒",
              },
          },
          -- leave nil, to automatically select a browser depending on your OS.
          -- If you want to use a specific browser, you can define it here
          browser = nil, ---@type string?
          throttle = 20, -- how frequently should the ui process render events
          custom_keys = {
              -- you can define custom key maps here.
              -- To disable one of the defaults, set it to false

              -- open lazygit log
              ["<localleader>l"] = function(plugin)
                require("lazy.util").float_term({ "lazygit", "log" }, {
                    cwd = plugin.dir,
                })
              end,

              -- open a terminal for the plugin dir
              ["<localleader>t"] = function(plugin)
                require("lazy.util").float_term(nil, {
                    cwd = plugin.dir,
                })
              end,
          },
      },
      diff = {
          -- diff command <d> can be one of:
          -- * browser: opens the github compare view. Note that this is always mapped to <K> as well,
          --   so you can have a different command for diff <d>
          -- * git: will run git diff and open a buffer with filetype git
          -- * terminal_git: will open a pseudo terminal with git diff
          -- * diffview.nvim: will open Diffview to show the diff
          cmd = "git",
      },
      checker = {
          -- automatically check for plugin updates
          enabled = false,
          concurrency = nil, ---@type number? set to 1 to check for updates very slowly
          notify = true, -- get a notification when new updates are found
          frequency = 3600, -- check for updates every hour
      },
      change_detection = {
          -- automatically check for config file changes and reload the ui
          enabled = true,
          notify = true, -- get a notification when changes are found
      },
      performance = {
          cache = {
              enabled = true,
              path = vim.fn.stdpath("cache") .. "/lazy/cache",
              -- Once one of the following events triggers, caching will be disabled.
              -- To cache all modules, set this to `{}`, but that is not recommended.
              -- The default is to disable on:
              --  * VimEnter: not useful to cache anything else beyond startup
              --  * BufReadPre: this will be triggered early when opening a file from the command line directly
              disable_events = { "UIEnter", "BufReadPre" },
              ttl = 3600 * 24 * 5, -- keep unused modules for up to 5 days
          },
          reset_packpath = true, -- reset the package path to improve startup time
          rtp = {
              reset = true, -- reset the runtime path to $VIMRUNTIME and your config directory
              ---@type string[]
              paths = {
                  -- vim.g.config_home,
              }, -- add any custom paths here that you want to includes in the rtp
              ---@type string[] list any plugins you want to disable here
              disabled_plugins = {
                  -- "gzip",
                  -- "matchit",
                  -- "matchparen",
                  -- "netrwPlugin",
                  -- "tarPlugin",
                  -- "tohtml",
                  -- "tutor",
                  -- "zipPlugin",
              },
          },
      },
      -- lazy can generate helptags from the headings in markdown readme files,
      -- so :help works even for plugins that don't have vim docs.
      -- when the readme opens with :help it will be correctly displayed as markdown
      readme = {
          root = vim.fn.stdpath("state") .. "/lazy/readme",
          files = { "README.md", "lua/**/README.md" },
          -- only generate markdown helptags for plugins that dont have docs
          skip_if_doc_exists = true,
      },
      state = vim.fn.stdpath("state") .. "/lazy/state.json", -- state info for checker and other things
  }
end

function M.treesitter_config(LazyPlugin, opts)
  if M.no_plugin_installed() then
  else
    require 'nvim-treesitter.configs'.setup {
        -- One of "all", "maintained" (parsers with maintainers), or a list of languages
        -- ensure_installed = "maintained",
        ensure_installed = { "c", "cpp", "bash" },

        -- Install languages synchronously (only applied to `ensure_installed`)
        sync_install = false,

        -- List of parsers to ignore installing
        ignore_install = { "" },

        highlight = {
            -- `false` will disable the whole extension
            enable = true,

            -- list of language that will be disabled
            disable = {},

            -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
            -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
            -- Using this option may slow down your editor, and you may see some duplicate highights.
            -- Instead of true it can also be a list of languages
            additional_vim_regex_highlighting = false,
        },
        incremental_selection = {
            enable = true,
            keymaps = {
                -- init_selection = "gnn",
                -- node_incremental = "grn",
                -- scope_incremental = "grc",
                -- node_decremental = "grm",
            }
        },
        indent = {
            enable = true
        },
        rainbow = {
            enable = true,
            -- disable = { "jsx", "cpp" }, list of languages you want to disable the plugin for
            extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
            max_file_lines = nil, -- Do not enable for files with more than n lines, int
            -- colors = {}, -- table of hex strings
            -- termcolors = {} -- table of colour name strings
        }
    }
  end
end

return M
