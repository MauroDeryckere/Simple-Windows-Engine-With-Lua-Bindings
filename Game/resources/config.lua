-- config.lua

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

-- Default keybinds for actions
keybinds = {
    moveUp = KEY_CODES.UP,
    moveDown = KEY_CODES.DOWN,
    moveLeft = KEY_CODES.LEFT,
    moveRight = KEY_CODES.RIGHT
   --  pause = KEY_CODES.SPACE
}

return {
	grid_size = 20,
	screen_width = 1024,
	screen_height = 768,
	frame_rate = 60,
	game_speed = 10
}