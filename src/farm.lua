function harvest_crop(id, x, y)
  game.map.crops[x][y] = 0

  local a = create_actor(id, x - 1, y - 2, 0, 1, false)
  a.move = true
  a.solid = false
  a.die_on_stop = true
  add_actor(a)
  add_to_inventory(id)
end

function farm_action(x, y)
  if not in_range(x, 1, game.map.w) then return end
  if not in_range(y, 1, game.map.h) then return end

  local g = game.map.ground[x][y]
  local c = game.map.crops[x][y]

  if g == SOIL_DRY then
    if c > 0 then
      if c == CROPS[1].DONE then
        harvest_crop(CROPS[1].ITEM, x, y)
        return
      end
      if c == CROPS[2].DONE then
        harvest_crop(CROPS[2].ITEM, x, y)
        return
      end

      game.map.ground[x][y] = SOIL_WET
    else
      if current_inventory_item() == CROPS[1].SEED then
        game.map.crops[x][y] = CROPS[1].CROP
        remove_from_inventory()
      elseif current_inventory_item() == CROPS[2].SEED then
        game.map.crops[x][y] = CROPS[2].CROP
        remove_from_inventory()
      end
    end
  elseif g ~= SOIL_WET then
    game.map.ground[x][y] = SOIL_DRY
  end
end

function next_day()
  for x, row in ipairs(game.map.crops) do
    for y, crop in ipairs(row) do
      local watered = game.map.ground[x][y] == SOIL_WET
      local c = game.map.crops[x][y]

      if watered then
        game.map.ground[x][y] = SOIL_DRY

        if c > 0 then
          game.map.crops[x][y] = c + 1
        end
      end
    end
  end
end

function harvest_tree(tree)
  for fruit in all(tree.links) do
    fruit.move = true
    fruit.die_on_stop = true
    fruit.ox = fruit.x + fruit.ox - game.actors[1].x
    fruit.oy = fruit.y + fruit.oy - game.actors[1].y
    fruit.x = game.actors[1].x
    fruit.y = game.actors[1].y
    add_to_inventory(fruit.spr)
  end
end
