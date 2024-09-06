function gfx_load()
  love.graphics.setDefaultFilter('nearest')

  local char_set = (
    ' !"#$%&\'()*+,-./' ..
    '0123456789:;<=>?' ..
    '@abcdefghijklmno' ..
    'pqrstuvwxyz')
  font = love.graphics.newImageFont('font.png', char_set, 1)
  love.graphics.setFont(font)

  image = love.graphics.newImage('gfx.png')
  quad = {}
  local w, h = image:getDimensions()

  for y = 0, h - 1, 8 do
    for x = 0, w - 1, 8 do
      table.insert(quad, love.graphics.newQuad(x, y, 8, 8, image))
    end
  end
end

function spr(n, x, y, flip)
  local sx, ox = scale, 0
  if flip then
    sx, ox = -scale, 8
  end
  love.graphics.draw(image, quad[n], x, y, 0, sx, scale, ox)
end

function gfx_fade(alpha)
  local w, h = love.graphics.getDimensions()
  love.graphics.setColor(0, 0, 0, alpha)
  love.graphics.rectangle('fill', 0, 0, w, h)
  love.graphics.setColor(1, 1, 1)
end
