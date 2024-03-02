-- Read the docs: https://www.lunarvim.org/docs/configuration
-- Example configs: https://github.com/LunarVim/starter.lvim
-- Video Tutorials: https://www.youtube.com/watch?v=sFA9kX-Ud_c&list=PLhoH5vyxr6QqGu0i7tt_XoVK9v-KvZ3m6
-- Forum: https://www.reddit.com/r/lunarvim/
-- Discord: https://discord.com/invite/Xb9B4Ny

vim.api.nvim_create_autocmd("VimEnter", {
    callback = function()
        vim.cmd("highlight Normal guibg=none")
        vim.cmd("highlight NormalNC guibg=none")
        vim.cmd("hi NonText ctermbg=none guibg=NONE")
  end
})

vim.o.termguicolors = true

lvim.format_on_save = {
  enabled = true,
  pattern = "*.rs,*.go",
  timeout = 1000,
}
lvim.plugins = {
  { 'instant-markdown/vim-instant-markdown' },
  { 'towolf/vim-helm' },
  { 'mrjosh/helm-ls' },
  { 'github/copilot.vim' },
  { 'pearofducks/ansible-vim' },
  -- { 'rhysd/git-messenger.vim' }
  { 'turbio/bracey.vim' }
}

if vim.fn.has('wsl') == 1 then
    vim.g.clipboard = {
        name = 'WslClipboard',
        copy = {
            ['+'] = '/mnt/c/Windows/System32/clip.exe',
            ['*'] = '/mnt/c/Windows/System32/clip.exe',
        },
        paste = {
            ['+'] = '/mnt/c/Windows/System32/WindowsPowerShell/v1.0/powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
            ['*'] = '/mnt/c/Windows/System32/WindowsPowerShell/v1.0/powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
        },
        cache_enabled = 0,
    }
end

experimental = {
  ghost_text = true,
}

vim.g.copilot_no_tab_map = true
vim.g.copilot_no_tab_map = true
vim.g.copilot_assume_mapped = true
vim.g.copilot_tab_fallback = ""
local cmp = require "cmp"

lvim.builtin.cmp.mapping["<Tab>"] = function(fallback)
  if cmp.visible() then
    cmp.select_next_item()
  else
    local copilot_keys = vim.fn["copilot#Accept"]()
    if copilot_keys ~= "" then
      vim.api.nvim_feedkeys(copilot_keys, "i", true)
    else
      fallback()
    end
  end
end

vim.api.nvim_create_autocmd({'BufNewFile', 'BufRead'} , {
    pattern = {'*/templates/*.yaml', '*/templates/*.tpl'},
    callback = function()
          vim.opt_local.filetype = 'helm'
    end
})

vim.opt.relativenumber = true

lvim.builtin.which_key.mappings["t"] = {
  name = "+Terminal",
  f = { "<cmd>ToggleTerm<cr>", "Floating terminal" },
  v = { "<cmd>2ToggleTerm size=30 direction=vertical<cr>", "Split vertical" },
  h = { "<cmd>2ToggleTerm size=30 direction=horizontal<cr>", "Split horizontal" },
}

-- fix not bright colors in diff mode
lvim.autocommands = {
    {
	{ "ColorScheme" },
	{
	    pattern = "*",
	    callback = function()
	        vim.api.nvim_set_hl(0, "DiffAdd", { bg = "#1c444a", underline = false, bold = false })
	        vim.api.nvim_set_hl(0, "DiffDelete", { bg = "#801919", underline = false, bold = false })
	        vim.api.nvim_set_hl(0, "DiffChange", { bg = "#1d2739", underline = false, bold = false })
	        vim.api.nvim_set_hl(0, "DiffText", { bg = "#3c4e77", underline = false, bold = false })
	    end,
	},
    },
}

require'lspconfig'.ansiblels.setup{
  on_attach = function(client, bufnr)
  end,
  flags = {
    debounce_text_changes = 150,
  },
  filetypes = { "yaml.ansible" }, 
}

vim.api.nvim_create_autocmd("FileType", {
    pattern = "yaml.ansible",
    callback = function()
        vim.api.nvim_buf_set_keymap(0, 'i', '<Tab>', 'copilot#Accept("<CR>")', { expr = true, silent = true })
    end
})
-- require("null-ls").setup({
--   sources = {
--     require("null-ls").builtins.diagnostics.ansiblelint,  
--   },
-- })

-- vim.diagnostic.config({
--   virtual_text = true,
--   signs = true,
--   underline = true,
--   update_in_insert = false,
--   severity_sort = true,
-- })

-- Disabling arrow keys in Normal mode
vim.api.nvim_set_keymap('n', '<Left>', ':echoe "Use h"<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<Right>', ':echoe "Use l"<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<Up>', ':echoe "Use k"<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<Down>', ':echoe "Use j"<CR>', {noremap = true, silent = true})
-- Double Leader Tap to Enter Insert Mode
vim.api.nvim_create_user_command('BraceyXhtml', function()
    vim.bo.filetype = 'html' 
    vim.cmd('Bracey') 
end, {})

