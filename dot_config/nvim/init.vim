"      __
"     /  -,
"    ||   )             ;     '
"   ~||---)  _-_   /'\\ \\/\ \\ \\/\\/\\
"   ~||---, || \\ || || || | || || || ||
"   ~||  /  ||/   || || || | || || || ||
"    |, /   \\,/  \\,/  \\/  \\ \\ \\ \\
"  -_-  --~
"
" from the fabulous <https://git.lain.faith/sorceress/dotfiles>

" import .vimrc
set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
source ~/.vimrc

" colors
highlight Pmenu guibg=black

" refresh time
set updatetime=500

" CtrlSF
let g:ctrlsf_default_root = "project"

" Lightline

let g:lightline.component_function = {
\	 'gitbranch': 'FugitiveHead'
\ }

" lightline modules
let g:lightline.active = {
\	'left' : [
\		['mode', 'paste'],
\		['gitbranch', 'readonly', 'filename', 'modified']
\	],
\	'right': [
\		['lsp_errors', 'lsp_warnings'],
\		['lineinfo'],
\		['percent'],
\		['fileformat', 'fileencoding', 'filetype']
\	]
\}

" lightline symbols
let g:lightline#lsp#indicator_errors = "\uf05e"
let g:lightline#lsp#indicator_info = "\uf129"
let g:lightline#lsp#indicator_ok = "\uf00c"
let g:lightline#lsp#indicator_warnings = "\uf071"

" register compoments:
call lightline#lsp#register()

lua << EOF

-- cursor animations
require('specs').setup{
    show_jumps  = true,
    min_jump = 30,
    popup = {
        delay_ms = 100, -- delay before popup displays
        inc_ms = 20, -- time increments used for fade/resize effects
        blend = 10, -- starting blend, between 0-100 (fully transparent), see :h winblend
        width = 10,
        winhl = "PMenu",
        fader = require('specs').exp_fader,
        resizer = require('specs').shrink_resizer
    },
    ignore_buftypes = {
        nofile = true,
    },
}

-- lsp config

require("mason").setup()
require("mason-lspconfig").setup()
local lsp_installer = require("mason-lspconfig")
local nvim_lsp = require 'lspconfig'
local cmp = require'cmp'


require("mason-lspconfig").setup_handlers {
    -- The first entry (without a key) will be the default handler
    -- and will be called for each installed server that doesn't have
    -- a dedicated handler.
    function (server_name) -- default handler (optional)
        require("lspconfig")[server_name].setup {}
    end,
    -- Next, you can provide a dedicated handler for specific servers.
    -- For example, a handler override for the rust_analyzer:
    ["rust_analyzer"] = function ()
        require("rust-tools").setup {}
    end
}

local lsp_formatting = function(bufnr)
    vim.lsp.buf.format({
        filter = function(client)
			if vim.bo.filetype == "rust" then
				return client.name ~= "null-ls"
			else
				return true
			end
        end,
        bufnr = bufnr,
    })
end

local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
    if client.supports_method("textDocument/formatting") then
        vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
        vim.api.nvim_create_autocmd("BufWritePre", {
			group = augroup,
            buffer = bufnr,
            callback = function()
                lsp_formatting(bufnr)
            end,
        })
	end

	-- Mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local bufopts = { noremap=true, silent=true, buffer=bufnr }
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
    vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
    vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
    vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
    vim.keymap.set('n', '<space>f', vim.lsp.buf.formatting, bufopts)
end

local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())
local servers = { 'emmet_ls', 'cssls' }
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup {
	on_attach = on_attach,
    capabilities = capabilities,
  }
end

nvim_lsp['rust_analyzer'].setup {
	on_attach = on_attach,
	capabilities = capabilities,
	settings = {
		["rust-analyzer"] = {
			rustfmt = {
				extraArgs = {"+nightly"},
			},
			checkOnSave = {
				command = "clippy"
			}
		},
	}
}

local null_ls = require("null-ls")
null_ls.setup({
	on_attach = on_attach,
    sources = {
		null_ls.builtins.completion.spell,
		null_ls.builtins.formatting.fixjson,
		null_ls.builtins.formatting.nginx_beautifier,
		null_ls.builtins.formatting.prettier,
		null_ls.builtins.formatting.trim_newlines,
		null_ls.builtins.formatting.trim_whitespace,
        null_ls.builtins.code_actions.eslint,
        null_ls.builtins.diagnostics.fish,
    },
})

vim.diagnostic.config({
  virtual_text = {
    prefix = ''
  },
  signs = false
})

-- complations
cmp.setup({
    snippet = {
	expand = function(args)
        vim.fn["vsnip#anonymous"](args.body)
		end,
    },
    mapping = cmp.mapping.preset.insert({
      ['<C-b>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.abort(),
      ['<CR>'] = cmp.mapping.confirm({ select = true }),
    }),
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      { name = 'vsnip' },
	  { name = 'calc' },
    }, {
      { name = 'buffer' },
    })
})


require("todo-comments").setup {}

-- loading status
require"fidget".setup{
	text = {
		spinner = "star"
	}
}

require'nvim-web-devicons'.setup {
}

EOF
