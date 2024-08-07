local image = love.graphics.newImage('gfx.png')
local width, height = image:getDimensions()
local quad = {}

for y = 0, height - 1, 8 do
  for x = 0, width - 1, 8 do
    table.insert(quad, love.graphics.newQuad(x, y, 8, 8, image))
  end
end

function draw_sprite(n, x, y, flip, scale)
  local scale = scale or game.scale
  local sx, ox = scale, 0
  if flip then
    sx, ox = -scale, 8
  end
  love.graphics.draw(image, quad[n], x, y, 0, sx, scale, ox)
end
