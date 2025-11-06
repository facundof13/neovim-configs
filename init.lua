

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Search settings
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Setup lazy.nvim
require("lazy").setup({
  spec = {
	  { import = "plugins" },
      { "https://github.com/justinmk/vim-sneak" }
  },
  -- Configure any other settings here. See the documentation for more details.
  -- colorscheme that will be used when installing plugins.
  install = { colorscheme = { "habamax" } },
  -- automatically check for plugin updates
  checker = { enabled = true },
})

-- Remap yanking to use the system clipboard
vim.keymap.set('n', 'y', '"+y')
vim.keymap.set('n', 'yy', '"+yy')
vim.keymap.set('n', 'p', '"+p')
vim.keymap.set('v', 'y', '"+y')


vim.keymap.set('n','<C-d>', '<C-d>zz', { noremap = true, silent = true})
vim.keymap.set('n','<C-u>', '<C-u>zz', { noremap = true, silent = true})


-- highlight on yank
vim.api.nvim_create_autocmd('TextYankPost', {
    group = vim.api.nvim_create_augroup('highlight_yank', {}),
    desc = "Highlight selection on yank",
    pattern = "*",
    callback = function()
        vim.highlight.on_yank { higroup = 'IncSearch', timeout = 250}
    end,
})

vim.opt.clipboard:append("unnamedplus")
