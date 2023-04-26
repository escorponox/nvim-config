vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- inoremap jj <Esc>
vim.keymap.set('i', 'jj', '<Esc>')

--nnoremap = ,
vim.keymap.set('n', '=', ',')

-- visual movement
vim.keymap.set('n', 'j', 'gj')
vim.keymap.set('n', 'k', 'gk')

-- find and replace
vim.keymap.set('n', ',rr', ':%s//cg<Left><Left><Left>')
vim.keymap.set('n', ',rg', ':%s//g<Left><Left>')
-- find and replace word
vim.keymap.set("n", ",rw", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

-- fuzzy find
vim.keymap.set('n', ',fm', ':Mru<CR>')
vim.keymap.set('n', ',fe', ':Mfu<CR>')

-- close buffers
vim.keymap.set('n', ',d', ':bd<CR>')
vim.keymap.set('n', ',D', ':bufdo bd<CR>')

-- split
vim.keymap.set('n', ',v', ':vs<CR>')
vim.keymap.set('n', ',g', ':sp<CR>')

-- show invisible chars
vim.keymap.set('n', ',sh', ':set list!<CR>')

-- no highlights
vim.keymap.set('n', ',y', ':noh<CR>')
-- select all
vim.keymap.set('n', ',sa', 'ggVG')
-- quit/save all
vim.keymap.set('n', ',q', ':qa<CR>')
vim.keymap.set('n', ',w', ':wall<CR>')

-- these only get hit by accident
vim.keymap.set('n', 'Q', '<Nop>')
vim.keymap.set('n', 'q:', '<Nop>')
-- 0 is easier. ^ is more useful.
vim.keymap.set('n', '0', '^')
vim.keymap.set('n', '^', '0')

-- buffers
vim.keymap.set('n', ',b', ':b#<CR>')
vim.keymap.set('n', ',p', ':bp<CR>')
vim.keymap.set('n', ',n', ':bn<CR>')

-- windows
vim.keymap.set('n', ',z', [[<C-W>|]])
vim.keymap.set('n', ',h', '<C-W>h')
vim.keymap.set('n', ',l', '<C-W>l')
vim.keymap.set('n', ',j', '<C-W>j')
vim.keymap.set('n', ',k', '<C-W>k')
vim.keymap.set('n', ',=', '<C-W>=')
vim.keymap.set('n', ',x', '<C-W>x')
vim.keymap.set('n', ',c', ':close<CR>')

-- tabs
vim.keymap.set('n', ',tg', ':tabnew<CR>')
vim.keymap.set('n', ',tt', ':tabnext<CR>')
vim.keymap.set('n', ',tr', ':tabclose<CR>')
vim.keymap.set('n', ',tp', ':tabprevious<CR>')

-- quickfix
vim.keymap.set('n', '<C-J>', ':cnext<CR>')
vim.keymap.set('n', '<C-K>', ':cprev<CR>')

-- git
vim.keymap.set('n', 'gb', ':Git blame<CR>')

-- copilot
vim.keymap.set('i', '<C-d>', '<Plug>(copilot-next)', { silent = true })
vim.keymap.set('i', '<C-u>', '<Plug>(copilot-previous)', { silent = true })

-- greatest remap ever
vim.keymap.set('x', '<leader>p', [["_dP]])

-- commands
vim.keymap.set('n', ',aa', ':DuplicateLine<space>')
vim.keymap.set('n', ',as', ':CopyLine<space>')

-- move selected line up/down
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- keep cursor in place when joining lines
vim.keymap.set("n", "J", "mzJ`z")

-- undotree
vim.keymap.set('n', '<leader>u', ':UndotreeToggle<CR>')

-- edit/save .vimrc
vim.keymap.set('n', ',sc', ':e ~/.config/nvim/init.lua<CR>')
vim.keymap.set('n', ',sv', ':so ~/.config/nvim/init.lua<CR>')
