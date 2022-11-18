with Ada.Directories; use Ada.Directories;
with Jot_Config; use Jot_Config;
package Jot_Store.Reader is
   procedure List_Jots;
   procedure Search_Jots (Query : String);
   procedure Search_Jot_Bodies (Query : String);
   procedure Search_Jot_Bodies_Nested (TQuery : String; BQuery : String);
   procedure Print_File (Dir : Directory_Entry_Type);
   procedure Parse_Flags (Flag_Strings : String;
                          Jot_Flags : in out Flag_Array);
private
   Flag_Delimiter : constant Character := '-';
end Jot_Store.Reader;