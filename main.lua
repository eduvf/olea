function love.load()
  scale = 6
  time = 0
  cam = { x = 0, y = 0 }

  require('lib/gfx')
  gfx_load()

  require('lib/obj')
  obj_load()
  player = obj_create(1, 0, 0, 1, true)
  
  require('lib/farm')
  farm_load()
  farm_create_tree(2, 2, 9)
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
    if farm_is_tree(o) and farm_has_fruit(o) then
      farm_collect_fruit(player, o)
    end
  else
    obj_glide_and_flip(player, x, y)
  end

  if ch == 'space' then
    farm_till_plant_water_harvest(player.x, player.y)
  end
  if ch == 'g' then
    farm_grow_crops()
  end
end

function love.update(dt)
  obj_update(dt)

  local wx, wy = love.graphics.getDimensions()
  cam.x = cam.x + (wx / 2 - 4 * scale - player.x * 8 * scale - cam.x) * 0.01
  cam.y = cam.y + (wy / 2 - 4 * scale - player.y * 8 * scale - cam.y) * 0.01

  time = time + dt
end

function love.draw()
  love.graphics.translate(cam.x, cam.y)
  obj_draw()
end
