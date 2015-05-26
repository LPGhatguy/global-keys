local ffi = require("ffi")
local user32 = ffi.load("user32")

if (ffi.abi("64bit")) then
	ffi.cdef([[
		typedef int64_t LONG_PTR;
	]])
else
	ffi.cdef([[
		typedef long LONG_PTR;
	]])
end

ffi.cdef([[
	typedef uint16_t WORD;
	typedef long LONG;
	typedef unsigned int UINT;
	typedef unsigned long DWORD;
	typedef unsigned long ULONG_PTR;
	typedef unsigned int* UINT_PTR;
	typedef int BOOL;
	typedef const char* LPCSTR;

	typedef UINT_PTR WPARAM;
	typedef LONG_PTR LPARAM;
	typedef LONG_PTR LRESULT;

	typedef void* HANDLE;
	typedef HANDLE HWND;
	typedef HANDLE HINSTANCE;
	typedef HANDLE HHOOK;

	typedef struct tagPOINT {
	    LONG  x;
	    LONG  y;
	} POINT, *PPOINT, *NPPOINT, *LPPOINT;

	typedef struct tagMSG {
	    HWND        hwnd;
	    UINT        message;
	    WPARAM      wParam;
	    LPARAM      lParam;
	    DWORD       time;
	    POINT       pt;
	} MSG, *PMSG, *NPMSG, *LPMSG;

	typedef struct tagKBDLLHOOKSTRUCT {
	    DWORD   vkCode;
	    DWORD   scanCode;
	    DWORD   flags;
	    DWORD   time;
	    ULONG_PTR dwExtraInfo;
	} KBDLLHOOKSTRUCT, *LPKBDLLHOOKSTRUCT, *PKBDLLHOOKSTRUCT;

	typedef LRESULT (__stdcall *HOOKPROC)(int code, WPARAM wParam, LPARAM lParam);

	HHOOK SetWindowsHookExA(int idHook, HOOKPROC lpfn, HINSTANCE hMod, DWORD dwThreadId);
	BOOL UnhookWindowsHookEx(HHOOK hhk);
	BOOL GetMessageA(LPMSG lpMsg, HWND hWnd, UINT wMsgFilterMin, UINT wMsgFilterMax);
	BOOL TranslateMessage(const MSG* lpMsg);
	LRESULT DispatchMessageA(const MSG* lpMsg);
]])

local win32 = setmetatable({
	WH_KEYBOARD = 2,
	WH_KEYBOARD_LL = 13,
	GetMessage = ffi.C.GetMessageA,
	SetWindowsHookEx = ffi.C.SetWindowsHookExA,
	DispatchMessage = ffi.C.DispatchMessageA
}, {
	__index = ffi.C
})

return win32