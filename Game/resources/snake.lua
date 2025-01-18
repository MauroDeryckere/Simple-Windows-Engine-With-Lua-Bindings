-- snake.lua

local snake = {
    body = { 
        { x = 5, y = 5 } 
    }, 
    direction = { x = 1, y = 0 }
}

function snake:move()
    -- Move the snake's body
    self.body[1].x = self.body[1].x + self.direction.x
    self.body[1].y = self.body[1].y + self.direction.y
end

return snake