-- read in the input
local input = {}
for line in io.lines("input") do
    input[#input + 1] = line
end

function clamp(min, max)
    return function (numb)
        if numb < min then return min
        elseif numb > max then return max 
        end
        return numb
    end
end

inputClamp = clamp(1, #input)
lineClamp = clamp(1, 140)

function is_symbol_adjacent(nline, nColStart, nColEnd)
    local i = -1
    repeat
        local substring = input[inputClamp(nline + i)]:sub(lineClamp(nColStart - 1), lineClamp(nColEnd + 1))
        if substring:find("[^%w.]") ~= nil then return true end
        i = i + 1
    until i > 1
    return false
end

local sum = 0;
for i,line in ipairs(input) do
    local nstart, nend = line:find("[%d]+")
    repeat
        if nstart ~= nil and is_symbol_adjacent(i, nstart, nend) then
            sum = sum + tonumber(line:sub(nstart, nend))
        end
        nstart, nend = line:find("[%d]+", nend + 1)
    until nend == nil
end
print(sum)