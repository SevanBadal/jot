pragma Assertion_Policy (Check);
with Ada.Directories; use Ada.Directories;
with Jott_Config; use Jott_Config;
with Ada.Command_Line;
with Ada.Strings.Unbounded;

package Jott_Store.Reader is
   package SU   renames Ada.Strings.Unbounded;
   package CLI renames Ada.Command_Line;
   procedure List_Jotts;
   procedure Print_File (Jott_Flags : Flag_Array; Dir : Directory_Entry_Type);
   procedure Print_File (Dir : Directory_Entry_Type);
   procedure Parse_Flags (Flag_Strings : String;
                          Jott_Flags : in out Flag_Array;
                          Flag_Count : in out Integer)
      with Post => ((if Jott_Flags (T) xor Jott_Flags (B)
                     then CLI.Argument_Count = 2
                     elsif Jott_Flags (T)
                     and then Jott_Flags (B)
                     then CLI.Argument_Count = 3
                     elsif Jott_Flags (I)
                     then CLI.Argument_Count >= 1)
                     or else raise CLI_Argument_Error
                     with "Wrong number of arguments");
   procedure Search_Jotts_With_Flags (Jott_Flags : Flag_Array;
                                     TQuery : String := "";
                                     BQuery : String := "");
private
   Flag_Delimiter : constant Character := '-';
   function Process_String ( Jott_Flags : Flag_Array; Some_String : String ) return String;
   function Process_String ( Jott_Flags : Flag_Array; Some_Unbounded_String : SU.Unbounded_String ) return SU.Unbounded_String;
end Jott_Store.Reader;