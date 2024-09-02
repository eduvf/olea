function love.load()
  scale = 6
  time = 0

  require('lib/gfx')
  gfx_load()

  require('lib/obj')
  obj_load()
  player = obj_create(1, 0, 0, true)
end

function love.update(dt)
  obj_update(dt)
  time = time + dt
end

function love.draw()
  obj_draw()
end
