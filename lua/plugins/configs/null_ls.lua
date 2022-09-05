local null_ls_ok, null_ls = pcall(require, "null-ls")

if not null_ls_ok then
  return
end

local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics
local completion = null_ls.builtins.completion

require("null-ls").setup({
    sources = {
        -- formatting.stylua,
    },
})
