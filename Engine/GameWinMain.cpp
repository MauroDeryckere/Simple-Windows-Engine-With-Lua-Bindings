//-----------------------------------------------------------------
// Game Engine WinMain Function
// C++ Source - GameWinMain.cpp - version v8_01
//-----------------------------------------------------------------

//-----------------------------------------------------------------
// Include Files
//-----------------------------------------------------------------
#include "GameWinMain.h"
#include "GameEngine.h"

#include "Game.h"	

//-----------------------------------------------------------------
// Create GAME_ENGINE global (singleton) object and pointer
//-----------------------------------------------------------------
GameEngine myGameEngine;
GameEngine* GAME_ENGINE{ &myGameEngine };

void AllocateConsole();

//-----------------------------------------------------------------
// Main Function
//-----------------------------------------------------------------
int APIENTRY wWinMain(_In_ HINSTANCE hInstance, _In_opt_ HINSTANCE hPrevInstance, _In_ LPWSTR lpCmdLine, _In_ int nCmdShow)
{
    AllocateConsole();

	GAME_ENGINE->SetGame(new Game());					// any class that implements AbstractGame

	return GAME_ENGINE->Run(hInstance, nCmdShow);		// here we go

}

void AllocateConsole()
{
    if (AllocConsole())
    {
        // Redirect STDOUT to the console
        FILE* fp;
        freopen_s(&fp, "CONOUT$", "w", stdout);
        setvbuf(stdout, NULL, _IONBF, 0);

        // Redirect STDERR to the console
        freopen_s(&fp, "CONOUT$", "w", stderr);  
        setvbuf(stderr, NULL, _IONBF, 0);

        // Redirect STDIN to the console
        freopen_s(&fp, "CONIN$", "r", stdin);    
        setvbuf(stdin, NULL, _IONBF, 0);

        // Sync C++ streams with the console
        std::ios::sync_with_stdio(true);
    }
}

