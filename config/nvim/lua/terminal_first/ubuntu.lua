local M = {}

function M.apply()
  vim.g.terminal_first_platform = "ubuntu"
  vim.opt.clipboard = "unnamedplus"
end

return M
