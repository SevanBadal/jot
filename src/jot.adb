with Ada.Text_IO; use Ada.Text_IO;
with Ada.Command_Line;
with Jot_Config; use Jot_Config;
with Jot_Store;
with Jot_Store.Writer;
with Jot_Store.Reader;

procedure Jot is
   Flag_Count : Integer := 0;
   Arg_Count : constant Integer := Ada.Command_Line.Argument_Count;
   Search_Flags : Flag_Array :=
      (Flag'First .. Flag'Last => False);
begin
   --  List all jots if no CLI args
   if Arg_Count = 0 then
      Jot_Store.Reader.List_Jots;
   --  Search jots by title and tag if only 1 CLI arg
   elsif Arg_Count = 1 then
      Search_Flags (T) := True;
      Jot_Store.Reader.Search_Jots_With_Flags
         (Jot_Flags => Search_Flags,
          TQuery => Ada.Command_Line.Argument (1));
   else
      --  Parse Flags into Search_Flags array
      Jot_Store.Reader.Parse_Flags
         (Flag_Strings => Ada.Command_Line.Argument (1),
          Jot_Flags    => Search_Flags,
          Flag_Count   => Flag_Count);
      Put_Line (Flag_Count'Image);
      --  if no flags then create new jot
      if Flag_Count > 0 then
            Jot_Store.Reader.Search_Jots_With_Flags
               (Jot_Flags => Search_Flags,
                TQuery => (if Search_Flags (T)
                           then Ada.Command_Line.Argument (2)
                           else ""),
                BQuery => (if Search_Flags (B) and
                           then not Search_Flags (T)
                           then Ada.Command_Line.Argument (2)
                           elsif Search_Flags (B) and
                           then Search_Flags (T)
                           then Ada.Command_Line.Argument (3)
                           else ""));
      else
         if Arg_Count /= 3 then
            Put_Line ("Wrong number of arguments");
         else
            declare
               Note_Title : constant String := Ada.Command_Line.Argument (1);
               Note_Tags : constant String := Ada.Command_Line.Argument (2);
               Note_Body : constant String := Ada.Command_Line.Argument (3);
               Jot : constant Jot_Store.Jot := (
                  Title_Length => Note_Title'Length,
                  Tag_Length => Note_Tags'Length,
                  Body_Length => Note_Body'Length,
                  Title => Note_Title,
                  Tags => Note_Tags,
                  Jot_Body => Note_Body
               );
            begin
               Jot_Config.Configure_Datastore;
               Jot_Store.Writer.Create_Jot (JotNote => Jot);
            end;
         end if;
      end if;
   end if;
   exception
      when Jot_Store.CLI_Argument_Error =>
         Put_Line ("Wrong Number of Arguments");
      when others =>
         Put_Line ("Unknown Error");
end Jot;