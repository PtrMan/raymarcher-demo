module Window;

import core.sys.windows.windows;
import misc;

public __gshared HWND hwnd;

extern( Windows ) nothrow
LRESULT WndProc(HWND Hwnd, UINT Message, WPARAM WParam, LPARAM LParam)
{
   switch (Message)
   {
      case WM_DESTROY:
      PostQuitMessage (0);
      break;

      default:
      break;
   }

   return DefWindowProcA(Hwnd, Message, WParam, LParam);
}

// TODO< function pointer for entering of main program >
public int myWinMain(HINSTANCE hInstance, HINSTANCE hPrevInstance, LPSTR lpCmdLine, int nCmdShow, void function(void*, HWND) innerInitFunction, void function(void*, HWND) innerFunction, void* innerFunctionArgument)
{
   string ClassName = "DEMO";
   string WindowCaption = "DEMO"; // TODO FINAL

   WNDCLASSA Wnd;
   MSG Msg;
   bool CalleeSuccess;
   string ErrorMessage;

   memset(&Wnd, 0, WNDCLASSA.sizeof);
   Wnd.style = CS_HREDRAW | CS_VREDRAW | CS_OWNDC; // CS_OWNDC
   Wnd.lpfnWndProc = &WndProc;
   Wnd.hInstance = hInstance;
   Wnd.hIcon = LoadIconA( null, IDI_APPLICATION );
   Wnd.hCursor = LoadCursorA( null, IDC_ARROW );
   Wnd.hbrBackground = cast(HBRUSH)GetStockObject( BLACK_BRUSH );
   Wnd.lpszClassName = cast(LPCSTR)ClassName.ptr;

   ATOM ResultAtom = RegisterClassA(&Wnd);

   if( !ResultAtom )
   {
      // log
      // TODO

      return 2; // abnormal exit
   }

   hwnd = CreateWindowExA(
      0,
      cast(LPCSTR)ClassName.ptr,
      cast(LPCSTR)ClassName.ptr,
      WS_CAPTION | WS_POPUPWINDOW | WS_VISIBLE | WS_CLIPCHILDREN | WS_CLIPSIBLINGS ,
      0, 0, 800, 600,
      null, null, hInstance, null );
   
   if( hwnd is null )
   {
      // log
      // TODO

      return 2; // abnormal exit
   }

   ShowWindow(hwnd, nCmdShow);
   UpdateWindow(hwnd);

   innerInitFunction(innerFunctionArgument, hwnd);

   for(;;)
   {
      innerFunction(innerFunctionArgument, hwnd);

      // TODO< window handling >
   }
   
   // ASK< right? >
   // NOTE< is not initialized >
   return Msg.wParam;
}

extern( Windows ) nothrow
private LRESULT WndProc(HWND Hwnd, UINT Message, WPARAM WParam, LPARAM LParam)
{
   switch (Message)
   {
      case WM_DESTROY:
      PostQuitMessage (0);
      break;

      default:
      break;
   }

   return DefWindowProcA(Hwnd, Message, WParam, LParam);
}
