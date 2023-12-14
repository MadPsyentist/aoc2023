Digits = {"one", "two", "three", "four", "five", "six", "seven", "eight", "nine"}
for i = 1, #Digits do Digits[Digits[i]] = i end

function Get_input()
    local lines = {}
    for line in io.lines("input") do
        lines[#lines + 1] = line
    end
    return lines
end

function find_first_digit(line)
    for char in line:gmatch(".") do
        if tonumber(char) then return tonumber(char) end
    end
    return nil
end

function get_coords(line)
    local x = find_first_digit(line)
    local y = find_first_digit(string.reverse(line))
    return tonumber(x..y)
end

function get_coords2(line)
    local currentIndex = 100000
    local currentValue = 0 
    for key,digit in pairs(Digits) do
        local i = string.find(line, digit)
        if i == nil then goto continue end
        if i < currentIndex then
            currentIndex = i
            if tonumber(digit) then currentValue = digit else currentValue = Digits[digit] end
        end
        ::continue::
    end

    local x = currentValue
    currentIndex = 1000000
    for key,digit in pairs(Digits) do
        local i = string.find(string.reverse(line), string.reverse(digit))
        if i == nil then goto continue end
        if i < currentIndex then
            currentIndex = i
            if tonumber(digit) then currentValue = digit else currentValue = Digits[digit] end
        end
        ::continue::
    end
    return tonumber(x .. currentValue)
end

function step1()
    local sum = 0
    for key,line in pairs(Get_input()) do
        sum = sum + get_coords(line)
    end
    print(sum)
end

function step2()
    local sum = 0
    for key,line in pairs(Get_input()) do
        sum = sum + get_coords2(line)
    end
    print(sum)
end

step1()
step2()