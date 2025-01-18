-- snake.lua

-- @type Queue
-- Reference to the queue module used to manage the snake's body
local Body = require("queue")

-- @class snake
-- @field direction {x:number, y:number} The current direction of the snake (x and y components)
-- @field did_grow boolean A flag indicating whether the snake has grown this frame
-- @field score number The current score of the player
local snake = {
    direction = { x = 1, y = 0 }, 
    did_grow = false,
    score = 0
}

-- @return void 
-- Initialize the snake, setting its initial position (adding it to the queue)
function snake:init()
   print("snake init")
   Body:enqueue({x = 5, y = 5})  -- Enqueue the initial position
end

-- @return void
-- Move the snake based on its direction, updating its body
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

-- @return void
-- Change the snake's direction to look up (towards negative Y axis)
function snake:lookUp()
    if self.direction.y == 1 then
        return
    end
    self.direction = { x = 0, y = -1 }
end
-- @return void
-- Change the snake's direction to look down (towards positive Y axis)
function snake:lookDown()
    if self.direction.y == -1 then
        return
    end
    self.direction = { x = 0, y = 1 }
end
-- @return void
-- Change the snake's direction to look left (towards negative X axis)
function snake:lookLeft()
    if self.direction.x == 1 then
        return
    end
    self.direction = { x = -1, y = 0 }
end
-- @return void
-- Change the snake's direction to look right (towards positive X axis)
function snake:lookRight()
    if self.direction.x == -1 then
        return
    end
    self.direction = { x = 1, y = 0 }
end

-- @param config table The game configuration, used for checking boundaries
-- @return boolean True if a collision is detected, otherwise false
-- Check for collisions with the snake's body or boundaries
function snake:checkCollision(config)
    local head = Body:getBack()
    local collision = false
    Body:iterate(function(segment, index)
        if (segment.x < 0 or segment.x > config.hor_cells - 1 or segment.y < 0 or segment.y > config.ver_cells - 1) then
            print("collision! GAME OVER")
            collision = true
        end

        if index == Body.last then
            return
        end

        if (segment.x == head.x and segment.y == head.y) then
            print("collision! GAME OVER")
            collision = true  -- Collision with body or borders
        end
    end)
    return collision
end

-- @return Body A reference to the snake's body (queue of segments)
function snake:getBody()
    return Body
end

return snake