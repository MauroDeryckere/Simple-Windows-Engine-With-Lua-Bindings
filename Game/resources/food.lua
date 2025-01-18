-- food.lua
local food = {
	position = { x = 6, y = 6 },
	config = nil -- need to set the config whenever we init
}

function food:init(_config)
	self.config = _config
end

function food:spawn()
    if not self.config then
        error("Food configuration not initialized! Call food:init(config) first.")
    end

	self.position = { x = math.random(0, self.config.hor_cells - 1), 
					  y = math.random(0, self.config.ver_cells - 1) }
	
	print("Food spawned at: ", self.position.x, self.position.y)
end

return food