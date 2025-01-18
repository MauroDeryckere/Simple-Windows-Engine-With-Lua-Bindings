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

function snake:checkCollisionSelf()
    local head = Body:getBack()
    local collision = false
    Body:iterate(function(segment, index)
        if index == Body.last then
            return
        end

        if segment.x == head.x and segment.y == head.y then
            print("collision! GAME OVER")
            collision = true  -- Collision with body
        end
    end)
    return collision  -- Return true if a collision is detected, otherwise false
end

function snake:getBody()
    return Body
end

return snake