function generate_map(w, h)
  for x = 1, w do
    game.map[x] = {}
    for y = 1, h do
      local floor = random(FLOORS)
      game.map[x][y] = floor
    end
  end
end

function draw_map()
  for x, row in ipairs(game.map) do
    for y, tile in ipairs(row) do
      local x = (x - 1) * 8 * game.scale
      local y = (y - 1) * 8 * game.scale
      draw_sprite(tile, x, y)
    end
  end
end
