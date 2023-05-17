if not vim.g.loaded_translate then
  vim.g.loaded_translate = true
else
  return
end

vim.api.nvim_create_user_command(
  "Translate",
  function(opts)
    local util = require("translate.util")
    local args = util.unpack_args(opts.args)
    local src_text = util.get_visual_selection() 
    local dest_text = util.run_command(src_text, args[0], args[1])
    local dest_text_lines = {}
    for line in dest_text:gmatch("[^\n]+") do
      table.insert(dest_text_lines, line)
    end
    -- print(dest_text)

    -- ポップアップウィンドウの作成と設定
    --
    local popup_buf = vim.api.nvim_create_buf(false, true)
    vim.api.nvim_buf_set_option(popup_buf, "bufhidden", "wipe")
    vim.api.nvim_buf_set_option(popup_buf, "filetype", "text")
    -- vim.api.nvim_buf_set_option(popup_buf, 'modifiable', false)
    local popup_opts = {
      relative = "cursor",
      anchor = "NW",
      focusable = true,
      style = "minimal",
      width = 40,
      height = #dest_text_lines,
      row = 1,
      col = 1,
    }
    vim.api.nvim_buf_set_lines(popup_buf, 0, -1, false, dest_text_lines)
    vim.api.nvim_buf_set_option(popup_buf, 'modifiable', false)
    local popup_win = vim.api.nvim_open_win(popup_buf, false, popup_opts)
    vim.cmd[[highlight Hoge guifg=#2e3440 guibg=#a3be8c]]
    vim.api.nvim_win_set_option(popup_win, 'winhighlight', 'Normal:Visual')
    function close_popup_window()
      if vim.api.nvim_win_is_valid(popup_win) then
        vim.api.nvim_win_close(popup_win, true)
      end
    end
    vim.api.nvim_command([[autocmd CursorMoved <buffer> lua close_popup_window()]])

    -- ポップアップウィンドウが閉じられたらバッファとウィンドウを削除
    -- vim.api.nvim_win_set_buf(popup_win, popup_buf)
    -- vim.api.nvim_buf_set_option(popup_buf, "modifiable", false)
    -- vim.api.nvim_win_set_option(popup_win, "winhighlight", "Normal:TranslatePopupHighlight")
    -- vim.api.nvim_buf_add_highlight(popup_buf, -1, "TranslatePopupTitle", 0, 0, -1)


    vim.fn.setreg("+", dest_text)
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<Esc>', true, false, true), 'n', true)
  end,
  {
    nargs = "*",
  }
)

