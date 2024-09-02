function obj_load()
  objects = {}
end

function obj_create(n, x, y, anim)
  local o = {
    sprite = n,
    x = x,
    y = y,
    ox = 0,
    oy = 0,
    animate = false
  }
  if anim then o.animate = true end
  table.insert(objects, o)
  return o
end

function obj_update(dt)
  for _, o in ipairs(objects) do
    o.ox = o.ox * (0.95 - dt)
    o.oy = o.oy * (0.95 - dt)
  end
end

function obj_glide(o, dx, dy)
  o.x = o.x + dx
  o.y = o.y + dy
  o.ox = o.ox - dx
  o.oy = o.oy - dy
end

function obj_draw()
  for _, o in ipairs(objects) do
    local n = o.sprite
    if o.animate then
      n = n + math.floor(time % 2)
    end
    
    local x = (o.x + o.ox) * 8 * scale
    local y = (o.y + o.oy) * 8 * scale

    spr(n, x, y)
  end
end
