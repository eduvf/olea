function move_inventory_cursor(ch)
  local c = game.inventory.cursor

  if ch == 'a' or ch == 'left' then
    c = c - 1
  elseif ch == 'd' or ch == 'right' then
    c = c + 1
  end

  game.inventory.cursor = (c - 1) % #game.inventory.items + 1
end

function draw_inventory()
  for i, item in ipairs(game.inventory.items) do
    draw_sprite(item, (i - 1) * 8 * game.scale, 0)
  end

  draw_sprite(CURSOR, (game.inventory.cursor - 1) * 8 * game.scale, 0)
end
