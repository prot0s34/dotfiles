lvim.format_on_save = {
  enabled = true,
  pattern = "*.rs,*.go,*.tf",
  -- pattern = "*.rs,*.go",
  timeout = 1000,
}
lvim.plugins = {
  { 'instant-markdown/vim-instant-markdown' },
  { 'towolf/vim-helm' },
  { 'mrjosh/helm-ls' },
  { 'github/copilot.vim' },
  { 'pearofducks/ansible-vim' },
  -- { 'rhysd/git-messenger.vim' }
  -- { 'hashivim/vim-terraform' },
  { 'f-person/git-blame.nvim' },
  -- { 'xiyaowong/transparent.nvim' },
  { 'ellisonleao/gruvbox.nvim' },
  {
      "ThePrimeagen/harpoon",
      branch = "harpoon2",
      dependencies = { "nvim-lua/plenary.nvim" }
  },
  { 'turbio/bracey.vim' },
  { "jose-elias-alvarez/null-ls.nvim" }
}

local null_ls = require("null-ls")

null_ls.setup({
  sources = {
    null_ls.builtins.formatting.terraform_fmt,
  },
})


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

vim.api.nvim_create_autocmd({'BufNewFile', 'BufRead'}, {
    pattern = {'*/templates/*.yaml', '*/templates/*.tpl', '*/values-*.yaml'},
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
-- lvim.autocommands = {
--     {
-- 	{ "ColorScheme" },
-- 	{
-- 	    pattern = "*",
-- 	    callback = function()
-- 	        vim.api.nvim_set_hl(0, "DiffAdd", { bg = "#1c444a", underline = false, bold = false })
-- 	        vim.api.nvim_set_hl(0, "DiffDelete", { bg = "#801919", underline = false, bold = false })
-- 	        vim.api.nvim_set_hl(0, "DiffChange", { bg = "#1d2739", underline = false, bold = false })
-- 	        vim.api.nvim_set_hl(0, "DiffText", { bg = "#3c4e77", underline = false, bold = false })
-- 	    end,
-- 	},
--     },
-- }

require'lspconfig'.ansiblels.setup{
  on_attach = function(client, bufnr)
    -- Your on_attach function here
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

-- old ansible crap
-- require("null-ls").setup({
--   sources = {
--     require("null-ls").builtins.diagnostics.ansiblelint,  -- Assuming ansible-lint is what you want to use
--     -- You can add more sources for other filetypes or tools here
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

vim.api.nvim_create_user_command('BraceyXhtml', function()
    vim.bo.filetype = 'html' -- Set the filetype to HTML
    vim.cmd('Bracey')        -- Start Bracey
end, {})

vim.cmd([[silent! autocmd! filetypedetect BufRead,BufNewFile *.tf]])
vim.cmd([[autocmd BufRead,BufNewFile *.hcl set filetype=hcl]])
vim.cmd([[autocmd BufRead,BufNewFile .terraformrc,terraform.rc set filetype=hcl]])
vim.cmd([[autocmd BufRead,BufNewFile *.tf,*.tfvars set filetype=terraform]])
vim.cmd([[autocmd BufRead,BufNewFile *.tfstate,*.tfstate.backup set filetype=json]])

vim.cmd([[autocmd BufRead,BufNewFile *.terragrunt.hcl set filetype=terraform]])

require'lspconfig'.terraformls.setup{
  root_dir = function(fname)
    return vim.fn.getcwd()
  end,
  filetypes = { "terraform", "hcl", "terraform.tfvars", "terraformrc", "terragrunt.hcl", "terraform-vars" },
  settings = {
    terraform = {
      experimentalFeatures = {
        prefillRequiredFields = true,
      },
      lsp = {
        diagnostics = {
          enable = false,
        },
      },
    },
}
}
require'lspconfig'.tflint.setup{
  filetypes = { "terraform", "hcl", "terraform.tfvars", "terraformrc", "terragrunt.hcl", "terraform-vars" } -- Add 'terragrunt.hcl' here
}
 --
 -- gruvbox
 --
lvim.colorscheme = "gruvbox"
lvim.transparent_window = true


 --
 -- harpoon 
 -- 
local harpoon = require('harpoon')
harpoon:setup({})
local conf = require("telescope.config").values
local function toggle_telescope(harpoon_files)
    local file_paths = {}
    for _, item in ipairs(harpoon_files.items) do
        table.insert(file_paths, item.value)
    end
    require("telescope.pickers").new({}, {
        prompt_title = "Harpoon",
        finder = require("telescope.finders").new_table({
            results = file_paths,
        }),
        previewer = conf.file_previewer({}),
        sorter = conf.generic_sorter({}),
    }):find()
end
vim.keymap.set("n", "<C-s>", function() toggle_telescope(harpoon:list()) end,
    { desc = "Open harpoon window" })
vim.keymap.set("n", "<C-a>", function() harpoon:list():add() end)
vim.keymap.set("n", "<C-d>", function() harpoon:list():remove() end)
vim.keymap.set("n", "<C-h>", function() harpoon:list():prev() end)
vim.keymap.set("n", "<C-t>", function() harpoon:list():next() end)

-- lvim.keys.normal_mode["<leader>zs"] = function()
--   toggle_telescope(harpoon:list())
-- end
-- lvim.keys.normal_mode["<leader>za"] = function()
--   harpoon:list().add()
-- end
-- lvim.keys.normal_mode["<leader>zd"] = function()
--   harpoon:list().remove()
-- end
-- lvim.keys.normal_mode["<leader>zx"] = function()
--   harpoon:list().prev()
-- end
-- lvim.keys.normal_mode["<leader>zc"] = function()
--   harpoon:list().next()
-- end
--

lvim.builtin.telescope.defaults.layout_config = {
  prompt_position = "top",
  height = 0.9,
  width = 0.9,
  bottom_pane = {
    height = 25,
    preview_cutoff = 120,
  },
  center = {
    height = 0.4,
    preview_cutoff = 40,
    width = 0.5,
  },
  cursor = {
    preview_cutoff = 40,
  },
  horizontal = {
    preview_cutoff = 120,
    preview_width = 0.6,
  },
  vertical = {
    preview_cutoff = 40,
  },
  flex = {
    flip_columns = 150,
  },
}
lvim.builtin.telescope.pickers.git_files.previewer = nil
lvim.builtin.telescope.defaults.layout_strategy = "flex"
lvim.builtin.telescope.defaults.prompt_prefix = "  "
lvim.builtin.telescope.defaults.selection_caret = "❯ "

