function gfx_load()
  love.graphics.setDefaultFilter('nearest')

  image = love.graphics.newImage('gfx.png')
  quad = {}
  local w, h = image:getDimensions()

  for y = 0, h - 1, 8 do
    for x = 0, w - 1, 8 do
      table.insert(quad, love.graphics.newQuad(x, y, 8, 8, image))
    end
  end
end

function spr(n, x, y)
  love.graphics.draw(image, quad[n], x, y, 0, scale, scale)
end
