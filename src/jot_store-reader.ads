with Ada.Directories; use Ada.Directories;

package Jot_Store.Reader is
   procedure List_Jots;
   procedure Search_Jots (Query : String);
   procedure Search_Jot_Bodies (Query : String);
   procedure Search_Jot_Bodies_Nested (TQuery : String; BQuery : String);
   procedure Print_File (Dir : Directory_Entry_Type);
end Jot_Store.Reader;