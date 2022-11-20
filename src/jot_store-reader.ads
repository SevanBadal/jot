with Ada.Directories; use Ada.Directories;
with Jot_Config; use Jot_Config;
package Jot_Store.Reader is
   procedure List_Jots;
   procedure Print_File (Dir : Directory_Entry_Type);
   procedure Parse_Flags (Flag_Strings : String;
                          Jot_Flags : in out Flag_Array);
   procedure Search_Jots_With_Flags(Jot_Flags : in Flag_Array; TQuery : String := ""; BQuery : String := "");
private
   Flag_Delimiter : constant Character := '-';
end Jot_Store.Reader;