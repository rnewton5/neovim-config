-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

local opts = { noremap = true, silent = true }

-- Shorten function name
local keymap = vim.api.nvim_set_keymap
local bufkeymap = vim.api.nvim_buf_set_keymap

local M = {}

M.general = function()
  --Remap space as leader key
  keymap("", "<Space>", "<Nop>", opts)
  vim.g.mapleader = " "
  vim.g.maplocalleader = " "

  -- Normal --
  -- Better window navigation
  keymap("n", "<C-h>", "<C-w>h", opts)
  keymap("n", "<C-j>", "<C-w>j", opts)
  keymap("n", "<C-k>", "<C-w>k", opts)
  keymap("n", "<C-l>", "<C-w>l", opts)

  -- Open Lexplore
  --keymap("n", "<leader>e", ":Lex 30 <CR>", opts)

  -- Resize with arrows
  keymap("n", "<C-Up>", ":resize -2<CR>", opts)
  keymap("n", "<C-Down>", ":resize +2<CR>", opts)
  keymap("n", "<C-Left>", ":vertical resize -2<CR>", opts)
  keymap("n", "<C-Right>", ":vertical resize +2<CR>", opts)

  -- Navigate buffers
  keymap("n", "<S-l>", ":bnext<CR>", opts)
  keymap("n", "<S-h>", ":bprevious<CR>", opts)
  keymap("n", "<leader>x", ":Bdelete<CR>", opts)
  keymap("n", "<leader>X", ":Bdelete!<CR>", opts)

  -- Move text up and down
  keymap("n", "<A-j>", "<Esc>:m .+1<CR>==", opts)
  keymap("n", "<A-k>", "<Esc>:m .-2<CR>==", opts)

  -- Escape unhighlights search results
  keymap("n", "<ESC>", ":noh<CR>", opts)

  -- Insert --
  -- Press jk fast to exit insert mode
  --keymap("i", "jk", "<ESC>", opts)

  -- Visual --
  -- Stay in indent mode
  keymap("v", "<", "<gv", opts)
  keymap("v", ">", ">gv", opts)

  -- Move text up and down
  keymap("v", "<A-j>", ":m .+1<CR>==", opts)
  keymap("v", "<A-k>", ":m .-2<CR>==", opts)
  keymap("v", "p", '"_dP', opts)

  -- Visual Block --
  -- Move text up and down
  keymap("x", "<A-k>", ":move '<-2<CR>gv-gv", opts)
  keymap("x", "J", ":move '>+1<CR>gv-gv", opts)
  keymap("x", "K", ":move '<-2<CR>gv-gv", opts)
  keymap("x", "<A-j>", ":move '>+1<CR>gv-gv", opts)

  -- Terminal --
  -- Better terminal navigation
  --[[ keymap("t", "<C-h>", "<C-\\><C-N><C-w>h", term_opts) ]]
  --[[ keymap("t", "<C-j>", "<C-\\><C-N><C-w>j", term_opts) ]]
  --[[ keymap("t", "<C-k>", "<C-\\><C-N><C-w>k", term_opts) ]]
  --[[ keymap("t", "<C-l>", "<C-\\><C-N><C-w>l", term_opts) ]]
end

M.lsp = function(bufnr)
  bufkeymap(bufnr, "n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
  bufkeymap(bufnr, "n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
  bufkeymap(bufnr, "n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
  bufkeymap(bufnr, "n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
  bufkeymap(bufnr, "n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
  bufkeymap(bufnr, "n", "<leader>lk", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
  bufkeymap(bufnr, "n", "<leader>lr", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
  bufkeymap(bufnr, "n", "<leader>la", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
  bufkeymap(bufnr, "n", "<leader>ld", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
  bufkeymap(bufnr, "n", "<leader>lq", "<cmd>lua vim.diagnostic.setloclist()<CR>", opts)
  bufkeymap(bufnr, "n", "<leader>l[", '<cmd>lua vim.diagnostic.goto_prev({ border = "rounded" })<CR>', opts)
  bufkeymap(bufnr, "n", "<leader>l]", '<cmd>lua vim.diagnostic.goto_next({ border = "rounded" })<CR>', opts)
  bufkeymap(bufnr, "n", "<leader>lf", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
  bufkeymap(bufnr, "n", "<leader>lo", "<cmd>SymbolsOutline<CR>", opts)
  bufkeymap(bufnr, "n", "gl", '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics({ border = "rounded" })<CR>', opts)
end

M.lsp_telescope = function(bufnr)
  -- overwrites some LSP keymaps
  --   should be called after lsp only if Telescope is installed
  bufkeymap(bufnr, "n", "gd", ":Telescope lsp_definitions<cr>", opts)
  bufkeymap(bufnr, "n", "gr", ":Telescope lsp_references<cr>", opts)
  bufkeymap(bufnr, "n", "gi", ":Telescope lsp_implementations<cr>", opts)
end

M.lsp_rust_tools = function(bufnr, rust_tools)
  -- overwrites some LSP keymaps
  --   should be called after lsp if using rust_tools
  -- Hover actions
  vim.keymap.set("n", "K", rust_tools.hover_actions.hover_actions, { buffer = bufnr })
  -- Code action groups
  vim.keymap.set("n", "<Leader>la", rust_tools.code_action_group.code_action_group, { buffer = bufnr })
end

M.telescope = function()
  keymap("n", "<leader>ff", ":Telescope find_files<cr>", opts)
  keymap("n", "<leader>fw", ":Telescope live_grep<cr>", opts)
  keymap("n", "<leader>fb", ":Telescope buffers<cr>", opts)
  keymap("n", "<leader>fh", ":Telescope help_tags<cr>", opts)
end

M.dap = function()
  keymap("n", "<leader>du", ":lua require('dapui').toggle({ reset = true })<cr>", opts)
  keymap("n", "<leader>dh", ":PBToggleBreakpoint<cr>", opts)
  keymap("n", "<leader>dH", ":PBSetConditionalBreakpoint<cr>", opts)
  keymap("n", "<leader>dg", ":lua require('dap').goto_(vim.api.nvim_win_get_cursor(0)[1])<cr>", opts)
  keymap("n", "<F5>", ":DapContinue<cr>", opts)
  keymap("n", "<F10>", ":DapStepOver<cr>", opts)
  keymap("n", "<F12>", ":DapStepInto<cr>", opts)
  keymap("n", "<S-F12>", ":DapStepOut<cr>", opts)
end

M.nvim_tree = function()
  keymap("n", "<leader>e", ":NvimTreeToggle<cr>", opts)
end

return M
