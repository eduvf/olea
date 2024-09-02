function love.load()
  scale = 6
  time = 0

  require('lib/gfx')
  gfx_load()
end

function love.update(dt)
  time = time + dt
end

function love.draw()
  spr(1 + math.floor(time % 2))
end
