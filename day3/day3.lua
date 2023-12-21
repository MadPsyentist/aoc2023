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

function part1()
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
    print("part1: " .. sum)
end

function find_adjacent_numbs(nLine, nCol)
    local i, numbs = -1, {}
    while i < 2 do
        local nColStart, nColEnd = input[nLine + i]:find("[%d]+")
        while nColEnd ~= nil do
            if (nColStart <= lineClamp(nCol + 1) and nColStart >= lineClamp(nCol - 1)) 
            or (nColEnd <= lineClamp(nCol + 1) and nColEnd >= lineClamp(nCol - 1)) then
                numbs[#numbs + 1] = tonumber(input[nLine + i]:sub(nColStart, nColEnd))
            end
            nColStart, nColEnd = input[nLine + i]:find("[%d]+", nColEnd + 1)
        end
        i = i + 1
    end
    return numbs
end

function merge(table1, table2)
    for k,v in ipairs(table2) do
        table1[#table1 + k] = v
    end
    return table1
end

function part2()
    local sum = 0
    for i,line in ipairs(input) do
        local nColStart, nColEnd = line:find("*")
        while nColEnd ~= nil do
            local numbs = find_adjacent_numbs(i,nColStart)
            if numbs ~= nil and #numbs == 2 then
                sum = sum + (numbs[1] * numbs[2])
            end
            nColStart, nColEnd = line:find("*", nColEnd + 1)
        end
    end
    print("part 2: " .. sum)
end

part1()
part2()