-- snake.lua

local snake = {
    body = { 
        { x = 5, y = 5 } 
    }, 
    direction = { x = 1, y = 0 }, 
    growing = false
}

function snake:move()
    if not growing then
        print("Body before move:")
        for _, segment in ipairs(self.body) do
            print(segment.x, segment.y)
        end    
        print()
    
        print("Adding new head\n");
        -- new head: 
        self.body[#self.body+1] = { x = self.body[1].x + self.direction.x, y = self.body[1].y + self.direction.y }

        print("Body after move:")
        for _, segment in ipairs(self.body) do
            print(segment.x, segment.y)
        end   

        growing = true

        print()
    end
end

return snake