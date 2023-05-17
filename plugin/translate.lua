if vim.g.loaded_translate then
  return
end

vim.g.loaded_translate = true

vim.api.nvim_create_user_command(
  "Translate",
  function(opts)
    local util = require("translate.util")
    local args = util.unpack_args(opts.args)
    local src_text = util.get_visual_selection() 
    local dest_text = util.run_command(src_text, args[0], args[1])
    print(dest_text)
    vim.fn.setreg("+", dest_text)
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<Esc>', true, false, true), 'n', true)
  end,
  {
    nargs = "*",
  }
)

