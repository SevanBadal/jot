with Ada.Text_IO; use Ada.Text_IO;
package body Jott_Config is
   procedure Configure_Datastore is
      F : Ada.Text_IO.File_Type;
   begin
      Open (File => F, Mode => Append_File, Name => "./jott-store.dat");
      exception
         when Name_Error =>
            Create (File => F, Mode => Out_File, Name => "./jott-store.dat");
            Close (F);
   end Configure_Datastore;
end Jott_Config;