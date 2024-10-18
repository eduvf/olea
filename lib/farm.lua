function farm_load()
  field = {}
  max_growth_per_crop = {
    [id_wheat] = 5,
    [id_parsnip] = 4,
    [id_potato] = 5,
    [id_carrot] = 5,
    [id_corn] = 6,
    [id_tomato] = 6
  }
end

function farm_create_tree(x, y, fruit)
  local tree = obj_create(id_tree, x, y, 2, false, true)
  tree.is_tree = true
  tree.has = {
    obj_create(fruit, x + 0.5, y, 1, false, false, true),
    obj_create(fruit, x, y + 0.5, 1, false, false, true),
    obj_create(fruit, x + 1, y + 0.5, 1, false, false, true)
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
    inv_add(obj_get_sprite(f))
  end
  tree.has = {}
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
    soil = obj_create(id_soil_dry, x, y)
    soil.is_wet = false
    soil.growth = 0
    table.insert(field, soil)
  elseif soil.growth == 0 then
    -- plant seed
    if max_growth_per_crop[inv_current_item()] then
      soil.seed = inv_remove()
      soil.growth = 1
      soil.max_growth = max_growth_per_crop[soil.seed]
      obj_set_sprite_on_top(soil, soil.seed + 1)
      obj_set_flip(soil, math.random() < 0.5)
    end
  elseif soil.growth == soil.max_growth then
    -- harvest
    soil.growth = 0
    obj_remove_sprite_on_top(soil)
    local crop = obj_create(soil.seed + 7, soil.x, soil.y)
    inv_add(obj_get_sprite(crop))
    obj_glide_and_die(crop, 0, -1)
  elseif not soil.is_wet then
    -- water crop
    soil.is_wet = true
    obj_set_sprite(soil, id_soil_wet)
  end
end

function farm_grow_crops()
  for _, soil in ipairs(field) do
    if soil.is_wet and soil.growth < soil.max_growth then
      soil.is_wet = false
      obj_set_sprite(soil, id_soil_dry)
      soil.growth = math.min(soil.growth + 1, soil.max_growth)
      obj_set_sprite_on_top(soil, soil.seed + soil.growth)
    end
  end
end
