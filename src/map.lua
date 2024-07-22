function generate_map()
  for x = 1, game.map.w do
    game.map.ground[x] = {}
    game.map.crops[x] = {}
    game.map.wall[x] = {}
    for y = 1, game.map.h do
      game.map.ground[x][y] = random(GROUNDS)
      game.map.crops[x][y] = 0
      game.map.wall[x][y] = false
    end
  end
end

function draw_map()
  for x = 1, game.map.w do
    for y = 1, game.map.h do
      local g = game.map.ground[x][y]
      local c = game.map.crops[x][y]

      local x = (x - 1) * 8 * game.scale
      local y = (y - 1) * 8 * game.scale

      if g > 0 then draw_sprite(g, x, y) end
      if c > 0 then draw_sprite(c, x, y) end
    end
  end
end
