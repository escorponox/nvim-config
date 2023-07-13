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

-- windows resize
vim.keymap.set('n', ',+', ':vertical resize +10<CR>', { desc = 'vert resize +10' })
vim.keymap.set('n', ',-', ':vertical resize -10<CR>', { desc = 'vert resize -10' })


-- tabs
vim.keymap.set('n', ',tg', ':tabnew<CR>')
vim.keymap.set('n', ',tt', ':tabnext<CR>')
vim.keymap.set('n', ',tr', ':tabclose<CR>')
vim.keymap.set('n', ',tp', ':tabprevious<CR>')

-- quickfix
vim.keymap.set('n', ',fj', ':cnext<CR>', { desc = 'quickfix next' })
vim.keymap.set('n', ',fk', ':cprev<CR>', { desc = 'quickfix prev' })

-- greatest remap ever
vim.keymap.set('x', '<leader>p', [["_dP]], { desc = 'persistent paste' })

-- commands
vim.keymap.set('n', ',aa', ':DuplicateLine<space>', { desc = 'duplicate line' })
vim.keymap.set('n', ',as', ':CopyLine<space>', { desc = 'copy line' })

-- move selected line up/down
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = 'move line down' })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = 'move line up' })

-- keep cursor in place when joining lines
vim.keymap.set("n", "J", "mzJ`z", { desc = 'join lines keeping cursor in place' })

-- these keymaps are for plugins not configured in lazy

-- copilot
vim.keymap.set('i', '<C-d>', '<Plug>(copilot-next)', { silent = true, desc = 'copilot next' })
vim.keymap.set('i', '<C-u>', '<Plug>(copilot-previous)', { silent = true, desc = 'copilot previous' })
