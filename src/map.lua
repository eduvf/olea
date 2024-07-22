function generate_map()
  for x = 1, game.map.w do
    game.map.ground[x] = {}
    for y = 1, game.map.h do
      game.map.ground[x][y] = random(GROUNDS)
    end
  end
end

function get_from_map_ground(x, y)
  if not in_range(x, 1, game.map.w) then return end
  if not in_range(y, 1, game.map.h) then return end

  return game.map.ground[x][y]
end

function set_into_map_ground(id, x, y)
  if not in_range(x, 1, game.map.w) then return end
  if not in_range(y, 1, game.map.h) then return end

  game.map.ground[x][y] = id
end

function draw_map()
  for x, row in ipairs(game.map.ground) do
    for y, tile in ipairs(row) do
      if tile > 0 then
        local x = (x - 1) * 8 * game.scale
        local y = (y - 1) * 8 * game.scale
        draw_sprite(tile, x, y)
      end
    end
  end
end
