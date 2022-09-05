local function setup_plugin(plugin_name, opts)
  local plugin_ok, plugin = pcall(require, plugin_name)
  if not plugin_ok then
    vim.notify(plugin_name .. " not found")
    return false
  else
    plugin.setup(opts)
    return true
  end
end

local mason_ok = setup_plugin("mason", {})
if mason_ok then
  setup_plugin("mason-lspconfig", {})
end

