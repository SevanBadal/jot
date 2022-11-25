pragma Assertion_Policy (Check);
with Ada.Directories; use Ada.Directories;
with Jot_Config; use Jot_Config;
with Ada.Command_Line;
with Ada.Strings.Unbounded;

package Jot_Store.Reader is
   package SU   renames Ada.Strings.Unbounded;
   package CLI renames Ada.Command_Line;
   procedure List_Jots;
   procedure Print_File (Dir : Directory_Entry_Type);
   procedure Parse_Flags (Flag_Strings : String;
                          Jot_Flags : in out Flag_Array;
                          Flag_Count : in out Integer)
      with Post => ((if Jot_Flags (T) xor Jot_Flags (B)
                     then CLI.Argument_Count = 2
                     elsif Jot_Flags (T)
                     and then Jot_Flags (B)
                     then CLI.Argument_Count = 3
                     elsif Jot_Flags (I)
                     then CLI.Argument_Count >= 1)
                     or else raise CLI_Argument_Error
                     with "Wrong number of arguments");
   procedure Search_Jots_With_Flags (Jot_Flags : Flag_Array;
                                     TQuery : String := "";
                                     BQuery : String := "");
private
   Flag_Delimiter : constant Character := '-';
   function Process_String ( Jot_Flags : Flag_Array; Some_String : String ) return String;
   function Process_String ( Jot_Flags : Flag_Array; Some_Unbounded_String : SU.Unbounded_String ) return SU.Unbounded_String;
end Jot_Store.Reader;