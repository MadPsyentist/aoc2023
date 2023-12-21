-- read in the input
local input = {}
for line in io.lines("input") do
    input[#input + 1] = line
end

function score_card(card)
    local game, sum = card:sub(card:find(":") + 1, #card), 0
    local delim = game:find("|")
    local nColStart, nColEnd = game:find("[%d]+")
    while nColStart < delim do
        if game:sub(delim+1, #game):find("%s" .. game:sub(nColStart, nColEnd) .. "%s") ~= nil then
            if sum > 0 then 
                sum = sum * 2
            else 
                sum = 1 
            end
        end
        nColStart, nColEnd = game:find("[%d]+", nColEnd + 1)
    end
    return sum
end

function part1()
    local sum = 0
    -- sum = score_card(input[2])
    for k,v in ipairs(input) do
        sum = sum + score_card(v)
    end
    print("part 1: " .. sum)
end

function match_count(card)
    local game, sum = card:sub(card:find(":") + 1, #card), 0
    local delim = game:find("|")
    local nColStart, nColEnd = game:find("[%d]+")
    while nColStart < delim do
        if game:sub(delim+1, #game):find("%s" .. game:sub(nColStart, nColEnd) .. "%s") ~= nil then
            sum = sum + 1
        end
        nColStart, nColEnd = game:find("[%d]+", nColEnd + 1)
    end
    return sum
end

function part2()
    local sum = 0
    local cards = {}
    for k,v in ipairs(input) do 
        cards[k] = {}
        cards[k][1] = 0
        cards[k][2] = 1
    end
    for k,v in ipairs(input) do
        cards[k][1] = match_count(v)
        if cards[k][1] > 0 then
            for i=1,cards[k][1] do
                cards[k+i][2] = (cards[k+i][2] + cards[k][2])
            end
        end
        sum = sum + cards[k][2]
    end
    print("part 2: " .. sum)
end

part1()
part2()