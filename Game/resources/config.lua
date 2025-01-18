-- config.lua

-- @type table<{number}>
-- A table mapping keys to their virtual key codes
KEY_CODES = {
    W = 0x57,         -- Virtual key code for 'W'
    A = 0x41,         -- Virtual key code for 'A'
    S = 0x53,         -- Virtual key code for 'S'
    D = 0x44,         -- Virtual key code for 'D'
    UP = 0x26,        -- Virtual key code for 'Up Arrow'
    DOWN = 0x28,      -- Virtual key code for 'Down Arrow'
    LEFT = 0x25,      -- Virtual key code for 'Left Arrow'
    RIGHT = 0x27,     -- Virtual key code for 'Right Arrow'
    SPACE = 0x20,     -- Virtual key code for 'Space'
    ENTER = 0x0D,     -- Virtual key code for 'Enter'
    ESC = 0x1B        -- Virtual key code for 'Escape'
}

-- @type table<{number}>
-- Default keybinds for actions mapped to virtual key codes
keybinds = {
    moveUp = KEY_CODES.UP,
    moveDown = KEY_CODES.DOWN,
    moveLeft = KEY_CODES.LEFT,
    moveRight = KEY_CODES.RIGHT,
    pause = KEY_CODES.SPACE
}

-- @type table
-- Configuration settings for the game
-- @field hor_cells number The number of horizontal cells in the game grid
-- @field ver_cells number The number of vertical cells in the game grid
-- @field grid_size number The size of each grid cell
-- @field screen_width number The width of the game screen in pixels
-- @field screen_height number The height of the game screen in pixels
-- @field frame_rate number The number of frames per second
-- @field game_speed number The speed of the game (lower value = faster)
return {
    hor_cells = 20,
    ver_cells = 15,
	grid_size = 50,
	screen_width = 1000,
	screen_height = 750,
	frame_rate = 60,
	game_speed = 10
}