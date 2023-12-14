function Get_input()
    local lines = {}
    for line in io.lines("input") do
        lines[#lines + 1] = line
    end
    return lines
end

function split (input, sep)
    if sep == nil then
            sep = "%s"
    end
    local t={}
    for str in string.gmatch(input, "([^"..sep.."]+)") do
            table.insert(t, str)
    end
    return t
end

function delete_game_id(line)
    return string.sub(line, string.find(line, ":")+2, #line)
end

Cubes = {"red", "blue", "green", red = 12, green = 13, blue = 14}

function trim(s)
    return (s:gsub("^%s*(.-)%s*$", "%1"))
end

function cube_count(round, colour)
    for key, group in pairs(split(round, ",")) do
        if group:find(colour) ~= nil then
            return tonumber(split(trim(group), " ")[1])
        end
    end
    return 0
end

function validate_game_round(round)

end

for key, line in pairs(Get_input()) do
    print(delete_game_id(line))
    for key,game in pairs(split(delete_game_id(line), ";")) do
            split(game, ",")
    end
end

