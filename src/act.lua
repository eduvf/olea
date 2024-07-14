function create_actor(spr, x, y, ox, oy, anim, size)
  return {
    spr = spr,
    x = x,
    y = y,
    ox = ox or 0,
    oy = oy or 0,
    anim = anim == nil,
    size = size or 1,
    flip = false,
    solid = true,
    links = {}
  }
end

function add_actor(act)
  table.insert(game.actors, act)
end

function add_link_actor(parent_act, act)
  add_actor(act)
  table.insert(parent_act.links, act)
end

function check_collision(act, x, y)
  for a in all(game.actors) do
    if a ~= act and a.solid then
      x = act.x + x
      y = act.y + y
      local check_x = a.x == x - (x % a.size)
      local check_y = a.y == y - (y % a.size)
      if check_x and check_y then
        return a
      end
    end
  end
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
  local tile = 8 * game.scale

  for a in all(game.actors) do
    local s = a.spr
    local x = (a.x + a.ox) * tile
    local y = (a.y + a.oy) * tile

    if a.anim then
      s = s + math.floor(game.time % 2)
    end
    
    if a.size == 1 then
      draw_sprite(s, x, y, a.flip)
    elseif a.size == 2 then
      draw_sprite(s, x, y)
      draw_sprite(s + 1, x + tile, y)
      draw_sprite(s + 8, x, y + tile)
      draw_sprite(s + 9, x + tile, y + tile)
    end
  end
end
