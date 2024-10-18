function love.load()
  scale = 6
  time = 0
  cam = { x = 0, y = 0 }

  math.randomseed(os.time())

  require('lib/gfx')
  gfx_load()

  require('lib/obj')
  obj_load()
  player = obj_create(id_player, 0, 0, 1, true, false, true)

  obj_create(id_wall, 4, -6, 1, false, true)
  obj_create(id_wall, 5, -6, 1, false, true)
  obj_create(id_wall, 6, -6, 1, false, true)
  obj_create(id_wall, 7, -6, 1, false, true)
  obj_create(id_wall, 8, -6, 1, false, true)
  obj_create(id_wall, 4, -5, 1, false, true)
  obj_create(id_wall, 4, -4, 1, false, true)
  obj_create(id_wall, 4, -3, 1, false, true)
  obj_create(id_wall, 4, -2, 1, false, true)
  obj_create(id_wall, 5, -2, 1, false, true)
  obj_create(id_wall, 6, -2, 1, false, true)
  obj_create(id_wall, 8, -5, 1, false, true)
  obj_create(id_wall, 8, -4, 1, false, true)
  obj_create(id_wall, 8, -3, 1, false, true)
  obj_create(id_wall, 8, -2, 1, false, true)

  local bed = obj_create(id_bed, 6, -5, 1, false, true)
  local door = obj_create(id_door, 7, -2, 1, false, false)
  local sign = obj_create(id_sign, 8, -1, 1, false, true)
  local table = obj_create(id_table, 5, -3, 1, false, true)
  local chest = obj_create(id_chest, 7, -5, 1, false, true)
  local closet = obj_create(id_closet, 5, -5, 1, false, true)

  obj_set_tag(bed, 'bed')
  obj_set_tag(sign, 'sign')
  obj_set_tag(table, 'table')
  obj_set_tag(closet, 'closet')

  require('lib/dlg')
  dlg_load()

  require('lib/inv')
  inv_load()
  inv_add(id_wheat)
  inv_add(id_parsnip)
  inv_add(id_tomato)

  require('lib/farm')
  farm_load()
  farm_create_tree(2, 2, id_apple + 3)
  farm_create_tree(5, 2, id_orange + 3)
  farm_create_tree(8, 2, id_peach + 3)
end

function love.keypressed(_, ch)
  local x, y = 0, 0
  if ch == 'w' or ch == 'up' then y = y - 1 end
  if ch == 's' or ch == 'down' then y = y + 1 end
  if ch == 'a' or ch == 'left' then x = x - 1 end
  if ch == 'd' or ch == 'right' then x = x + 1 end

  if dlg_is_dialog_open() then
    dlg_close()
    return
  end

  if love.keyboard.isDown('i') then
    inv_move_cursor(x)
    return
  end

  local o = obj_check_collision(player, x, y)
  if o ~= nil then
    obj_bump(player, x, y)
    if farm_is_tree(o) and farm_has_fruit(o) then
      farm_collect_fruit(player, o)
    elseif obj_get_tag(o) == 'bed' then
      farm_grow_crops()
    elseif obj_get_tag(o) == 'sign' then
      dlg_open('im a sign!\n\nthis is a test house, so take care of it, okay?')
    elseif obj_get_tag(o) == 'table' then
      if obj_has_sprite_on_top(o) then
        inv_add(obj_remove_sprite_on_top(o))
      else
        obj_set_sprite_on_top(o, inv_remove())
      end
    elseif obj_get_tag(o) == 'closet' then
      local n = (obj_get_sprite(player) + 2) % 8
      obj_set_sprite(player, n)
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
  inv_update(dt)
  dlg_update()

  local wx, wy = love.graphics.getDimensions()
  cam.x = cam.x + (wx / 2 - 4 * scale - player.x * 8 * scale - cam.x) * 0.8 * dt
  cam.y = cam.y + (wy / 2 - 4 * scale - player.y * 8 * scale - cam.y) * 0.8 * dt

  time = time + dt
end

function love.draw()
  love.graphics.translate(cam.x, cam.y)
  obj_draw()
  love.graphics.origin()
  if love.keyboard.isDown('i') then
    inv_draw()
  end
  if dlg_is_dialog_open() then
    dlg_draw()
  end
end
