function inv_load()
  inventory = {}
  max_items = 8
  cursor = 1
  cursor_offset = 1
end

function inv_move_cursor(dx)
  cursor = (cursor - 1 + dx) % #inventory + 1
end

function inv_update(dt)
  cursor_offset = cursor_offset + (cursor - cursor_offset) * 8 * dt
end

function inv_add(item)
  if #inventory < max_items then
    table.insert(inventory, item)
  end
end

function inv_remove()
  return table.remove(inventory, cursor)
end

function inv_draw()
  local tile = 8 * scale
  local w = love.graphics.getWidth()
  local y = love.graphics.getHeight() / 2 - tile / 2

  gfx_fade(0.8)
  for i, item in ipairs(inventory) do
    local x = w / 2 + (i - cursor_offset - 0.5) * tile
    if i == cursor then
      love.graphics.setLineWidth(scale)
      love.graphics.rectangle('line', x, y, 8 * scale, 8 * scale)
    end
    spr(item, x, y)
  end
end
