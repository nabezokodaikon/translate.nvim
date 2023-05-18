if not vim.g.loaded_translate then
  vim.g.loaded_translate = true
else
  return
end

local text_util = require("translate.text_util")
local command_util = require("translate.command_util")
local popup_util = require("translate.popup_util")

vim.api.nvim_create_user_command(
  "Translate",
  function(opts)
    local args = text_util.unpack_args(opts.args)

    -- 選択範囲の文字列を取得する。
    local src_text = text_util.get_visual_selection() 
    if #src_text == 0 then
      return
    end

    -- 翻訳結果を取得する。
    local dest_text = command_util.run_command(src_text, args[0], args[1])

    -- ポップアップウィンドウを表示する。
    popup_util.show_popup(dest_text)

    -- ヤンクに追加する。
    vim.fn.setreg("+", dest_text)

    -- NormalModeに戻す。
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<Esc>', true, false, true), 'n', true)
  end,
  {
    nargs = "*",
  }
)

