function parse(str) 
  local group = {}
  for part in str:gmatch("[^%s]+") do
    local p = {}
    for s in string.gmatch(part, "[^:]+") do p[#p + 1] = s end
    group[p[1]] = p[2]
  end
  return group;
end

function load(file) 
  local data = {}
  local f = io.open(file)
  local s = f:read("*a")
  f:close()

  local tmp = ""
  for line in s:gmatch("[^\n]*") do
    if line == "" then 
      data[#data + 1] = parse(tmp)
      tmp = ""
    end
    tmp = tmp .. " " .. line
  end

  return data
end

function check(req, data) 
  for _, key in pairs(req) do 
    if data[key] == nil then 
      return false
    end
  end
  return true
end

function hasValue(arr, key) 
  if key == "utc" then print("here") end
  for _, e in pairs(arr) do if key == e then return true end end
  return false
end

function isValidHex(str)
  local valids = {"0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "a", "b", "c", "d", "e", "f"}
  local low = str:lower()
  for i = 1, #str do
    if not hasValue(valids, low:sub(i, i)) then 
      print(low:sub(i, i))
      return false
    end
  end
  return true
end

function checkFormat(data) 
  if #tostring(data["byr"]) ~= 4 or tonumber(data["byr"]) < 1920 or tonumber(data["byr"]) > 2002 then return false end
  if #tostring(data["iyr"]) ~= 4 or tonumber(data["iyr"]) < 2010 or tonumber(data["iyr"]) > 2020 then return false end
  if #tostring(data["eyr"]) ~= 4 or tonumber(data["eyr"]) < 2020 or tonumber(data["eyr"]) > 2030 then return false end
  local hgt = tostring(data["hgt"])
  local mes = hgt:sub(#hgt - 1, #hgt)
  local actlen = tonumber(hgt:sub(0, #hgt - 2))
  if mes == "in" then if actlen < 59 or actlen > 76 then return false end
  elseif mes == "cm" then if actlen < 150 or actlen > 193 then return false end 
  else return false end
  if #tostring(data["hcl"]) ~= 7 or tostring(data["hcl"]):sub(1,1) ~= "#" or not isValidHex(tostring(data["hcl"]):sub(2, 7)) then return false end
  if not hasValue({"amb", "blu", "brn", "gry", "grn", "hzl", "oth"}, data["ecl"]) then return false end
  if #tostring(data["pid"]) ~= 9 then return false end
  return true
end

data = load("4.in")

countP1 = 0
countP2 = 0

for _, d in pairs(data) do 
  if check({"byr", "iyr", "eyr", "hgt", "hcl", "ecl", "pid"}, d) then 
    countP1 = countP1 + 1 
    if checkFormat(d)  then countP2 = countP2 + 1 end
  end
end

print(countP1)
print(countP2)
