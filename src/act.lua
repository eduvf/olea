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

function draw_actors()
  for a in all(game.actors) do
    local spr = a.spr
    local x = a.x * 8 * game.scale
    local y = a.y * 8 * game.scale
    
    if a.anim then
      spr = spr + math.floor(game.time % 2)
    end
    draw_sprite(spr, x, y, game.scale, a.flip)
  end
end
