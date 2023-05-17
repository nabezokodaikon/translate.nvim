if vim.g.loaded_translate then
  return
end

vim.g.loaded_translate = true

vim.api.nvim_create_user_command(
  "TransLateJa2En",
  function()
    local util = require("translate.util")
    local ja_text = util.get_visual_selection() 
    local en_text = util.ja_2_en(ja_text)
    print(en_text)
  end,
  {
    nargs = 0,
  })


