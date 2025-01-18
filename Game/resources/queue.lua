-- Queue module
local Queue = 
{
    first = 0, 
    last = 0, 
    items = {}
}

-- Enqueue: Add an element to the end of the queue
function Queue:enqueue(value)
    -- print("enqueue", value)
    self.last = self.last + 1
    self.items[self.last] = value
end

-- Dequeue: Remove and return an element from the front of the queue
function Queue:dequeue()
    if self.first < self.last then
        local value = self.items[self.first + 1]
        self.items[self.first + 1] = nil  -- Remove the element
        self.first = self.first + 1
       -- print("dequeue", value)
        return value
    else
        return nil  -- Return nil if the queue is empty
    end
end

-- getFront: Get the front element without modifying it
function Queue:getFront()
    if self.first < self.last then
        return self.items[self.first + 1]
    else
        return nil
    end
end

-- getBack: Get the back element without modifying it
function Queue:getBack()
    if self.first < self.last then
        return self.items[self.last]
    else
        return nil
    end
end

-- Check if the queue is empty
function Queue:isEmpty()
    return self.first >= self.last
end

-- Iterate over all items in the queue
function Queue:iterate(func)
    for i = self.first + 1, self.last do
        func(self.items[i], i)  -- Execute the function with the item and its index
    end
end

return Queue