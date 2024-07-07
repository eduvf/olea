function love.load()
  love.graphics.setDefaultFilter('nearest')
  require('src/id')
  require('src/lib')
  require('src/gfx')
  require('src/act')
  require('src/save')

  game = {
    time = 0,
    scale = 6,
    actors = {}
  }

  player = create_actor(CHAR_1, 0, 0)
  table.insert(game.actors, player)

  table.insert(game.actors, create_actor(TREES[1], 4, 4, 0, 0, false, 2))
  table.insert(game.actors, create_actor(CROPS[3][1], 4, 4, 0.5, 0, false))
  table.insert(game.actors, create_actor(CROPS[3][1], 4, 4, 0, 0.5, false))
  table.insert(game.actors, create_actor(CROPS[3][1], 4, 4, 1, 0.5, false))
end

function love.keypressed(_, ch)
  local x, y = 0, 0
  if ch == 'w' or ch == 'up' then y = y - 1 end
  if ch == 's' or ch == 'down' then y = y + 1 end
  if ch == 'a' or ch == 'left' then x = x - 1 end
  if ch == 'd' or ch == 'right' then x = x + 1 end

  if check_collision(player, x, y) then
    player.ox = player.ox + x / 2
    player.oy = player.oy + y / 2
  else
    player.x = player.x + x
    player.y = player.y + y
    player.ox = player.ox - x
    player.oy = player.oy - y
  end
  player.flip = x == 0 and player.flip or x < 0

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
end

function love.draw()
  draw_actors()
end
