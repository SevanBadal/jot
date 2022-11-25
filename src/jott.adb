with Ada.Text_IO; use Ada.Text_IO;
with Ada.Command_Line;
with Jott_Config; use Jott_Config;
with Jott_Store;
with Jott_Store.Writer;
with Jott_Store.Reader;

procedure Jott is
   Flag_Count : Integer := 0;
   Arg_Count : constant Integer := Ada.Command_Line.Argument_Count;
   Search_Flags : Flag_Array :=
      (Flag'First .. Flag'Last => False);
begin
   --  List all jots if no CLI args
   if Arg_Count = 0 then
      Jott_Store.Reader.List_Jotts;
   --  Search jots by title and tag if only 1 CLI arg
   elsif Arg_Count = 1 then
      Search_Flags (T) := True;
      Jott_Store.Reader.Search_Jotts_With_Flags
         (Jott_Flags => Search_Flags,
          TQuery => Ada.Command_Line.Argument (1));
   else
      --  Parse Flags into Search_Flags array
      Jott_Store.Reader.Parse_Flags
         (Flag_Strings => Ada.Command_Line.Argument (1),
          Jott_Flags    => Search_Flags,
          Flag_Count   => Flag_Count);
      --  if no flags then create new jot
      if Flag_Count > 0 then
            Jott_Store.Reader.Search_Jotts_With_Flags
               (Jott_Flags => Search_Flags,
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
               Jott : constant Jott_Store.Jott := (
                  Title_Length => Note_Title'Length,
                  Tag_Length => Note_Tags'Length,
                  Body_Length => Note_Body'Length,
                  Title => Note_Title,
                  Tags => Note_Tags,
                  Jott_Body => Note_Body
               );
            begin
               Jott_Config.Configure_Datastore;
               Jott_Store.Writer.Create_Jott (JottNote => Jott);
            end;
         end if;
      end if;
   end if;
   exception
      when Jott_Store.CLI_Argument_Error =>
         Put_Line ("Wrong Number of Arguments");
      when others =>
         Put_Line ("Unknown Error");
end Jott;