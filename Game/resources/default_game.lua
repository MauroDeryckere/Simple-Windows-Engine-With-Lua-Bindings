-- default_game.lua 
-- -> Game: Snake

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

game_engine:SetKeyList("WASD")

-- Gameplay variables
local game_over = false

local function Start_Game()
    snake:init()
end

Start_Game()

-- Functions called by the engine
function Tick()
    frame_ct = frame_ct + 1
    
    -- execute the rest of tick once per x amount of framees
    if frame_ct == config.game_speed then
        frame_ct = 0
    else
        return
    end

    if game_over then 
        return
    end

    snake.did_grow = true -- temporarily hard coded to grow indefinitely
    snake:move()
end

function CheckKeyboard()
    if game_engine:IsKeyDown(0x57) then  -- 0x57 is the virtual key code for 'W'
        -- Perform action for when 'W' is pressed, e.g., move the snake up
       -- snake:moveUp()  -- Example method for moving the snake up
        game_over = true
    end
end

function Paint(r)
    -- Clear sreen
    game_engine:SetColor(0)
    game_engine:FillRect(r)

    local window_left = r.left
    local window_top = r.top
    local window_right = r.right
    local window_bottom = r.bottom
    game_engine:SetColor(255)

    local body = snake:getBody()
    -- Draw the snake
    body:iterate(function(segment)
        local rect = { 
            left = window_left + segment.x * config.grid_size + 1, 
            top = window_top + segment.y * config.grid_size + 1, 
            right = window_left + (segment.x + 1) * config.grid_size - 2, 
            bottom = window_top + (segment.y + 1) * config.grid_size - 2
        }
        game_engine:FillRect(rect)
    end)
end

function KeyPressed(key)

end