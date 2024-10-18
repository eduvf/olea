function dlg_load()
  open_dialog = false
  message_from = ''
  message_to = ''
  message_time = 0
end

function dlg_update()
  if #message_to < #message_from then
    if time - message_time > 0.1 then
      message_time = time
      message_to = message_from:sub(1, #message_to + 1)
    end
  end
end

function dlg_is_dialog_open()
  return open_dialog
end

function dlg_open(m)
  open_dialog = true
  _, message_from = love.graphics.getFont():getWrap(m, 80)
  message_from = table.concat(message_from, '\n')
  message_time = time
end

function dlg_close()
  if #message_to == #message_from then
    open_dialog = false
    dlg_load()
  else
    message_to = message_from
  end
end

function dlg_draw()
  local y = love.graphics.getHeight() / 2 - 6 * 2 * scale
  local x = love.graphics.getWidth() / 2 - 40 * scale
  gfx_fade(0.8)
  love.graphics.print(message_to, x, y, 0, scale)
end
