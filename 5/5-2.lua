function open(file) 
  local data = {}
  for line in io.lines(file) do
    data[#data + 1] = line
  end
  return data
end

function round(x)
  return x>=0 and math.floor(x+0.5) or math.ceil(x-0.5)
end

function parseRow(str) 
  local s = 0 
  local e = 127
  local m
  for i = 1, #str do 
     m = round((e - s) / 2)
    if str:sub(i, i) == "F" then
      e = e - m
    elseif str:sub(i, i) == "B" then
      s = s + m
    end
  end
  return s
end

function parseCol(str) 
  local s = 0 
  local e = 8
  local m
  for i = 1, #str do 
     m = round((e - s) / 2)
    if str:sub(i, i) == "L" then
      e = e - m
    elseif str:sub(i, i) == "R" then
      s = s + m
    end
  end
  return s
end

function eval(str) 
  row = parseRow(str:sub(1, 7))
  col = parseCol(str:sub(8, 10))
  return row * 8 + col
end

data = open("5.in")

list = {} 
for _, s in pairs(data) do list[#list + 1] = eval(s) end 

table.sort(list)

for i, e in pairs(list) do
  local prev = list[i-1]
  if prev ~= nil and e - prev ~= 1 then
    print(math.floor((e + prev)/2))
  end
end
