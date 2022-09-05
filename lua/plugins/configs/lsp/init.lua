local status_ok, lspconfig = pcall(require, "lspconfig")
if not status_ok then
	return
end

local path_base = "plugins.configs.lsp."
local handlers = require(path_base .. "handlers")
local settings = require(path_base .. "settings")

local opts = {
  on_attach = handlers.on_attach,
  capabilities = handlers.capabilities,
}

-- lua
local sumneko_opts = settings.sumneko_lua
sumneko_opts = vim.tbl_deep_extend("force", sumneko_opts, opts)
lspconfig.sumneko_lua.setup(sumneko_opts)

-- rust
lspconfig.rust_analyzer.setup(opts)

handlers.setup()

