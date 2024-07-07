function create_actor(spr, x, y, ox, oy, anim, size)
  return {
    spr = spr,
    x = x,
    y = y,
    ox = ox or 0,
    oy = oy or 0,
    anim = anim or true,
    size = size or 1,
    flip = false,
  }
end

function update_actors(dt)
  for a in all(game.actors) do
    if a.anim then
      a.ox = a.ox * (0.95 - dt)
      a.oy = a.oy * (0.95 - dt)
    end
  end
end

function draw_actors()
  for a in all(game.actors) do
    local spr = a.spr
    local x = (a.x + a.ox) * 8 * game.scale
    local y = (a.y + a.oy) * 8 * game.scale

    if a.anim then
      spr = spr + math.floor(game.time % 2)
    end
    draw_sprite(spr, x, y, game.scale, a.flip)
  end
end
