-- food.lua

-- @class food
-- @field position {x: number, y: number} The current position of the food, -1 when not on screen
-- @field config table|null The current game config data, needs to be set when initialized
local food = {
	position = { x = 6, y = 6 },
	config = nil -- need to set the config whenever we init
}

-- @param _config table The game config data, must include hor_cells and ver_cells fields
-- @return void
function food:init(_config)
	self.position = { x = 6, y = 6 }
	self.config = _config
end


-- @return void
-- Spawn the food at a random position within the game grid
function food:spawn()
    if not self.config then
        error("Food configuration not initialized! Call food:init(config) first.")
    end

	self.position = { x = math.random(0, self.config.hor_cells - 1), 
					  y = math.random(0, self.config.ver_cells - 1) }
	
	print("Food spawned at: ", self.position.x, self.position.y)
end

return food