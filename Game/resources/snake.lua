-- snake.lua

local Body = require("queue")
local snake = {
    direction = { x = 1, y = 0 }, 
    did_grow = false
}

function snake:init()
   print("snake init")
   Body:enqueue({x = 5, y = 5})  -- Enqueue the initial position
end

function snake:move()
    -- new head: 
    local old_head = Body:getBack()
    Body:enqueue({ x = old_head.x + self.direction.x, y = old_head.y + self.direction.y})

    if not self.did_grow then
        Body:dequeue() -- remove tail if we did not grow this game frame
    end
        
    self.did_grow = false
end

function snake:lookUp()
    self.direction = { x = 0, y = -1 }
end
function snake:lookDown()
    self.direction = { x = 0, y = 1 }
end
function snake:lookLeft()
    self.direction = { x = -1, y = 0 }
end
function snake:lookRight()
    self.direction = { x = 1, y = 0 }
end

function snake:getBody()
    return Body
end

return snake