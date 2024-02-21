--[[

If you don't know anything about Lua, I recommend taking some time to read through
a guide. One possible example:
- https://learnxinyminutes.com/docs/lua/

And then you can explore or search through `:help lua-guide`
- https://neovim.io/doc/user/lua-guide.html

Kickstart Guide:

I have left several `:help X` comments throughout the init.lua
You should run that command and read that help section for more information.

--]]

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

require 'lazy-bootstrap'
require 'lazy-plugins'

require 'options'
require 'keymaps'

require 'telescope-setup'
require 'harpoon-setup'
require 'treesitter-setup'

require 'lsp-setup'
require 'cmp-setup'


