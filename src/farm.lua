function farm_action(x, y)
  if not in_range(x, 1, game.map.w) then return end
  if not in_range(y, 1, game.map.h) then return end

  local g = game.map.ground[x][y]
  local c = game.map.crops[x][y]

  if g == SOIL_DRY then
    if c > 0 then
      if c == CROPS[1].DONE
      or c == CROPS[2].DONE then
        game.map.crops[x][y] = 0
        return
      end

      game.map.ground[x][y] = SOIL_WET
    else
      game.map.crops[x][y] = CROPS[1].CROP
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
  end
end
