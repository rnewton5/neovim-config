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

local so_ok, so = pcall(require, "symbols-outline")
if not so_ok then
  return
end

local so_opts = {
  highlight_hovered_item = true,
  show_guides = true,
  auto_preview = false,
  position = 'right',
  relative_width = true,
  width = 25,
  auto_close = true,
  show_numbers = false,
  show_relative_numbers = false,
  show_symbol_details = true,
  preview_bg_highlight = 'Pmenu',
  autofold_depth = nil,
  auto_unfold_hover = true,
  fold_markers = { '', '' },
  wrap = false,
  keymaps = { -- These keymaps can be a string or a table for multiple keys
    close = {"<Esc>", "q"},
    goto_location = "<Cr>",
    focus_location = "o",
    hover_symbol = "K",
    toggle_preview = "p",
    rename_symbol = "r",
    code_actions = "a",
    fold = "h",
    unfold = "l",
    fold_all = "W",
    unfold_all = "E",
    fold_reset = "R",
  },
  lsp_blacklist = {},
  symbol_blacklist = {},
  symbols = {
    File = {icon = "", hl = "TSURI"},
    Module = {icon = "", hl = "TSNamespace"},
    Namespace = {icon = "", hl = "TSNamespace"},
    Package = {icon = "", hl = "TSNamespace"},
    Class = {icon = "𝓒", hl = "TSType"},
    Method = {icon = "ƒ", hl = "TSMethod"},
    Property = {icon = "", hl = "TSMethod"},
    Field = {icon = "", hl = "TSField"},
    Constructor = {icon = "", hl = "TSConstructor"},
    Enum = {icon = "ℰ", hl = "TSType"},
    Interface = {icon = "ﰮ", hl = "TSType"},
    Function = {icon = "", hl = "TSFunction"},
    Variable = {icon = "", hl = "TSConstant"},
    Constant = {icon = "", hl = "TSConstant"},
    String = {icon = "𝓐", hl = "TSString"},
    Number = {icon = "#", hl = "TSNumber"},
    Boolean = {icon = "⊨", hl = "TSBoolean"},
    Array = {icon = "", hl = "TSConstant"},
    Object = {icon = "⦿", hl = "TSType"},
    Key = {icon = "🔐", hl = "TSType"},
    Null = {icon = "NULL", hl = "TSType"},
    EnumMember = {icon = "", hl = "TSField"},
    Struct = {icon = "𝓢", hl = "TSType"},
    Event = {icon = "🗲", hl = "TSType"},
    Operator = {icon = "+", hl = "TSOperator"},
    TypeParameter = {icon = "𝙏", hl = "TSParameter"}
  }
}

so.setup(so_opts)
