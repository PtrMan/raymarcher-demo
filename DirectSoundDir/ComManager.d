module DirectSoundDir.ComManager;

public import std.c.windows.com;

private __gshared uint RefCounter = 0;

struct ComManager
{
   static public void initilize()
   {
      if( RefCounter == 0 )
      {
         CoInitialize(null); // init COM-Interface
      }

      RefCounter++;
   }

   static public void uninitilize()
   {
      if( RefCounter == 0 )
      {
         // nothing
      }
      else if( RefCounter == 1 )
      {
         RefCounter = 0;

         CoUninitialize();
      }
      else
      {
         RefCounter--;
      }
   }
}