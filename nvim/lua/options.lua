-- [[ Setting options ]]
-- See `:help vim.o`

vim.opt.colorcolumn = "80"

vim.o.shiftwidth = 4

vim.o.hlsearch = false
vim.o.hlincsearch = true

vim.wo.number = true
vim.wo.relativenumber = true

vim.o.mouse = 'a'

-- Enable break indent
vim.o.breakindent = true

vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.o.undofile = true

vim.o.ignorecase = true
vim.o.smartcase = true

-- Keep signcolumn on by default
vim.wo.signcolumn = 'yes'

-- Decrease update time
vim.o.updatetime = 250
vim.o.timeoutlen = 300

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'

vim.o.termguicolors = true

-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})


