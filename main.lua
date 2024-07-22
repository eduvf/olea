function love.load()
  love.graphics.setDefaultFilter('nearest')
  require('src/id')
  require('src/lib')
  require('src/gfx')
  require('src/map')
  require('src/act')
  require('src/save')
  require('src/farm')

  win = {}
  win.w, win.h = love.graphics.getDimensions()

  game = {
    cam = {x = win.w / 2, y = win.h / 2},
    map = {
      w = win.w / 8 / 6,
      h = win.h / 8 / 6,
      ground = {},
      crops = {},
      wall = {}
    },
    time = 0,
    scale = 6,
    actors = {}
  }

  generate_map()

  player = create_actor(CHAR_1, 0, 0)
  add_actor(player)

  local tree_1 = create_actor(TREES[1], 0, 4, 0, 0, false, 2)
  add_actor(tree_1)

  add_link_actor(tree_1, create_actor(CROPS[2].ITEM, 0, 4, 0.5, 0, false))
  add_link_actor(tree_1, create_actor(CROPS[2].ITEM, 0, 4, 0, 0.5, false))
  add_link_actor(tree_1, create_actor(CROPS[2].ITEM, 0, 4, 1, 0.5, false))

  local tree_2 = create_actor(TREES[1], 4, 4, 0, 0, false, 2)
  add_actor(tree_2)

  add_link_actor(tree_2, create_actor(CROPS[2].ITEM, 4, 4, 0.5, 0, false))
  add_link_actor(tree_2, create_actor(CROPS[2].ITEM, 4, 4, 0, 0.5, false))
  add_link_actor(tree_2, create_actor(CROPS[2].ITEM, 4, 4, 1, 0.5, false))

  local tree_3 = create_actor(TREES[2], 8, 4, 0, 0, false, 2)
  add_actor(tree_3)

  add_link_actor(tree_3, create_actor(CROPS[2].ITEM, 8, 4, 0.5, 0, false))
  add_link_actor(tree_3, create_actor(CROPS[2].ITEM, 8, 4, 0, 0.5, false))
  add_link_actor(tree_3, create_actor(CROPS[2].ITEM, 8, 4, 1, 0.5, false))
end

function love.resize()
  win.w, win.h = love.graphics.getDimensions()
end

function love.keypressed(_, ch)
  if ch == 'r' then love.event.push('quit', 'restart') end

  local x, y = 0, 0
  if ch == 'w' or ch == 'up' then y = y - 1 end
  if ch == 's' or ch == 'down' then y = y + 1 end
  if ch == 'a' or ch == 'left' then x = x - 1 end
  if ch == 'd' or ch == 'right' then x = x + 1 end

  local act = check_collision(player, x, y)
  if act ~= nil then
    player.ox = player.ox + x / 2
    player.oy = player.oy + y / 2
    if act.spr == TREES[1] or act.spr == TREES[2] then
      harvest_tree(act)
    end
  else
    player.x = player.x + x
    player.y = player.y + y
    player.ox = player.ox - x
    player.oy = player.oy - y
  end
  player.flip = x == 0 and player.flip or x < 0

  if ch == 'space' then
    farm_action(player.x + 1, player.y + 1)
  end

  if ch == 'n' then next_day() end

  if ch == '1' then player.spr = CHAR_1 end
  if ch == '2' then player.spr = CHAR_2 end
  if ch == '3' then player.spr = CHAR_3 end
  if ch == '4' then player.spr = NPC_1 end

  if love.keyboard.isScancodeDown('lctrl') then
    if ch == 's' then
      save()
    elseif ch == 'l' then
      load()
    end
  end
end

function love.update(dt)
  game.time = game.time + dt

  update_actors(dt)

  local tile = 8 * game.scale
  local diff_x = win.w / 2 - tile / 2 - player.x * tile - game.cam.x
  local diff_y = win.h / 2 - tile / 2 - player.y * tile - game.cam.y
  game.cam.x = game.cam.x + diff_x * 2 * dt
  game.cam.y = game.cam.y + diff_y * 2 * dt 
end

function love.draw()
  love.graphics.translate(game.cam.x, game.cam.y)

  draw_map()
  draw_actors()

  love.graphics.origin()
end
