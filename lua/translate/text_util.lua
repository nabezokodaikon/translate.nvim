local M = {}

M.unpack_args = function(args_string)
  if args_string == nil then
    return {}
  end

  local t = {}
  local i = 0

  for s in string.gmatch(args_string, "([^%s]+)") do
    t[i] = s
    i = i + 1
  end

  return t
end

M.get_visual_selection = function()
	local ESC_FEEDKEY = vim.api.nvim_replace_termcodes("<ESC>", true, false, true)
	vim.api.nvim_feedkeys(ESC_FEEDKEY, "n", true)
	vim.api.nvim_feedkeys("gv", "x", false)
	vim.api.nvim_feedkeys(ESC_FEEDKEY, "n", true)

  local s_start = vim.fn.getpos("'<")
  local s_end = vim.fn.getpos("'>")
  local n_lines = math.abs(s_end[2] - s_start[2]) + 1
  local lines = vim.api.nvim_buf_get_lines(0, s_start[2] - 1, s_end[2], false)
  if lines[1] == nil then
    return ""
  end
  lines[1] = string.sub(lines[1], s_start[3], -1)
  if n_lines == 1 then
    lines[n_lines] = string.sub(lines[n_lines], 1, s_end[3] - s_start[3] + 1)
  else
    lines[n_lines] = string.sub(lines[n_lines], 1, s_end[3])
  end
  return table.concat(lines, '\n')
end

return M

