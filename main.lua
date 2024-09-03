function love.load()
  scale = 6
  time = 0

  require('lib/gfx')
  gfx_load()

  require('lib/obj')
  obj_load()
  player = obj_create(1, 0, 0, 1, true)
  obj_create(17, 2, 2, 2)
end

function love.keypressed(_, ch)
  local x, y = 0, 0
  if ch == 'w' or ch == 'up' then y = y - 1 end
  if ch == 's' or ch == 'down' then y = y + 1 end
  if ch == 'a' or ch == 'left' then x = x - 1 end
  if ch == 'd' or ch == 'right' then x = x + 1 end
  
  local o = obj_check_collision(player, x, y)
  if o ~= nil then
    obj_bump(player, x, y)
  else
    obj_glide_and_flip(player, x, y)
  end
end

function love.update(dt)
  obj_update(dt)
  time = time + dt
end

function love.draw()
  obj_draw()
end
