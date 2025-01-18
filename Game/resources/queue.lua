-- Queue module

-- @class Queue
-- @field first number The index of the first element in the queue
-- @field last number The index of the last element in the queue
-- @field items table A table holding the elements of the queue
local Queue = 
{
    first = 0, 
    last = 0, 
    items = {}
}

-- @param value any The value to be added to the queue
-- @return void
-- Enqueue: Add an element to the end of the queue
function Queue:enqueue(value)
    -- print("enqueue", value)
    self.last = self.last + 1
    self.items[self.last] = value
end

-- @return any|nil The element removed from the queue, or nil if the queue is empty
-- Dequeue: Remove and return an element from the front of the queue
function Queue:dequeue()
    if self.first < self.last then
        local value = self.items[self.first + 1]
        self.items[self.first + 1] = nil  -- Remove the element
        self.first = self.first + 1
        return value
    else
        return nil
    end
end

-- @return any|nil The element at the front of the queue, or nil if the queue is empty
-- getFront: Get the front element without modifying it
function Queue:getFront()
    if self.first < self.last then
        return self.items[self.first + 1]
    else
        return nil
    end
end

-- @return any|nil The element at the back of the queue, or nil if the queue is empty
-- getBack: Get the back element without modifying it
function Queue:getBack()
    if self.first < self.last then
        return self.items[self.last]
    else
        return nil
    end
end

-- @return boolean True if the queue is empty, false otherwise
-- Check if the queue is empty
function Queue:isEmpty()
    return self.first >= self.last
end

-- @param func function A function to be applied to each item in the queue
-- @return void This function does not return anything
-- Iterate over all items in the queue
function Queue:iterate(func)
    for i = self.first + 1, self.last do
        func(self.items[i], i)  -- Execute the function with the item and its index
    end
end

-- @return void 
-- Clears all elements from the queue
function Queue:clear()
    self.first = 0
    self.last = 0
    self.items = {}
end

return Queue