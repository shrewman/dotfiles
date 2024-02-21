-- [[ Configure LSP ]]
local lsp_zero = require('lsp-zero')

local nmap = function(keys, func, desc)
  if desc then
    desc = 'LSP: ' .. desc
  end

  vim.keymap.set('n', keys, func, { desc = desc })
end

-- (client, bufnr)
local function on_attach(_, _)
  nmap("gd", function() vim.lsp.buf.definition() end, "[G]o to [D]efinition")
  -- nmap("gD", function() vim.lsp.buf.declaration() end, "[G]o to [D]eclaration")
  nmap("gr", function() vim.lsp.buf.references() end, "[G]o to [R]eferences")
  nmap("K", function() vim.lsp.buf.hover() end, "Hover Documentation")
  nmap("<leader>r", function() vim.lsp.buf.rename() end, "[R]ename")
  nmap('<leader>f', function() vim.lsp.buf.format({ async = true }) end, "[F]ormat")

  nmap('<leader>ca', function() vim.lsp.buf.code_action() end, "[C]ode [A]ctions")

  nmap("[d", function() vim.diagnostic.goto_next() end, "Next [D]efinition")
  nmap("]d", function() vim.diagnostic.goto_prev() end, "Prev [D]evifinition")

  nmap(
    "<leader>e", function() vim.diagnostic.open_float() end,
    'Open floating diagnostic message'
  )

vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })
  nmap('<leader>f', function() vim.lsp.buf.format({ async = true }) end, '[F]ormat file')
end

lsp_zero.on_attach(on_attach)



-- mason-lspconfig requires that these setup functions are called in this order
-- before setting up the servers.
require('mason').setup({})
require('mason-lspconfig').setup({
  ensure_installed = { 'tsserver' },
  handlers = {
    lsp_zero.default_setup,
    lua_ls = function()
      local lua_opts = lsp_zero.nvim_lua_ls()
      require('lspconfig').lua_ls.setup(lua_opts)
    end,
  }
})


-- Enable the following language servers
--  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
--
--  Add any additional override configuration in the following tables. They will be passed to
--  the `settings` field of the server config. You must look up that documentation yourself.
--
--  If you want to override the default filetypes that your language server will attach to you can
--  define the property 'filetypes' to the map in question.
local servers = {
  -- clangd = {},
  -- gopls = {},
  -- pyright = {},
  -- rust_analyzer = {},
  tsserver = {},
  -- html = { filetypes = { 'html', 'twig', 'hbs'} },

  lua_ls = {
    Lua = {
      workspace = { checkThirdParty = false },
      telemetry = { enable = false },
      diagnostics = {
        globals = { 'vim' }
      },
    },
  },
}

-- Setup neovim lua configuration
-- require('neodev').setup()

-- nvim-cmp supports additional completion capabilities, so broadcast that to servers
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

-- Ensure the servers above are installed
local mason_lspconfig = require 'mason-lspconfig'

mason_lspconfig.setup {
  ensure_installed = vim.tbl_keys(servers),
}

mason_lspconfig.setup_handlers {
  function(server_name)
    require('lspconfig')[server_name].setup {
      capabilities = capabilities,
      on_attach = on_attach,
      settings = servers[server_name],
      filetypes = (servers[server_name] or {}).filetypes,
    }
  end,
}

-- document existing key chains
require('which-key').register {
  ['<leader>c'] = { name = '[C]ode', _ = 'which_key_ignore' },
  ['<leader>d'] = { name = '[D]ocument', _ = 'which_key_ignore' },
  ['<leader>g'] = { name = '[G]it', _ = 'which_key_ignore' },
  ['<leader>h'] = { name = 'Git [H]unk', _ = 'which_key_ignore' },
  ['<leader>r'] = { name = '[R]ename', _ = 'which_key_ignore' },
  ['<leader>s'] = { name = '[S]earch', _ = 'which_key_ignore' },
  ['<leader>t'] = { name = '[T]oggle', _ = 'which_key_ignore' },
  ['<leader>w'] = { name = '[W]orkspace', _ = 'which_key_ignore' },
  ['<leader>p'] = { name = '[P]roject', _ = 'which_key_ignore' },
}
-- register which-key VISUAL mode
-- required for visual <leader>hs (hunk stage) to work
require('which-key').register({
  ['<leader>'] = { name = 'VISUAL <leader>' },
  ['<leader>h'] = { 'Git [H]unk' },
}, { mode = 'v' })
