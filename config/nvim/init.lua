-- ~/.config/nvim/init.lua
-- Simple, concise Neovim config using lazy.nvim
-- Best for users who want one maintainable file instead of many folders.

-----------------------------------------------------------
-- Leader keys
-----------------------------------------------------------
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-----------------------------------------------------------
-- Options
-----------------------------------------------------------
local opt = vim.opt

-- UI
opt.number = true
opt.relativenumber = true
opt.signcolumn = "yes"
opt.cursorline = true
opt.termguicolors = true
opt.laststatus = 3
opt.showmode = false

-- Editing
opt.expandtab = true
opt.shiftwidth = 2
opt.tabstop = 2
opt.softtabstop = 2
opt.smartindent = true
opt.undofile = true
opt.confirm = true

-- Search
opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = true
opt.incsearch = true

-- Splits
opt.splitright = true
opt.splitbelow = true

-- Scrolling
opt.scrolloff = 8
opt.sidescrolloff = 8

-- Clipboard
opt.clipboard = "unnamedplus"

-- Better completion menu
opt.completeopt = { "menu", "menuone", "noselect" }

-----------------------------------------------------------
-- Keymaps
-----------------------------------------------------------
local map = vim.keymap.set

map("n", "<leader>w", "<cmd>write<CR>", { desc = "Save file" })
map("n", "<leader>q", "<cmd>quit<CR>", { desc = "Quit" })
map("n", "<leader>h", "<cmd>nohlsearch<CR>", { desc = "Clear search highlight" })

-- Window movement
map("n", "<C-h>", "<C-w>h", { desc = "Move to left window" })
map("n", "<C-j>", "<C-w>j", { desc = "Move to lower window" })
map("n", "<C-k>", "<C-w>k", { desc = "Move to upper window" })
map("n", "<C-l>", "<C-w>l", { desc = "Move to right window" })

-- Buffers
map("n", "<leader>bn", "<cmd>bnext<CR>", { desc = "Next buffer" })
map("n", "<leader>bp", "<cmd>bprevious<CR>", { desc = "Previous buffer" })
map("n", "<leader>bd", "<cmd>bdelete<CR>", { desc = "Delete buffer" })

-- Diagnostics
map("n", "[d", function()
  vim.diagnostic.jump({ count = -1 })
end, { desc = "Previous diagnostic" })

map("n", "]d", function()
  vim.diagnostic.jump({ count = 1 })
end, { desc = "Next diagnostic" })

map("n", "<leader>e", vim.diagnostic.open_float, { desc = "Show diagnostic" })

-----------------------------------------------------------
-- Autocommands
-----------------------------------------------------------
local group = vim.api.nvim_create_augroup("UserConfig", { clear = true })

vim.api.nvim_create_autocmd("TextYankPost", {
  group = group,
  callback = function()
    vim.highlight.on_yank()
  end,
  desc = "Highlight yanked text",
})

vim.api.nvim_create_autocmd("BufWritePre", {
  group = group,
  callback = function()
    if vim.bo.modifiable then
      vim.cmd([[%s/\s\+$//e]])
    end
  end,
  desc = "Trim trailing whitespace on save",
})

-----------------------------------------------------------
-- Bootstrap lazy.nvim
-----------------------------------------------------------
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "--branch=stable",
    lazyrepo,
    lazypath,
  })

  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
    }, true, {})
    os.exit(1)
  end
end

opt.rtp:prepend(lazypath)

-----------------------------------------------------------
-- Plugins
-----------------------------------------------------------
require("lazy").setup({
  spec = {
    -------------------------------------------------------
    -- Colorscheme
    -------------------------------------------------------
    {
      "folke/tokyonight.nvim",
      lazy = false,
      priority = 1000,
      opts = {
        style = "night",
      },
      config = function(_, opts)
        require("tokyonight").setup(opts)
        vim.cmd.colorscheme("tokyonight")
      end,
    },

    -------------------------------------------------------
    -- Fuzzy finder
    -------------------------------------------------------
    {
      "nvim-telescope/telescope.nvim",
      dependencies = { "nvim-lua/plenary.nvim" },
      cmd = "Telescope",
      keys = {
        { "<leader>ff", "<cmd>Telescope find_files<CR>", desc = "Find files" },
        { "<leader>fg", "<cmd>Telescope live_grep<CR>", desc = "Live grep" },
        { "<leader>fb", "<cmd>Telescope buffers<CR>", desc = "Find buffers" },
        { "<leader>fh", "<cmd>Telescope help_tags<CR>", desc = "Help tags" },
      },
      opts = {},
    },

    -------------------------------------------------------
    -- Git signs
    -------------------------------------------------------
    {
      "lewis6991/gitsigns.nvim",
      event = { "BufReadPre", "BufNewFile" },
      opts = {},
    },

    -------------------------------------------------------
    -- Statusline
    -------------------------------------------------------
    {
      "nvim-lualine/lualine.nvim",
      event = "VeryLazy",
      opts = {
        options = {
          theme = "auto",
          globalstatus = true,
          component_separators = "",
          section_separators = "",
        },
        sections = {
          lualine_a = { "mode" },
          lualine_b = { "branch", "diff" },
          lualine_c = {
            {
              "filename",
              path = 1,
              symbols = {
                modified = " [+]",
                readonly = " [RO]",
                unnamed = "[No Name]",
                newfile = "[New]",
              },
            },
          },
          lualine_x = {
            {
              "diagnostics",
              sections = { "error", "warn" },
              symbols = { error = "E:", warn = "W:" },
              update_in_insert = false,
            },
            "filetype",
          },
          lualine_y = { "progress" },
          lualine_z = { "location" },
        },
      },
    },

    -------------------------------------------------------
    -- LSP config collection
    -- Uses modern vim.lsp.enable() style below.
    -------------------------------------------------------
    {
      "neovim/nvim-lspconfig",
      event = { "BufReadPre", "BufNewFile" },
    },
  },

  install = {
    colorscheme = { "tokyonight", "habamax" },
  },

  checker = {
    enabled = false,
  },

  change_detection = {
    notify = false,
  },
})

-----------------------------------------------------------
-- LSP
-----------------------------------------------------------
vim.api.nvim_create_autocmd("LspAttach", {
  group = group,
  callback = function(event)
    local buf = event.buf

    local lsp_map = function(lhs, rhs, desc)
      map("n", lhs, rhs, { buffer = buf, desc = desc })
    end

    lsp_map("gd", vim.lsp.buf.definition, "Go to definition")
    lsp_map("gD", vim.lsp.buf.declaration, "Go to declaration")
    lsp_map("gr", vim.lsp.buf.references, "References")
    lsp_map("gi", vim.lsp.buf.implementation, "Go to implementation")
    lsp_map("K", vim.lsp.buf.hover, "Hover")
    lsp_map("<leader>rn", vim.lsp.buf.rename, "Rename")
    lsp_map("<leader>ca", vim.lsp.buf.code_action, "Code action")
    lsp_map("<leader>f", function()
      vim.lsp.buf.format({ async = true })
    end, "Format buffer")
  end,
})

-- Lua language server config.
-- Install lua-language-server first, then this will attach automatically.
vim.lsp.config("lua_ls", {
  settings = {
    Lua = {
      runtime = {
        version = "LuaJIT",
      },
      diagnostics = {
        globals = { "vim" },
      },
      workspace = {
        library = {
          vim.env.VIMRUNTIME,
        },
      },
    },
  },
})

-- Enable only servers you actually use.
-- Add more later, for example: "pyright", "ts_ls", "gopls", "rust_analyzer".
vim.lsp.enable({
  "lua_ls",
})
