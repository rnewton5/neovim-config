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

-- rust (via rust-tools)
local rust_tools_ok, rust_tools = pcall(require, "rust-tools")
if (rust_tools_ok) then
  rust_tools.setup({
    server = {
      on_attach = function(client, bufnr)
        handlers.on_attach(client, bufnr)
        require("keymaps").lsp_rust_tools(bufnr, rust_tools)
        rust_tools.inlay_hints.set()
      end,
      capabilities = handlers.capabilities,
    },
    dap = {
      adapter = require('rust-tools.dap').get_codelldb_adapter(
        "/home/rhett/.local/share/nvim/mason/packages/codelldb/extension/adapter/codelldb",
        "/home/rhett/.local/share/nvim/mason/packages/codelldb/extension/lldb/lib/liblldb.so"
      )
    }
  })
end

handlers.setup()
