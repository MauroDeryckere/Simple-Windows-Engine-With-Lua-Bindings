//-----------------------------------------------------------------
// Main Game  File
// C++ Header - Game.h - version v8_01			
//-----------------------------------------------------------------

#pragma once

//-----------------------------------------------------------------
// Include Files
//-----------------------------------------------------------------

#include "Resource.h"	
#include "GameEngine.h"
#include "AbstractGame.h"
#include <sol/sol.hpp>		// Used for lua
//-----------------------------------------------------------------
// Game Class																
//-----------------------------------------------------------------
class Game : public AbstractGame, public Callable
{
public:				
	//---------------------------
	// Constructor(s) and Destructor
	//---------------------------
	Game();

	virtual ~Game() override;

	//---------------------------
	// Disabling copy/move constructors and assignment operators   
	//---------------------------
	Game(const Game& other)					= delete;
	Game(Game&& other) noexcept				= delete;
	Game& operator=(const Game& other)		= delete;
	Game& operator=(Game&& other) noexcept	= delete;

	//---------------------------
	// General Member Functions
	//---------------------------
	void Initialize			()															override;
	void Start				()															override;
	void End				()															override;
	void Paint				(RECT rect)	const											override;
	void Tick				()															override;
	void MouseButtonAction	(bool isLeft, bool isDown, int x, int y, WPARAM wParam)		override;
	void MouseWheelAction	(int x, int y, int distance, WPARAM wParam)					override;
	void MouseMove			(int x, int y, WPARAM wParam)								override;
	void CheckKeyboard		()															override;
	void KeyPressed			(TCHAR key)													override;
	
	void CallAction			(Caller* callerPtr)											override;

private:
	void InitializeLua();
	void CreateTextFont(uint32_t fontArrIdx, uint32_t fontSize);
	void SetFont(uint32_t fontArrIdx);

	// -------------------------
	// Datamembers
	// -------------------------
	mutable sol::state m_LuaState{};
	std::array<std::unique_ptr<Font>, 4> m_pFonts{}; //Max 4 fonts, can be increased or made dynamic if necessary but no need to do so for his project
};
