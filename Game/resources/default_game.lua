-- default_game.lua 
-- -> Game: Snake

print("Lua package.path:", package.path, "\n\n")

-- File setup
local config = require("config")
-- local snake = require("snake")
-- local food = require("food")

-- Set up the game engine
game_engine:SetTitle("Lua powered Snake Game")
game_engine:SetWidth(config.screen_width)
game_engine:SetHeight(config.screen_height)
game_engine:SetFrameRate(config.frame_rate)

-- Gameplay variables
local snake = 
{
    body = { { x = 5, y = 5 } }, -- Snake starts with one segment
    direction = { x = 1, y = 0 } -- Moving right initially
}

local food = { x = 10, y = 10 } -- Food position
local game_over = false

-- Functions called by the engine
local function MoveSnake()

end
function Tick()
    print("test")
end

function Paint()

end
