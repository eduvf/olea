function serialize(t)
  if type(t) == 'table' then
    local kv_pairs = {}

    for k, v in pairs(t) do
      table.insert(kv_pairs, '['..serialize(k)..']='..serialize(v))
    end
    return '{'..table.concat(kv_pairs, ',')..'}'
  elseif type(t) == 'string' then
    return string.format('%q', t)
  elseif type(t) == 'number' or type(t) == 'boolean' then
    return tostring(t)
  end

  return 'nil'
end

function save()
  local ok, err = love.filesystem.write('save.lua', 'return '..serialize(game))

  if not ok then
    print('ERROR SAVING: '..err)
  end
end

function load()
  local fn, err = love.filesystem.load('save.lua')
  
  if type(fn) ~= 'function' then
    print('ERROR LOADING: '..err)
  end

  game = fn()
  player = game.actors[1]
end
