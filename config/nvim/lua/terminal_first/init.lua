local M = {}

vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.signcolumn = "yes"
vim.opt.termguicolors = true
vim.opt.updatetime = 250
vim.opt.timeoutlen = 400
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.smartindent = true

M.core_languages = {
  lua = { lsp = "lua_ls", formatter = "stylua" },
  markdown = { lsp = "marksman", formatter = "prettier", linter = "markdownlint" },
  shell = { lsp = "bashls", formatter = "shfmt", linter = "shellcheck" },
  powershell = { lsp = "powershell_es", formatter = "powershell_es" },
}

M.optional_languages = {
  typescript = { lsp = "tsserver", formatter = "prettier", linter = "eslint_d" },
  python = { lsp = "pyright", formatter = "ruff_format", linter = "ruff" },
}

M.plugins = {
  { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
  { "neovim/nvim-lspconfig" },
  { "stevearc/conform.nvim" },
  { "mfussenegger/nvim-lint" },
  { "nvim-telescope/telescope.nvim", dependencies = { "nvim-lua/plenary.nvim" } },
}

function M.apply()
  local system = (vim.loop or vim.uv).os_uname().sysname
  if system:match("Windows") then
    require("terminal_first.windows").apply()
  else
    require("terminal_first.ubuntu").apply()
  end

  vim.keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Find files" })
  vim.keymap.set("n", "<leader>fg", "<cmd>Telescope live_grep<cr>", { desc = "Live grep" })
  vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Line diagnostics" })
end

M.apply()

return M
