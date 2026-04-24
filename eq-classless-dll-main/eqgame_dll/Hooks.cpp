// list of installed hooks at their address, if they are already patched in
#include <d3d9.h>
#include <Shlobj.h>
#include <fenv.h>


#include "RenderHooks.h"
#include "Hooks.h"

#include "MQ2Main.h"

std::vector<HookInfo> g_hooks;

void InstallHook(HookInfo hi)
{
	auto iter = std::find_if(std::begin(g_hooks), std::end(g_hooks),
		[&hi](const HookInfo & hookInfo)
		{
			return hi.name == hookInfo.name;
		});

	if (iter != std::end(g_hooks))
	{
		// hook already installed. Remove it.
		if (iter->address != 0)
		{
			RemoveDetour(iter->address);
		}
		g_hooks.erase(iter);
	}

	hi.patch(hi);
	g_hooks.push_back(hi);
}

template <typename T>
void InstallDetour(DWORD address, const T& detour, const T& trampoline, PCHAR name)
{
	HookInfo hookInfo;
	hookInfo.name = name;
	hookInfo.address = 0;
	hookInfo.patch = [&detour, &trampoline, address](HookInfo & hi)
	{
		hi.address = address;
		AddDetourf(hi.address, detour, trampoline, hi.name.c_str());
	};

	InstallHook(hookInfo);
}

DETOUR_TRAMPOLINE_EMPTY(void RenderHooks::ZoneRender_Injection_Trampoline());
DETOUR_TRAMPOLINE_EMPTY(HRESULT RenderHooks::Reset_Trampoline(D3DPRESENT_PARAMETERS* pPresentationParameters));
DETOUR_TRAMPOLINE_EMPTY(HRESULT RenderHooks::BeginScene_Trampoline());
DETOUR_TRAMPOLINE_EMPTY(HRESULT RenderHooks::EndScene_Trampoline());

bool InstallD3D9Hooks()
{
	bool success = false;

	g_d3d9Module = GetModuleHandle("d3d9.dll");

	if (g_d3d9Module)
	{
			HRESULT hRes;
			IDirect3D9Ex* d3d9ex;


			if (SUCCEEDED(hRes = Direct3DCreate9Ex(D3D_SDK_VERSION, &d3d9ex)))
			{
				D3DPRESENT_PARAMETERS pp;
				ZeroMemory(&pp, sizeof(pp));
				pp.Windowed = 1;
				pp.SwapEffect = D3DSWAPEFFECT_FLIP;
				pp.BackBufferFormat = D3DFMT_A8R8G8B8;
				pp.BackBufferCount = 1;
				pp.PresentationInterval = D3DPRESENT_INTERVAL_IMMEDIATE;

				// save the rounding state. We'll restore it after we're done here.
				// For some reason, CreateDeviceEx seems to tamper with it.
				int round = fegetround();

				IDirect3DDevice9Ex* deviceEx;

 				if (SUCCEEDED(hRes = d3d9ex->CreateDeviceEx(D3DADAPTER_DEFAULT,
					D3DDEVTYPE_NULLREF,
					0,
					D3DCREATE_HARDWARE_VERTEXPROCESSING | D3DCREATE_NOWINDOWCHANGES,
					&pp, NULL, &deviceEx)))
				{
					success = true;

					// IDirect3DDevice9 virtual function hooks
					DWORD* d3dDevice_vftable = *(DWORD * *)deviceEx;

					InstallDetour(d3dDevice_vftable[0x29],
						&RenderHooks::BeginScene_Detour,
						&RenderHooks::BeginScene_Trampoline,
						"d3dDevice_BeginScene");
					InstallDetour(d3dDevice_vftable[0x2a],
						&RenderHooks::EndScene_Detour,
						&RenderHooks::EndScene_Trampoline,
						"d3dDevice_EndScene");

					deviceEx->Release();
				}
				else
				{
				}

				// restore floating point rounding state
				fesetround(round);

				d3d9ex->Release();
			}
			else
			{
			}
	}

	return success;
}

static void RemoveDetours()
{
	for (HookInfo& hook : g_hooks)
	{
		if (hook.address != 0)
		{
			RemoveDetour(hook.address);
			hook.address = 0;
		}
	}
}

