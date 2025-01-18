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

-- Gameplay variables
local game_over = false

-- Functions called by the engine
function Tick()
    if game_over then 
        return
    end

    game_over = true
end

function Paint(r)
    game_engine:SetColor(255)

    local window_left = r.left
    local winddow_top = r.top
    local window_right = r.right
    local wiindow_bottom = r.bottom

    local rect = 
    { 
        left = window_left + 100, 
        top = winddow_top - 100, 
        right = window_right - 200,
        bottom = wiindow_bottom + 200 
    
    }
    game_engine:FillRect(rect)
end

function KeyPressed(key)

end