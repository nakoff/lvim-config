-- Read the docs: https://www.lunarvim.org/docs/configuration
-- Video Tutorials: https://www.youtube.com/watch?v=sFA9kX-Ud_c&list=PLhoH5vyxr6QqGu0i7tt_XoVK9v-KvZ3m6
-- Forum: https://www.reddit.com/r/lunarvim/
-- Discord: https://discord.com/invite/Xb9B4Ny

lvim.builtin.lualine.sections.lualine_x = {
    {
        'vim.fn["codeium#GetStatusString"]()',
        fmt = function(str) return "sugg " .. str:lower():match("^%s*(.-)%s*$") end
    },
    'encoding', 'fileformat', 'filetype'
}

local linters = require "lvim.lsp.null-ls.linters"
linters.setup {
  { command = "eslint", filetypes = { "typescript", "typescriptreact" } }
}


-- lvim.colorscheme = 'onedarker'
lvim.colorscheme = 'vscode'

lvim.keys.normal_mode['<Tab>'] = ':BufferLinePick<CR>'
lvim.keys.normal_mode[']b'] = ':BufferLineCycleNext<CR>'
lvim.keys.normal_mode['[b'] = ':BufferLineCyclePrev<CR>'
lvim.keys.insert_mode['<C-h>'] = '';
lvim.keys.insert_mode['<C-l>'] = '';
lvim.keys.insert_mode['<C-i>'] = '';

lvim.keys.insert_mode['jj'] = '<ESC>';


lvim.keys.insert_mode['<C-g>'] = function() vim.fn["codeium#Chat"](); end
lvim.keys.normal_mode['<C-g>'] = function() vim.fn["codeium#Chat"](); end
lvim.keys.visual_mode['<C-g>'] = function() vim.fn["codeium#Chat"](); end
lvim.keys.normal_mode['<C-e>'] = ':CodeiumToggle<CR>';
vim.g.codeium_no_map_tab = 1;

vim.opt.shiftwidth = 4;
vim.opt.tabstop = 4;

vim.opt.foldmethod = "expr";
vim.opt.foldexpr = "nvim_treesitter#foldexpr()";
vim.opt.foldenable = false;


lvim.builtin.nvimtree.setup.filters.custom = {
    ".meta"
}

vim.g.clipboard = {
    name = 'xclip', -- Использовать xclip в качестве буфера обмена
    copy = {
        ["+"] = "xclip -i -selection clipboard",
        ["*"] = "xclip -i -selection clipboard",
    },
    paste = {
        ["+"] = "xclip -o -selection clipboard",
        ["*"] = "xclip -o -selection clipboard",
    },
    cache_enabled = 0, -- Отключаем кэширование
}

require('hop').setup()
local hop = require('hop')
local directions = require('hop.hint').HintDirection
vim.keymap.set('', 's', function()
  hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = false })
end, {remap=true})
vim.keymap.set('', 'S', function()
  hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = false })
end, {remap=true})

vim.keymap.set('', 't', function()
  hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = true, hint_offset = -1 })
end, {remap=true})
vim.keymap.set('', 'T', function()
  hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = true, hint_offset = 1 })
end, {remap=true})

-- require('leap').create_default_mappings()

lvim.plugins = {
    { 'Mofiqul/vscode.nvim' },
    -- { 'norcalli/nvim-colorizer.lua' },
    -- { 'tomasiser/vim-code-dark' },
    { 'phaazon/hop.nvim' },
    {'lewis6991/satellite.nvim'},
    {'dnlhc/glance.nvim'},
    {
        'Exafunction/codeium.vim',
        event = 'BufEnter',
        config = function()
            vim.keymap.set('i', '<C-f>', function() return vim.fn['codeium#Accept']() end, { expr = true, silent = true })
            vim.keymap.set('i', '<C-l>', function() return vim.fn['codeium#CycleCompletions'](1) end,
                { expr = true, silent = true })
            vim.keymap.set('i', '<C-h>', function() return vim.fn['codeium#CycleCompletions'](-1) end,
                { expr = true, silent = true })
            vim.keymap.set('i', '<C-x>', function() return vim.fn['codeium#Clear']() end, { expr = true, silent = true })
        end
    },
}
