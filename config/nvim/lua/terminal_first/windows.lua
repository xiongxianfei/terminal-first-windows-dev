local M = {}

function M.apply()
  vim.g.terminal_first_platform = "windows"
  vim.opt.shellslash = true
end

return M
