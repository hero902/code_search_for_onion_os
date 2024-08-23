
local keyboard = {
    {'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J'},
    {'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T'},
    {'U', 'V', 'W', 'X', 'Y', 'Z', '1', '2', '3', '4'},
    {'5', '6', '7', '8', '9', '0', '_', '-', '.', '/'}
}

local games = {"Super Mario", "Super Metroid", "Mega Man", "Metroid Prime", "Sonic Adventure", "Super Smash Bros"}

local input_text = ""
local current_row, current_col = 1, 1
local search_mode = false
local selected_game_index = 1

local function draw_keyboard()
    print("Keyboard:")
    for i, row in ipairs(keyboard) do
        for j, key in ipairs(row) do
            if i == current_row and j == current_col then
                io.write("[" .. key .. "] ")  -- Zvýrazni aktuálny znak
            else
                io.write(" " .. key .. "  ")
            end
        end
        print()
    end
    print("\nEntry: " .. input_text)
end

-- Funkcia na vykreslenie výsledkov vyhľadávania
local function draw_search_results(matching_games)
    print("\nSearch Results:")
    for i, game in ipairs(matching_games) do
        if i == selected_game_index then
            print("> " .. game)  -- Zvýrazni aktuálnu hru
        else
            print("  " .. game)
        end
    end
end

local function main()
    while true do
        if not search_mode then
            draw_keyboard()
        else
            local matching_games = {}
            for _, game in ipairs(games) do
                if game:lower():find(input_text:lower()) then
                    table.insert(matching_games, game)
                end
            end

            draw_search_results(matching_games)

            if #matching_games > 0 then
                print("\nApply arrows on choice game, A for confirm , B for back.")
            else
                print("\nNo games found.")
            end
        end

        local key = io.read()

        if key == "up" and current_row > 1 then
            current_row = current_row - 1
        elseif key == "down" and current_row < #keyboard then
            current_row = current_row + 1
        elseif key == "left" and current_col > 1 then
            current_col = current_col - 1
        elseif key == "right" and current_col < #keyboard[1] then
            current_col = current_col + 1
        elseif key == "a" then
            input_text = input_text .. keyboard[current_row][current_col]
        elseif key == "b" then
            input_text = input_text:sub(1, -2)
        elseif key == "s" then
            search_mode = true
        elseif search_mode and key == "up" and selected_game_index > 1 then
            selected_game_index = selected_game_index - 1
        elseif search_mode and key == "down" and selected_game_index < #matching_games then
            selected_game_index = selected_game_index + 1
        elseif search_mode and key == "a" then
            print("\nYou selected game: " .. matching_games[selected_game_index])
            break
        elseif search_mode and key == "b" then
            search_mode = false
        elseif key == "esc" then
            break
        end
    end
end

menu_items = {
    { name = "Games", action = function() print("Loading Games...") end },
    { name = "RetroArch", action = function() print("Loading RetroArch...") end },
    { name = "Settings", action = function() print("Loading Settings...") end },
    { name = "Search", action = main } 
}

function load_main_menu()
    while true do
        print("Main menu:")
        for i, item in ipairs(menu_items) do
            print(i .. ". " .. item.name)
        end

        local choice = tonumber(io.read())

        if choice and menu_items[choice] then
            menu_items[choice].action()
        else
            print("No service with this number detected.")
        end
    end
end
load_main_menu()
