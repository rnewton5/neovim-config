local status_ok, lspconfig = pcall(require, "lspconfig")
if not status_ok then
	return
end

local opts = {
  on_attach = require("user.lsp.handlers").on_attach,
  capabilities = require("user.lsp.handlers").capabilities,
}

-- lua
local sumneko_opts = require("user.lsp.settings.sumneko_lua")
sumneko_opts = vim.tbl_deep_extend("force", sumneko_opts, opts)
lspconfig.sumneko_lua.setup(sumneko_opts)

-- rust
lspconfig.rust_analyzer.setup(opts)

require("user.lsp.handlers").setup()

