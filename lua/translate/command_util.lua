local M = {}

local function remove_last_line(str)
  local letters = {}
  for let in string.gmatch(str, ".") do
    table.insert(letters, let)
  end

  local i = #letters
  while i >= 0 do
    if letters[i] == "\n" then
      letters[i] = nil
      break
    end
    letters[i] = nil
    i = i - 1
  end
  return table.concat(letters)
end

M.run_command = function(src_text, sl, tl)
  local handle = io.popen("trans -b -show-original n -sl=" ..sl.. " -tl=" ..tl.. " '" ..src_text.. "'")
  local dest_text = remove_last_line(handle:read("*a"))
  return dest_text;
end

return M

