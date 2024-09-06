function dlg_load()
  open_dialog = false
  message = ''
end

function dlg_is_dialog_open()
  return open_dialog
end

function dlg_open(m)
  open_dialog = true
  message = m
end

function dlg_close()
  open_dialog = false
end

function dlg_draw()
  local y = love.graphics.getHeight() / 2 - 6 * 2 * scale
  local x = love.graphics.getWidth() / 2 - 40 * scale
  local w = 80
  gfx_fade(0.8)
  love.graphics.printf(message, x, y, w, 'left', 0, scale)
end
