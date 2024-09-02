function love.load()
  scale = 6
  time = 0

  require('lib/gfx')
  gfx_load()

  require('lib/obj')
  obj_load()
  player = obj_create(1, 0, 0, true)
end

function love.keypressed(_, ch)
  local x, y = 0, 0
  if ch == 'w' or ch == 'up' then y = y - 1 end
  if ch == 's' or ch == 'down' then y = y + 1 end
  if ch == 'a' or ch == 'left' then x = x - 1 end
  if ch == 'd' or ch == 'right' then x = x + 1 end
  obj_glide(player, x, y)
end

function love.update(dt)
  obj_update(dt)
  time = time + dt
end

function love.draw()
  obj_draw()
end
