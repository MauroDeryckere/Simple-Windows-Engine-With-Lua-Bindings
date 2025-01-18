-- default_game.lua 
-- -> Game: Snake

print(_VERSION)
print("Lua package.path:", package.path, "\n\n")

-- File setup
local config = require("config")
local snake = require("snake")
local food = require("food")

local frame_ct = 0

-- Set up the game engine
game_engine:SetTitle("Lua powered Snake Game")
game_engine:SetWidth(config.screen_width)
game_engine:SetHeight(config.screen_height)
game_engine:SetFrameRate(config.frame_rate)

-- necessary to bind for key released event (otherwise pausing will not work as intended)
game_engine:SetKeyList(string.char(keybinds.pause))

-- Gameplay variables
local game_over = false
local is_paused = false

local function Start_Game()
    snake:init()
    food:init(config)
end

Start_Game()

-- Functions called by the engine
function Tick()
    if is_paused then 
        return
    end

    if game_over then 
        return
    end

    frame_ct = frame_ct + 1
    
    -- execute the rest of tick once per x amount of framees
    if frame_ct == config.game_speed then
        frame_ct = 0
    else
        return
    end

    local body = snake:getBody()
    local head = body:getBack()
    if food.position.x == head.x and food.position.y == head.y then
        snake.did_grow = true
        food:spawn()
    end

    snake:move()

    result = snake:checkCollision(config)
    if result then
        game_over = true
        return
    end
end

function CheckKeyboard()
    if game_over then
        return
    end
    
    if is_paused then 
        return
    end

    if game_engine:IsKeyDown(keybinds.moveUp) then
        snake:lookUp()
    end
    if game_engine:IsKeyDown(keybinds.moveDown) then
        snake:lookDown()
    end
    if game_engine:IsKeyDown(keybinds.moveLeft) then
        snake:lookLeft()
    end
    if game_engine:IsKeyDown(keybinds.moveRight) then
        snake:lookRight()
    end
end

local function makeColor(r, g, b)
    return (b << 16) | (g << 8) | r
end

function Paint(r)
    local RED =  makeColor(255, 0, 0)
    local LIGHT_RED =  makeColor(100, 10, 10)
    local GREEN = makeColor(30, 200, 10)
    local BROWN = makeColor(165, 42, 42)
    local BLUE = makeColor(10, 20, 200)
    
    -- Clear sreen
    game_engine:SetColor(0)
    game_engine:FillRect(r)

    local window_left = r.left
    local window_top = r.top
    local window_right = r.right
    local window_bottom = r.bottom

    -- Draw the map
    game_engine:SetColor(LIGHT_RED)
    -- Loop through each cell in the grid
    for x = 0, config.hor_cells - 1 do  -- Assuming grid width is config.grid_width
        for y = 0, config.ver_cells - 1 do  -- Assuming grid height is config.grid_height
            -- Calculate the rectangle coordinates for the cell at (x, y)
            local cell = { 
                left = window_left + x * config.grid_size, 
                top = window_top + y * config.grid_size, 
                right = window_left + (x + 1) * config.grid_size, 
                bottom = window_top + (y + 1) * config.grid_size
            }
            -- Draw the rectangle for the current cell
            game_engine:DrawRect(cell)
        end
    end
    game_engine:SetColor(RED)
    game_engine:DrawRect(r)


    game_engine:SetColor(GREEN)

    local body = snake:getBody()
    -- Draw the snake
    body:iterate(function(segment, index)
        local rect = { 
            left = window_left + segment.x * config.grid_size + 1, 
            top = window_top + segment.y * config.grid_size + 1, 
            right = window_left + (segment.x + 1) * config.grid_size - 2, 
            bottom = window_top + (segment.y + 1) * config.grid_size - 2
        }
        if index == body.last then  
            game_engine:SetColor(BROWN)
        end
        game_engine:FillRect(rect)
    end)

    -- Draw the food
    if food.position.x > -1 then
        game_engine:SetColor(BLUE)
        local oval = { 
            left = window_left + food.position.x * config.grid_size + 1, 
            top = window_top + food.position.y * config.grid_size + 1, 
            right = window_left + (food.position.x + 1) * config.grid_size - 2, 
            bottom = window_top + (food.position.y + 1) * config.grid_size - 2
        }
        game_engine:FillOval(oval)
    end
end

function KeyPressed(key)
    print(key)

    if key == string.char(keybinds.pause) then
        if is_paused then
            is_paused = false
        else
            print("PAUSED THE GAME! ")
            is_paused = true
        end 
    end
 end