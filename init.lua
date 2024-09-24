vim.opt.number = true
vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4

vim.keymap.set('i', 'jj', '<Esc>', {})

require('plugins')

-- LSP Configuration
require("mason").setup()
vim.api.nvim_set_hl(0, "MasonNormal", { bg = "#000000" })
require("mason-lspconfig").setup()

require("mason-lspconfig").setup_handlers {
    function (server_name) -- default handler (optional)
        require("lspconfig")[server_name].setup {}
    end,
}
-- End LSP Configuration

-- telescope Configuration
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
-- End telescope Configuration

-- NVIM Tree Configuration
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.opt.termguicolors = true
require("nvim-tree").setup({
    view = {
        width = 50,
    },
})
vim.keymap.set('n', '<C-n>', ':NvimTreeToggle<CR>', {})
-- End NVIM Tree Configuration
