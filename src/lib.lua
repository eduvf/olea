function all(t)
  local i = 0
  return function()
    i = i + 1
    if i <= #t then
      return t[i]
    end
  end
end

function random(t)
  return t[love.math.random(#t)]
end

function in_range(n, min, max)
  return min <= n and n <= max
end
