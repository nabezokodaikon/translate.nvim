local text_util = require("translate.text_util")

local M = {}

M.run_command = function(src_text, sl, tl)
  local handle = io.popen("trans -b -show-original n -sl=" ..sl.. " -tl=" ..tl.. " '" ..src_text.. "'")
  local dest_text = text_util.remove_last_line(handle:read("*a"))
  return dest_text;
end

return M

