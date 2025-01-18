//-----------------------------------------------------------------
// Main Game File
// C++ Source - Game.cpp - version v8_01
//-----------------------------------------------------------------

//-----------------------------------------------------------------
// Include Files
//-----------------------------------------------------------------
#include "Game.h"
#include <filesystem>

//-----------------------------------------------------------------
// Game Member Functions																				
//-----------------------------------------------------------------

Game::Game() 																	
{
	// nothing to create
}

Game::~Game()																						
{
	// nothing to destroy
}

void Game::Initialize()		
{
	// Code that needs to execute (once) at the start of the game, before the game window is created
	AbstractGame::Initialize();

	GAME_ENGINE->SetTitle(_T("Simple Lua Game"));	
	
	GAME_ENGINE->SetWidth(1024);
	GAME_ENGINE->SetHeight(768);
    GAME_ENGINE->SetFrameRate(50);

	// Set the keys that the game needs to listen to
	//tstringstream buffer;
	//buffer << _T("KLMO");
	//buffer << (char) VK_LEFT;
	//buffer << (char) VK_RIGHT;
	//GAME_ENGINE->SetKeyList(buffer.str());

	InitializeLua();
}

void Game::Start()
{
	// Insert code that needs to execute (once) at the start of the game, after the game window is created
}

void Game::End()
{
	// Insert code that needs to execute when the game ends
}

void Game::Paint(RECT rect) const
{
	// rect == game window rect, need to base all locations off of this
	if (m_LuaState["Paint"].valid()) 
	{
		// Create a Lua table for the RECT equivalent
		sol::table luaRect{ m_LuaState.create_table() };
		luaRect["left"] = rect.left;
		luaRect["right"] = rect.right;
		luaRect["top"] = rect.top;
		luaRect["bottom"] = rect.bottom;

		try 
		{
			m_LuaState["Paint"](luaRect);
		}
		catch (const std::exception& e) 
		{
			std::cerr << "Error in Lua Paint function: " << e.what() << "\n";
		}
	}
}

void Game::Tick()
{
	// Call Lua script's tick function if it exists
	if (m_LuaState["Tick"].valid())
	{
		try 
		{
			m_LuaState["Tick"]();
		}
		catch (const std::exception& e) 
		{
			std::cerr << "Error in Lua Tick function: " << e.what() << "\n";
		}
	}
}

void Game::MouseButtonAction(bool isLeft, bool isDown, int x, int y, WPARAM wParam)
{	
	// Insert code for a mouse button action

	/* Example:
	if (isLeft == true && isDown == true) // is it a left mouse click?
	{
		if ( x > 261 && x < 261 + 117 ) // check if click lies within x coordinates of choice
		{
			if ( y > 182 && y < 182 + 33 ) // check if click also lies within y coordinates of choice
			{
				GAME_ENGINE->MessageBox(_T("Clicked."));
			}
		}
	}
	*/
}

void Game::MouseWheelAction(int x, int y, int distance, WPARAM wParam)
{	
	// Insert code for a mouse wheel action
}

void Game::MouseMove(int x, int y, WPARAM wParam)
{	
	// Insert code that needs to execute when the mouse pointer moves across the game window

	/* Example:
	if ( x > 261 && x < 261 + 117 ) // check if mouse position is within x coordinates of choice
	{
		if ( y > 182 && y < 182 + 33 ) // check if mouse position also is within y coordinates of choice
		{
			GAME_ENGINE->MessageBox("Mouse move.");
		}
	}
	*/
}

void Game::CheckKeyboard()
{	
	// Here you can check if a key is pressed down
	// Is executed once per frame 

	/* Example:
	if (GAME_ENGINE->IsKeyDown(_T('K'))) xIcon -= xSpeed;
	if (GAME_ENGINE->IsKeyDown(_T('L'))) yIcon += xSpeed;
	if (GAME_ENGINE->IsKeyDown(_T('M'))) xIcon += xSpeed;
	if (GAME_ENGINE->IsKeyDown(_T('O'))) yIcon -= ySpeed;
	*/
}

void Game::KeyPressed(TCHAR key)
{	
	// DO NOT FORGET to use SetKeyList() !!

	// Insert code that needs to execute when a key is pressed
	// The function is executed when the key is *released*
	// You need to specify the list of keys with the SetKeyList() function

	/* Example:
	switch (key)
	{
	case _T('K'): case VK_LEFT:
		GAME_ENGINE->MessageBox("Moving left.");
		break;
	case _T('L'): case VK_DOWN:
		GAME_ENGINE->MessageBox("Moving down.");
		break;
	case _T('M'): case VK_RIGHT:
		GAME_ENGINE->MessageBox("Moving right.");
		break;
	case _T('O'): case VK_UP:
		GAME_ENGINE->MessageBox("Moving up.");
		break;
	case VK_ESCAPE:
		GAME_ENGINE->MessageBox("Escape menu.");
	}
	*/
}

void Game::CallAction(Caller* callerPtr)
{
	// Insert the code that needs to execute when a Caller (= Button, TextBox, Timer, Audio) executes an action
}

void Game::InitializeLua()
{
	// Open libraries used in Lua
	m_LuaState.open_libraries(sol::lib::base, sol::lib::math, sol::lib::os, sol::lib::io, sol::lib::package);

	//Set Lua's package.path to include the "resources" folder
	std::string const luaPath{ "resources/?.lua;resources/?/init.lua;" };
	m_LuaState["package"]["path"] = luaPath;
	
	// Expose GameEngine class and its methods to Lua
	m_LuaState.new_usertype<GameEngine>("GameEngine",
		"SetTitle", &GameEngine::SetTitle,
		"SetWidth", &GameEngine::SetWidth,
		"SetHeight", &GameEngine::SetHeight,
		"SetFrameRate", &GameEngine::SetFrameRate,
		"SetKeyList", &GameEngine::SetKeyList,
		"SetColor", &GameEngine::SetColor,
		"FillRect", [](GameEngine const& self, sol::table rect) {
			uint32_t const left = rect["left"];
			uint32_t const top = rect["top"];
			uint32_t const right = rect["right"];
			uint32_t const bottom = rect["bottom"];

			auto const result = self.FillRect(left, top, right, bottom);
			assert(result);
		});

	m_LuaState.new_usertype<Game>("Game");
	
	// Create an instance of GameEngine in Lua
	m_LuaState["game_engine"] = GAME_ENGINE;

	std::string const scriptPath = { "resources/default_game.lua" };
	assert(std::filesystem::exists(scriptPath));

	// Load the Lua script
	try
	{
		m_LuaState.script_file(scriptPath); //Execute the Lua script
	}
	catch (const std::exception& e)
	{
		std::cerr << "Error initializing Lua: " << e.what() << std::endl;
	}
}