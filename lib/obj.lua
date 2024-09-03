function obj_load()
  objects = {}
end

function obj_create(n, x, y, size, dynamic, solid)
  local o = {
    sprite = n,
    x = x,
    y = y,
    ox = 0,
    oy = 0,
    size = size or 1,
    flip = false,
    move = false,
    solid = false,
    animate = false,
    die_on_stop = false
  }
  if dynamic then
    o.move = true
    o.animate = true
  end
  if solid then
    o.solid = true
  end
  table.insert(objects, o)
  return o
end

function obj_set_sprite(o, n)
  o.sprite = n
end

function obj_update(dt)
  for i, o in ipairs(objects) do
    if o.move then
      o.ox = o.ox * (0.95 - dt)
      o.oy = o.oy * (0.95 - dt)

      if o.die_on_stop and math.abs(o.ox) + math.abs(o.oy) < 0.01 then
        table.remove(objects, i)
      end
    end
  end
end

function obj_glide(o, dx, dy)
  o.x = o.x + dx
  o.y = o.y + dy
  o.ox = o.ox - dx
  o.oy = o.oy - dy
end

function obj_glide_and_flip(o, dx, dy)
  obj_glide(o, dx, dy)
  o.flip = dx == 0 and o.flip or dx < 0
end

function obj_glide_and_die(o, dx, dy)
  obj_glide(o, dx, dy)
  o.move = true
  o.die_on_stop = true
end

function obj_bump(o, dx, dy)
  o.ox = o.ox + dx / 2
  o.oy = o.oy + dy / 2
end

function obj_check_collision(obj, dx, dy)
  for _, o in ipairs(objects) do
    if obj ~= o and o.solid then
      local x = obj.x + dx
      local y = obj.y + dy
      local cx = o.x == x - (x % o.size)
      local cy = o.y == y - (y % o.size)
      if cx and cy then return o end
    end
  end
end

function obj_draw()
  local tile = 8 * scale

  for _, o in ipairs(objects) do
    local n = o.sprite
    if o.animate then
      n = n + math.floor(time % 2)
    end
    
    local x = (o.x + o.ox) * 8 * scale
    local y = (o.y + o.oy) * 8 * scale

    spr(n, x, y, o.flip)
    if o.size > 1 then
      spr(n + 8, x, y + tile)
      spr(n + 1, x + tile, y)
      spr(n + 9, x + tile, y + tile)
    end
  end
end
