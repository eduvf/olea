function move_inventory_cursor(ch)
  local c = game.inventory.cursor

  if ch == 'a' or ch == 'left' then
    c = c - 1
  elseif ch == 'd' or ch == 'right' then
    c = c + 1
  end

  game.inventory.cursor = math.max(1, math.min(c, #game.inventory.items))
end

function current_inventory_item()
  return game.inventory.items[game.inventory.cursor]
end

function add_to_inventory(item)
  table.insert(game.inventory.items, item)
end

function remove_from_inventory()
  if #game.inventory.items == 0 then return end

  local item = table.remove(game.inventory.items, game.inventory.cursor)
  game.inventory.cursor = math.max(1, math.min(game.inventory.cursor, #game.inventory.items))

  return item
end

function draw_inventory()
  for i, item in ipairs(game.inventory.items) do
    draw_sprite(item, (i - 1) * 8 * game.scale, 0)
  end

  draw_sprite(CURSOR, (game.inventory.cursor - 1) * 8 * game.scale, 0)
end
