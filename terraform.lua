local M = {}

-- Command: Invoke an arbitrary terraform command
M.terraform = function(args)
  vim.fn.system("terraform " .. args)
end

-- Command: Invoke `terraform fmt` on a current buffer
M.terraform_fmt = function()
  vim.fn.system("terraform fmt " .. vim.fn.expand("%:p"))
end

-- Settings
M.settings = {
  terraform_align = 0,
  terraform_binary_path = "terraform",
  terraform_fmt_on_save = 0,
  terraform_fold_sections = 0,
}

-- Registering commands in Neovim
vim.cmd [[
  command! -nargs=* Terraform lua require'your_plugin'.terraform(<f-args>)
  command! TerraformFmt lua require'your_plugin'.terraform_fmt()
]]

-- Add auto commands for formatting on save if required
if M.settings.terraform_fmt_on_save == 1 then
  vim.cmd [[
    autocmd BufWritePre *.tf,*.tfvars lua require'your_plugin'.terraform_fmt()
  ]]
end

return M

