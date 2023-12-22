-- need to use the bigint library
local bn=require"bn"
local input_tables = {{4,45},{48,96},{99,130},{133,179},{182,202},{205,241},{244,279}}
local example_tables = {{4,5},{8,10},{13,16},{19,20},{23,25}, {28,29}, {32,33}}
-- read in the input
local input = {}
for line in io.lines("input") do
    input[#input + 1] = line
end
local seeds = {}
for seed in input[1]:gmatch("[%d]+") do
    print("s: ", seed) 
    seeds[#seeds+1] = tonumber(seed)
end

local tables = {}
for k,v in ipairs(input_tables) do
    local soilTable = {}
    for i=v[1],v[2] do
        local range = {}
        for tv in input[i]:gmatch("[%d]+") do
            range[#range+1] = tonumber(tv)
        end
        soilTable[#soilTable+1] = range
    end
    tables[#tables+1] = soilTable
end

function translate_value(numb,soil_table)
    for k,v in ipairs(soil_table) do
        if numb >= v[2] and 
        numb <= (v[2] + v[3]) then
            print("soil range: " .. v[1], v[2], v[3])
            return v[1] + (numb - v[2])
        end 
    end
    print("soil range: miss")
    return numb
end

function part1()
    local location = bn.aprime(250)
    for k,v in ipairs(seeds) do
        print("===+===+===+===+===+===+===+===+===+===+===+===+===+===+===+===")
        print("SEED: " .. v)
        local current = v
        for i,t in ipairs(tables) do
            print("#" .. k, "seed: " .. v, "current: " .. current, "t#" .. i)
            current = translate_value(current,t)
        end
        print("current loc: ", location, "seed loc: ", current)
        if location > current then
            location = current
        end
    end
    print("part 1: " .. tostring(location))
end
part1()
