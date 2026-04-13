local keymap = vim.keymap

-- Telescope keybindings
local builtin = require("telescope.builtin")

keymap.set("n", "<leader>ff", builtin.find_files, {})
keymap.set("n", "<leader>fw", builtin.live_grep, {})
keymap.set("n", "<leader>fW", builtin.grep_string, {})
keymap.set("n", "<leader>fo", builtin.oldfiles, {})
keymap.set("n", "<leader>fF", function()
	builtin.find_files({ hidden = true })
end, { noremap = true, silent = true })

-- Neotree keybindings
keymap.set("n", "<leader>e", "<Cmd>Neotree toggle<CR>", {})

-- Always show left gutter
vim.o.signcolumn = "yes"

-- Show line numbers and set line numbers to relative
vim.wo.number = true
vim.wo.relativenumber = true

-- Set tabs
vim.o.softtabstop = 2
vim.o.shiftwidth = 2
vim.o.expandtab = false

-- No wrap
vim.o.textwidth = 0
vim.o.wrapmargin = 0
vim.o.wrap = false
