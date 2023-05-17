if vim.g.loaded_translate then
  return
end

vim.g.loaded_translate = true

vim.api.nvim_create_user_command(
  "TranslateJa2En",
  function(opts)
    local util = require("translate.util")
    local args = util.unpack_args(opts.args)
    local src_text = util.get_visual_selection() 
    local dest_text = util.run_command(src_text, args[0], args[1])
    print(dest_text)
    vim.fn.setreg("+", dest_text)
  end,
  {
    nargs = "*",
  }
)

