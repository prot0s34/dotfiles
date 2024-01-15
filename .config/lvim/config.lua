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
