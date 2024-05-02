-- PACKER plugin manager config stuff
vim.api.nvim_command('set number')

local vim = vim
local Plug = vim.fn['plug#']

vim.call('plug#begin')
Plug 'MunifTanjim/nui.nvim'
vim.call('plug#end')

-----------


local Menu = require("nui.menu")
local event = require("nui.utils.autocmd").event




require('packer').startup(function(use)
	-- packer can manage itself
	use 'wbthomason/packer.nvim'
	-- manage mason
	use {
	    'williamboman/mason.nvim',
            run=":MasonUpdate"
	}
	-- alpha 
	use {
		'goolord/alpha-nvim',
		requires = {'nvim-tree/nvim-web-devicons' },
		config = function()
			require'alpha'.setup(require'alpha.themes.startify'.config)
	end
	}
	-- nvim-cmp
	use 'neovim/nvim-lspconfig'
	use 'hrsh7th/cmp-nvim-lsp'
	use 'hrsh7th/cmp-buffer'
	use 'hrsh7th/cmp-path'
	use 'hrsh7th/cmp-cmdline'
	use 'hrsh7th/nvim-cmp'

	-- git-gutter
	use 'airblade/vim-gitgutter'
	
	-- lualine
	use {
	  'nvim-lualine/lualine.nvim',
	  requires = { 'nvim-tree/nvim-web-devicons', opt = true }
	}

	-- nvim-visual-multi
		use 'mg979/vim-visual-multi'
	-- nvim-tree.lua 
		use 'nvim-tree/nvim-tree.lua'
	-- Tlescope
		use {
		  'nvim-telescope/telescope.nvim', tag = '0.1.6',
-- or                            , branch = '0.1.x',
		  requires = { {'nvim-lua/plenary.nvim'} }
	}
	-- FZF
--		use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build' }
	use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }

	use {
	  "loctvl842/monokai-pro.nvim",
	  config = function()
	    require("monokai-pro").setup()
	  end
	}
end)


require('telescope').setup{
  defaults = {
    mappings = {
      i = {
        ["<C-h>"] = "which_key"
      }
    }
  },
  extensions = {
  }
}
require("monokai-pro").setup({
  transparent_background = false,
  terminal_colors = true,
  devicons = true, -- highlight the icons of `nvim-web-devicons`
  styles = {
    comment = { italic = true },
    keyword = { italic = true }, -- any other keyword
    type = { italic = true }, -- (preferred) int, long, char, etc
    storageclass = { italic = true }, -- static, register, volatile, etc
    structure = { italic = true }, -- struct, union, enum, etc
    parameter = { italic = true }, -- parameter pass in function
    annotation = { italic = true },
    tag_attribute = { italic = true }, -- attribute of tag in reactjs
  },
  filter = "pro", -- classic | octagon | pro | machine | ristretto | spectrum
  -- Enable this will disable filter option
  day_night = {
    enable = false, -- turn off by default
    day_filter = "pro", -- classic | octagon | pro | machine | ristretto | spectrum
    night_filter = "spectrum", -- classic | octagon | pro | machine | ristretto | spectrum
  },
  inc_search = "background", -- underline | background
  background_clear = {
    -- "float_win",
    "toggleterm",
    "telescope",
    -- "which-key",
    "renamer",
    "notify",
    -- "nvim-tree",
    -- "neo-tree",
    -- "bufferline", -- better used if background of `neo-tree` or `nvim-tree` is cleared
  },-- "float_win", "toggleterm", "telescope", "which-key", "renamer", "neo-tree", "nvim-tree", "bufferline"
  plugins = {
    bufferline = {
      underline_selected = false,
      underline_visible = false,
    },
    indent_blankline = {
      context_highlight = "default", -- default | pro
      context_start_underline = false,
    },
  },
  ---@param c Colorscheme
  override = function(c) end,
  ---@param cs Colorscheme
  ---@param p ColorschemeOptions
  ---@param Config MonokaiProOptions
  ---@param hp Helper
})
require('telescope').setup {
  extensions = {
    fzf = {
      fuzzy = true,                    -- false will only do exact matching
      override_generic_sorter = true,  -- override the generic sorter
      override_file_sorter = true,     -- override the file sorter
      case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
                                      -- the default case_mode is "smart_case"
    }
  },
    defaults = {
      borderchars = { "█", " ", "▀", "█", "█", " ", " ", "▀" },
    }
}
vim.cmd([[colorscheme monokai-pro]])
require("nvim-tree").setup()

require'lspconfig'.pyright.setup{}

require("mason").setup({
  ui = {
    icons = {
      package_installed = "✓",
      package_pending = "➜",
      package_uninstalled = "✗",
    },
  },
})

-- Set up nvim-cmp.
  local cmp = require'cmp'

  cmp.setup({
    snippet = {
      -- REQUIRED - you must specify a snippet engine
      expand = function(args)
        vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
        -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
        -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
        -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
        -- vim.snippet.expand(args.body) -- For native neovim snippets (Neovim v0.10+)
      end,
    },
    completion = {
	    border = "rounded",
    },
    window = {
	    border = "rounded",
      -- completion = cmp.config.window.bordered(),
      -- documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
      ['<C-b>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.abort(),
      ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    }),
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      { name = 'vsnip' }, -- For vsnip users.
      -- { name = 'luasnip' }, -- For luasnip users.
      -- { name = 'ultisnips' }, -- For ultisnips users.
      -- { name = 'snippy' }, -- For snippy users.
    }, {
      { name = 'buffer' },
    })
  })

  -- Set configuration for specific filetype.
  cmp.setup.filetype('gitcommit', {
    sources = cmp.config.sources({
      { name = 'git' }, -- You can specify the `git` source if [you were installed it](https://github.com/petertriho/cmp-git).
    }, {
      { name = 'buffer' },
    })
  })

  -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline({ '/', '?' }, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
      { name = 'buffer' }
    }
  })

  -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
      { name = 'path' }
    }, {
      { name = 'cmdline' }
    }),
    matching = { disallow_symbol_nonprefix_matching = false }
  })

  -- Set up lspconfig.
  local capabilities = require('cmp_nvim_lsp').default_capabilities()
  -- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.
  require('lspconfig')['<YOUR_LSP_SERVER>'].setup {
    capabilities = capabilities
  }

   require('lualine').setup {
  options = {
    -- ...
    theme = 'monokai-pro'
    -- ...
  }
}
vim.cmd([[colorscheme monokai-pro]])


