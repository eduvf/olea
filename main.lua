function love.load()
  love.graphics.setDefaultFilter('nearest')
  require('src/id')
  require('src/lib')
  require('src/gfx')
  require('src/act')

  game = {
    time = 0,
    scale = 6,
    actors = {}
  }

  player = create_actor(CHAR_1, 0, 0)
  print(player.spr)
  table.insert(game.actors, player)
end

function love.keypressed(_, ch)
  local x, y = 0, 0
  if ch == 'w' or ch == 'up' then y = y - 1 end
  if ch == 's' or ch == 'down' then y = y + 1 end
  if ch == 'a' or ch == 'left' then x = x - 1 end
  if ch == 'd' or ch == 'right' then x = x + 1 end

  player.x = player.x + x
  player.y = player.y + y
  player.flip = x == 0 and player.flip or x < 0
end

function love.update(dt)
  game.time = game.time + dt
end

function love.draw()
  draw_actors()
end
