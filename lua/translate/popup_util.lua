M = {}

local popup_win

function close_popup_window()
  if vim.api.nvim_win_is_valid(popup_win) then
    vim.api.nvim_win_close(popup_win, true)
  end
end

local function split(text)
  local text_lines = {}
  for line in text:gmatch("[^\n]+") do
    table.insert(text_lines, line)
  end
  return text_lines 
end

M.show_popup = function(text)

  -- 文字列を改行を区切りにテーブル化。
  local text_lines = split(text)

  -- ポップアップウィンドウの作成と設定。
  local popup_buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_buf_set_option(popup_buf, "bufhidden", "wipe")
  vim.api.nvim_buf_set_option(popup_buf, "filetype", "text")
  local popup_opts = {
    relative = "cursor",
    anchor = "NW",
    focusable = true,
    style = "minimal",
    width = 128,
    height = #text_lines,
    row = 1,
    col = 1,
  }
  vim.api.nvim_buf_set_lines(popup_buf, 0, -1, false, text_lines)
  vim.api.nvim_buf_set_option(popup_buf, 'modifiable', false)

  -- ポップアップウィンドウを表示します。
  popup_win = vim.api.nvim_open_win(popup_buf, false, popup_opts)

  -- カーソル移動でポップアップウィンドウを閉じる。
  vim.api.nvim_command([[autocmd CursorMoved <buffer> lua close_popup_window()]])

  -- 後処理。
  vim.api.nvim_win_set_buf(popup_win, popup_buf)
  vim.api.nvim_buf_set_option(popup_buf, "modifiable", false)
  vim.api.nvim_win_set_option(popup_win, "winhighlight", "Normal:Visual")
  vim.api.nvim_buf_add_highlight(popup_buf, -1, "TranslatePopupTitle", 0, 0, -1)
end

return M

