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

-- multicursor
local mc = require("multicursor-nvim")
mc.setup()
vim.keymap.set({"n", "v"}, "<up>", function() mc.addCursor("k") end)
vim.keymap.set({"n", "v"}, "<down>", function() mc.addCursor("j") end)

-- Add a cursor and jump to the next word under cursor.
vim.keymap.set({"n", "v"}, "<c-n>", function() mc.addCursor("*") end)

-- Jump to the next word under cursor but do not add a cursor.
vim.keymap.set({"n", "v"}, "<c-s>", function() mc.skipCursor("*") end)

-- Rotate the main cursor.
vim.keymap.set({"n", "v"}, "<left>", mc.nextCursor)
vim.keymap.set({"n", "v"}, "<right>", mc.prevCursor)

-- Delete the main cursor.
vim.keymap.set({"n", "v"}, "<leader>x", mc.deleteCursor)

-- Add and remove cursors with control + left click.
vim.keymap.set("n", "<c-leftmouse>", mc.handleMouse)

vim.keymap.set({"n", "v"}, "<c-q>", function()
    if mc.cursorsEnabled() then
        -- Stop other cursors from moving.
        -- This allows you to reposition the main cursor.
        mc.disableCursors()
    else
        mc.addCursor()
    end
end)

vim.keymap.set("n", "<esc>", function()
    if not mc.cursorsEnabled() then
        mc.enableCursors()
    elseif mc.hasCursors() then
        mc.clearCursors()
    else
        -- Default <esc> handler.
    end
end)

-- Align cursor columns.
vim.keymap.set("n", "<leader>a", mc.alignCursors) 

-- Split visual selections by regex.
vim.keymap.set("v", "S", mc.splitCursors)

-- Append/insert for each line of visual selections.
vim.keymap.set("v", "I", mc.insertVisual)
vim.keymap.set("v", "A", mc.appendVisual)

-- match new cursors within visual selections by regex.
vim.keymap.set("v", "M", mc.matchCursors)

-- Rotate visual selection contents.
vim.keymap.set("v", "<leader>t", function() mc.transposeCursors(1) end)
vim.keymap.set("v", "<leader>T", function() mc.transposeCursors(-1) end)

-- Customize how cursors look.
vim.api.nvim_set_hl(0, "MultiCursorCursor", { link = "Cursor" })
vim.api.nvim_set_hl(0, "MultiCursorVisual", { link = "Visual" })
vim.api.nvim_set_hl(0, "MultiCursorDisabledCursor", { link = "Visual" })
vim.api.nvim_set_hl(0, "MultiCursorDisabledVisual", { link = "Visual" })
