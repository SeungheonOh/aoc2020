function loadTerrain(file)
  local terrain = {}
  local linecount = 0
  for line in io.lines(file) do
    for char in line:gmatch(".") do 
      terrain[#terrain + 1] = char == "#"
    end
    linecount = linecount + 1
  end
  return terrain, linecount
end

function isTree(terrain, x, y) 
  -- 1 .. 31
  return terrain[((x-1) % 31) + (y-1) * 31 + 1]
end

function ride(terrain, dx, dy)
  local x = 1
  local y = 1
  local hit = 0

  for i = 1, linecount do 
    if isTree(terrain, x, y) then hit = hit + 1 end
    x = x + dx 
    y = y + dy
  end

  return hit
end

width = 31
terrain, linecount = loadTerrain("3.in")

print(ride(terrain, 3, 1))

print(ride(terrain, 1, 1) * ride(terrain, 3, 1) * ride(terrain, 5, 1) * 
    ride(terrain, 7, 1) * ride(terrain, 1, 2))
