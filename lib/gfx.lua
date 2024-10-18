function gfx_load()
  love.graphics.setDefaultFilter('nearest')

  id_player   = 1

  id_tree     = 17
  id_palm     = 19

  id_door     = 21
  id_roof     = 22
  id_wall     = 23
  id_sign     = 24
  id_bed      = 29
  id_closet   = 30
  id_table    = 31
  id_chest    = 32

  id_club     = 33
  id_cup      = 34
  id_coin     = 35
  id_sword    = 36

  id_apple    = 49
  id_orange   = 53
  id_cherry   = 57
  id_peach    = 61

  id_soil_dry = 73
  id_soil_wet = 74

  id_rupee_1  = 75
  id_rupee_5  = 76
  id_rupee_20 = 77

  id_wheat    = 81
  id_parsnip  = 89
  id_potato   = 97
  id_carrot   = 105
  id_corn     = 113
  id_tomato   = 121

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
  print(n)
  love.graphics.draw(image, quad[n], x, y, 0, sx, scale, ox)
end

function gfx_fade(alpha)
  local w, h = love.graphics.getDimensions()
  love.graphics.setColor(0, 0, 0, alpha)
  love.graphics.rectangle('fill', 0, 0, w, h)
  love.graphics.setColor(1, 1, 1)
end
