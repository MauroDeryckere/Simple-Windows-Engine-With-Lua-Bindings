-- default_game.lua 
-- -> Game: Snake

print("Lua package.path:", package.path, "\n\n")

-- File setup
local config = require("config")
local snake = require("snake")
local food = require("food")

-- Set up the game engine
game_engine:SetTitle("Lua powered Snake Game")
game_engine:SetWidth(config.screen_width)
game_engine:SetHeight(config.screen_height)
game_engine:SetFrameRate(config.frame_rate)

-- TODO: set key list


-- Gameplay variables
local game_over = false

local function Start_Game()
    snake:init()
end

Start_Game()

-- Functions called by the engine
function Tick()
    snake:move()


    if game_over then 
        return
    end


    -- game_over = true
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