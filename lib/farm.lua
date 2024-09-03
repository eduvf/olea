function farm_create_tree(x, y, fruit)
  local tree = obj_create(17, x, y, 2)
  tree.is_tree = true
  tree.has = {
    obj_create(fruit, x + 0.5, y),
    obj_create(fruit, x, y + 0.5),
    obj_create(fruit, x + 1, y + 0.5)
  }
  return tree
end

function farm_is_tree(o)
  return o.is_tree
end

function farm_has_fruit(tree)
  return #tree.has > 0
end

function farm_collect_fruit(p, tree)
  for _, f in ipairs(tree.has) do
    local x = p.x - f.x
    local y = p.y - f.y
    obj_glide_and_die(f, x, y)
  end
end
