-- Read the docs: https://www.lunarvim.org/docs/configuration
-- Example configs: https://github.com/LunarVim/starter.lvim
-- Video Tutorials: https://www.youtube.com/watch?v=sFA9kX-Ud_c&list=PLhoH5vyxr6QqGu0i7tt_XoVK9v-KvZ3m6
-- Forum: https://www.reddit.com/r/lunarvim/
-- Discord: https://discord.com/invite/Xb9B4Ny
lvim.format_on_save = {
  enabled = true,
  pattern = "*.rs,*.go",
  timeout = 1000,
}
lvim.plugins = {
  { 'instant-markdown/vim-instant-markdown' },
  { 'towolf/vim-helm' },
  { 'mrjosh/helm-ls' },
  { 'github/copilot.vim'}
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
