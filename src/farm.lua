function harvest_tree(tree)
  for fruit in all(tree.links) do
    fruit.move = true
    fruit.die_on_stop = true
    fruit.ox = fruit.x + fruit.ox - game.actors[1].x
    fruit.oy = fruit.y + fruit.oy - game.actors[1].y
    fruit.x = game.actors[1].x
    fruit.y = game.actors[1].y
  end
end
