-- Screen resolution setting
local screenWidth, screenHeight = 640, 480
love.window.setMode(screenWidth, screenHeight)

-- Keyboard layout
local keyboard = {
    {'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J'},
    {'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T'},
    {'U', 'V', 'W', 'X', 'Y', 'Z', '1', '2', '3', '4'},
    {'5', '6', '7', '8', '9', '0', '_', '-', '.', '/'}
}

-- Games list
local games = {"Super Mario", "Super Metroid", "Mega Man", "Metroid Prime", "Sonic Adventure", "Super Smash Bros"}

-- Variables
local input_text = ""
local current_row, current_col = 1, 1
local search_mode = false
local selected_game_index = 1
local show_keyboard = true  -- Controls whether the keyboard is visible

function love.draw()
    if show_keyboard then
        draw_keyboard()
    else
        draw_game_menu()
    end
end

-- Function to draw the keyboard
function draw_keyboard()
    love.graphics.print("Keyboard:", 10, 10)
    local x_start = 20
    local y_start = 50
    for i, row in ipairs(keyboard) do
        for j, key in ipairs(row) do
            local x = x_start + (j - 1) * 40
            local y = y_start + (i - 1) * 40
            if i == current_row and j == current_col then
                love.graphics.rectangle("line", x - 5, y - 5, 30, 30) -- Highlight the current key
            end
            love.graphics.print(key, x, y)
        end
    end
    love.graphics.print("Entry: " .. input_text, 10, screenHeight - 30)
end

-- Function to draw the game menu
function draw_game_menu()
    love.graphics.print("Select a game:", 10, 10)
    for i, game in ipairs(games) do
        local y = 50 + (i - 1) * 30
        if i == selected_game_index then
            love.graphics.print("-> " .. game, 30, y) -- Highlight the current game
        else
            love.graphics.print(game, 50, y)
        end
    end
end

function love.keypressed(key)
    if show_keyboard then
        if key == "right" then
            current_col = current_col + 1
            if current_col > #keyboard[current_row] then current_col = 1 end
        elseif key == "left" then
            current_col = current_col - 1
            if current_col < 1 then current_col = #keyboard[current_row] end
        elseif key == "down" then
            current_row = current_row + 1
            if current_row > #keyboard then current_row = 1 end
        elseif key == "up" then
            current_row = current_row - 1
            if current_row < 1 then current_row = #keyboard end
        elseif key == "return" then
            input_text = input_text .. keyboard[current_row][current_col]
        elseif key == "backspace" then
            input_text = input_text:sub(1, -2)
        elseif key == "space" then
            input_text = input_text .. " "
        elseif key == "tab" then
            search_mode = true
            show_keyboard = false -- Hide the keyboard after pressing tab
        end
    else
        -- Game menu controls
        if key == "up" then
            selected_game_index = selected_game_index - 1
            if selected_game_index < 1 then selected_game_index = #games end
        elseif key == "down" then
            selected_game_index = selected_game_index + 1
            if selected_game_index > #games then selected_game_index = 1 end
        elseif key == "return" then
            -- When a game is selected, hide the keyboard
            search_mode = false
            love.graphics.print("Selected Game: " .. games[selected_game_index], 10, screenHeight - 30)
        elseif key == "b" then
            -- Return to the keyboard
            show_keyboard = true
        end
    end
end