void ShutdownHooks()
{
	if (!g_hooksInstalled)
		return;

	RemoveDetours();

	g_hooksInstalled = false;
	g_hooks.clear();

	// Release our Direct3D device before freeing the dx9 library
	if (g_pDevice)
	{
		g_pDevice->Release();
		g_pDevice = nullptr;
	}

	if (g_d3d9Module)
	{
		FreeLibrary(g_d3d9Module);
		g_d3d9Module = 0;
	}


}

// ---- AA Window: Force-enable Exp +/- buttons for characters level 20-50 ----
// The client disables these buttons if player level < 51. We hook OnProcessFrame
// via direct vtable patch to re-enable them every frame so native click handling
// sends OP_AAAction to the server.

typedef int (__thiscall *CAAWnd_OnProcessFrame_t)(void* thisptr);
CAAWnd_OnProcessFrame_t CAAWnd_OnProcessFrame_original = nullptr;

static bool g_aaHooksInstalled = false;
static int g_aaDebugCounter = 0;


int __fastcall CAAWnd_OnProcessFrame_detour(void* thisptr, void* edx)
{
	// Call the original OnProcessFrame first (it does all the normal UI updates,
	// including disabling the buttons for level < 51)
	int result = 0;
	if (CAAWnd_OnProcessFrame_original)
		result = CAAWnd_OnProcessFrame_original(thisptr);

	// Now force-enable the +/- buttons if the player is level 20-50
	if (pLocalPlayer)
	{
		DWORD level = ((PSPAWNINFO)pLocalPlayer)->Level;
		if (level >= 20 && level < 51)
		{
			// Use GetChildItem to find buttons by ScreenID
			CXWnd* pMoreBtn = ((CSidlScreenWnd*)thisptr)->GetChildItem((PCHAR)"MoreExpButton");
			CXWnd* pLessBtn = ((CSidlScreenWnd*)thisptr)->GetChildItem((PCHAR)"LessExpButton");

			// Debug: log once every 300 frames
			if (g_aaDebugCounter++ % 300 == 0)
			{
				//WriteChatf("[AA-DBG] OnProcessFrame fired. Level=%d MoreBtn=%p LessBtn=%p", level, pMoreBtn, pLessBtn);
				if (pMoreBtn)
				{
					//WriteChatf("[AA-DBG] MoreBtn Enabled=%d", (int)((PCXWND)pMoreBtn)->Enabled);
				}
			}

			if (pMoreBtn)
			{
				((PCXWND)pMoreBtn)->Enabled = 1;
			}
			if (pLessBtn)
			{
				((PCXWND)pLessBtn)->Enabled = 1;
			}
		}
	}

	return result;
}

bool InstallAAWindowHooks()
{
	if (g_aaHooksInstalled)
		return true;

	if (!pAAWnd)
		return false;

	DWORD* pVTable = *(DWORD**)pAAWnd;
	
	// OnProcessFrame is at vtable offset 0x0c4 (index 49)
	DWORD onProcessFrameIndex = 0x0c4 / 4; // 49

	// Save original function pointers
	CAAWnd_OnProcessFrame_original = (CAAWnd_OnProcessFrame_t)pVTable[onProcessFrameIndex];

	if (!CAAWnd_OnProcessFrame_original)
	{
		WriteChatf("[AA-DBG] FAILED: original function pointer was NULL pF=%p",
			CAAWnd_OnProcessFrame_original);
		return false;
	}

	bool success = true;

	// Direct vtable patch: OnProcessFrame
	DWORD oldProtect = 0;
	if (VirtualProtect(&pVTable[onProcessFrameIndex], sizeof(DWORD), PAGE_EXECUTE_READWRITE, &oldProtect))
	{
		pVTable[onProcessFrameIndex] = (DWORD)CAAWnd_OnProcessFrame_detour;
		VirtualProtect(&pVTable[onProcessFrameIndex], sizeof(DWORD), oldProtect, &oldProtect);
	}
	else
	{
		success = false;
	}

	if (success)
	{
		g_aaHooksInstalled = true;
		WriteChatf("[AA-DBG] AA vtable patches INSTALLED! Process[orig=%08X new=%08X]",
			(DWORD)CAAWnd_OnProcessFrame_original, (DWORD)CAAWnd_OnProcessFrame_detour);
		return true;
	}

	WriteChatf("[AA-DBG] FAILED: VirtualProtect failed for vtable patching");
	return false;
}
