-- food.lua
local food = {
	position = { x = 6, y = 6 },
	config = nil -- need to set the config whenever we init
}

function food:init(_config)
	self.config = _config
end

function food:spawn()
	-- self.position.x = math.random(0, self.config.map_width - 1)
    -- self.position.y = math.random(0, self.config.map_height - 1)
end

return food