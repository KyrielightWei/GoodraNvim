return {
  -- {
  --   "j-hui/fidget.nvim",
  --   name = "fidget",
  --   config = true,
  -- },
  { "onsails/lspkind.nvim",
    name = "lspkind",
    opts = {
      -- DEPRECATED (use mode instead): enables text annotations
      --
      -- default: true
      -- with_text = true,

      -- defines how annotations are shown
      -- default: symbol
      -- options: 'text', 'text_symbol', 'symbol_text', 'symbol'
      mode = 'symbol_text',

      -- default symbol map
      -- can be either 'default' (requires nerd-fonts font) or
      -- 'codicons' for codicon preset (requires vscode-codicons font)
      --
      -- default: 'default'
      preset = 'codicons',

      -- override preset symbols
      --
      -- default: {}
      symbol_map = {
        Text = "",
        Method = "",
        Function = "",
        Constructor = "",
        Field = "ﰠ",
        Variable = "",
        Class = "ﴯ",
        Interface = "",
        Module = "",
        Property = "ﰠ",
        Unit = "塞",
        Value = "",
        Enum = "",
        Keyword = "",
        Snippet = "",
        Color = "",
        File = "",
        Reference = "",
        Folder = "",
        EnumMember = "",
        Constant = "",
        Struct = "פּ",
        Event = "",
        Operator = "",
        TypeParameter = ""
      },
    },
    config = function(LazyPlugin, opts)
      require("lspkind").init(opts)
    end
  },
  {
    "L3MON4D3/LuaSnip",
    -- follow latest release.
    version = "<CurrentMajor>.*",
    -- install jsregexp (optional!).
    build = "make install_jsregexp"
  },
  "hrsh7th/cmp-nvim-lsp",
  "hrsh7th/cmp-buffer",
  "hrsh7th/cmp-path",
  "hrsh7th/cmp-cmdline",
  "hrsh7th/cmp-nvim-lua",
  "ray-x/cmp-treesitter",
  "hrsh7th/cmp-nvim-lsp-document-symbol",
  "hrsh7th/cmp-nvim-lsp-signature-help",
  { "hrsh7th/nvim-cmp",
    dependencies = { "onsails/lspkind.nvim" },
    opts = require("plugins.lsp.config").cmp_opt(),
    config = require("plugins.lsp.config").cmp_config(LazyPlugin, opts)
  },

  { "neovim/nvim-lspconfig"
    ,
    event = "BufReadPre",
    dependencies = {
      -- {
      "hrsh7th/cmp-nvim-lsp",
      -- cond = function()
      --   return require("lazyvim.util").has("nvim-cmp")
      -- end,
      -- },
    },
    -- opts = {
    --   require("plugins.lsp.config").lspconfig_opt()
    -- },
    config = require("plugins.lsp.config").lspconfig_config(LazyPlugin, opts)
  },

  {
    "SmiteshP/nvim-navic",
    lazy = true,
    -- init = function()
    -- end,
    opts = function()
      return {
        separator = " ",
        highlight = true,
        depth_limit = 5,
        icons = {
          File          = " ",
          Module        = " ",
          Namespace     = " ",
          Package       = " ",
          Class         = " ",
          Method        = " ",
          Property      = " ",
          Field         = " ",
          Constructor   = " ",
          Enum          = "練",
          Interface     = "練",
          Function      = " ",
          Variable      = " ",
          Constant      = " ",
          String        = " ",
          Number        = " ",
          Boolean       = "◩ ",
          Array         = " ",
          Object        = " ",
          Key           = " ",
          Null          = "ﳠ ",
          EnumMember    = " ",
          Struct        = " ",
          Event         = " ",
          Operator      = " ",
          TypeParameter = " ",
        },
      }
    end
  },
}
