function Get_input()
    local lines = {}
    for line in io.lines("input") do
        lines[#lines + 1] = line
    end
    return lines
end

function delete_game_id(line)
    return string.sub(line, string.find(line, ":")+2, #line)
end

function game_iter(game)
    local rounds = string.gmatch(delete_game_id(game), "[%d%a]+")
    return function()
        for seg in rounds do
            return {seg, rounds()}
        end
        return nil
    end
end 

function part1()
    local line = 0
    local sum = 0
    local Cubes = {red = 12, blue = 14, green = 13}
    for k,game in pairs(Get_input()) do
        local valid = true
        line = line + 1
        for round in game_iter(game) do
            -- print(round[1] .. " " .. round[2] .. " = " .. Cubes[round[2]])
            if tonumber(round[1]) > Cubes[round[2]] then
                valid = false
                break
            end
        end
        if valid == true then
            print(line)
            sum = sum + line
        end
    end
    return sum
end

function part2()
    local sum = 0
    for k,game in pairs(Get_input()) do
        local Cubes = {red = 0, blue = 0, green = 0}
        for round in game_iter(game) do
            if tonumber(round[1]) > Cubes[round[2]] then
                Cubes[round[2]] = tonumber(round[1])
            end
        end
        sum = sum + (Cubes["red"] * Cubes["green"] * Cubes["blue"])
    end
    return sum
end

print("part 1: " .. part1())
print("part 2: " .. part2())