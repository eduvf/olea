function farm_load()
  field = {}
  max_growth_per_crop = {
    [41] = 5,
    [49] = 6,
    [57] = 4
  }
end

function farm_create_tree(x, y, fruit)
  local tree = obj_create(17, x, y, 2, false, true)
  tree.is_tree = true
  tree.has = {
    obj_create(fruit, x + 0.5, y, 1, false, false, true),
    obj_create(fruit, x, y + 0.5, 1, false, false, true),
    obj_create(fruit, x + 1, y + 0.5, 1, false, false, true)
  }
  return tree
end

function farm_is_tree(o)
  if o ~= nil then return o.is_tree end
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

function farm_till_plant_water_harvest(x, y)
  local soil = nil
  for _, s in ipairs(field) do
    if s.x == x and s.y == y then
      soil = s
      break
    end
  end

  if soil == nil then
    -- till soil
    soil = obj_create(33, x, y)
    soil.is_wet = false
    soil.growth = 0
    table.insert(field, soil)
  elseif soil.growth == 0 then
    -- plant seed
    soil.seed = ({41, 49, 57})[math.random(3)]
    soil.growth = 1
    soil.max_growth = max_growth_per_crop[soil.seed]
    soil.crop = obj_create(soil.seed + 1, x, y)
  elseif soil.growth == soil.max_growth then
    -- harvest
    soil.growth = 0
    obj_set_sprite(soil.crop, soil.seed + 7)
    obj_glide_and_die(soil.crop, 0, -1)
    obj_always_in_front(soil.crop)
  elseif not soil.is_wet then
    -- water crop
    soil.is_wet = true
    obj_set_sprite(soil, 34)
  end
end

function farm_grow_crops()
  for _, soil in ipairs(field) do
    if soil.is_wet and soil.growth < soil.max_growth then
      soil.is_wet = false
      obj_set_sprite(soil, 33)
      soil.growth = math.min(soil.growth + 1, soil.max_growth)
      obj_set_sprite(soil.crop, soil.seed + soil.growth)
    end
  end
end
