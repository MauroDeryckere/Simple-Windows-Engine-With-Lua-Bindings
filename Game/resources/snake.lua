-- snake.lua

local snake = {
    body = { 
        { x = 5, y = 5 } 
    }, 
    direction = { x = 1, y = 0 },
    length = 1,
    growing = false
}

function snake:move()
    -- Move the snake's body
    self.body[1].x = self.body[1].x + 20;
end

return snake