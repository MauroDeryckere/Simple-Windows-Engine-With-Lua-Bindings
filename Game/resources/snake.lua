-- snake.lua

local Body = require("queue")
local snake = {
    direction = { x = 1, y = 0 }, 
    did_grow = false,
    score = 0
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
    else
        self.score = self.score + 100
        print(self.score)
        self.did_grow = false
    end
        
end

function snake:lookUp()
    if self.direction.y == 1 then
        return
    end
    self.direction = { x = 0, y = -1 }
end
function snake:lookDown()
    if self.direction.y == -1 then
        return
    end
    self.direction = { x = 0, y = 1 }
end
function snake:lookLeft()
    if self.direction.x == 1 then
        return
    end
    self.direction = { x = -1, y = 0 }
end
function snake:lookRight()
    if self.direction.x == -1 then
        return
    end
    self.direction = { x = 1, y = 0 }
end

function snake:checkCollision(config)
    local head = Body:getBack()
    local collision = false
    Body:iterate(function(segment, index)
        if index == Body.last then
            return
        end
        if (segment.x == head.x and segment.y == head.y) or (segment.x < 0 or segment.x > config.hor_cells - 1 or segment.y < 0 or segment.y > config.ver_cells - 1) then
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