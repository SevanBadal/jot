with Ada.Text_IO; use Ada.Text_IO;
with Ada.Command_Line;
with Jot_Config; use Jot_Config;
with Jot_Store;
with Jot_Store.Writer;
with Jot_Store.Reader;

procedure Jot is
   Search_Flags : Flag_Array :=
      (Flag'First .. Flag'Last => False);
   Arg_Count : constant Integer := Ada.Command_Line.Argument_Count;
begin
   if Arg_Count = 0 then
      Jot_Store.Reader.List_Jots;
   elsif Arg_Count = 1 then
      --  shortcut to Title and Tag Search
      Jot_Store.Reader.Search_Jots (Query =>  Ada.Command_Line.Argument (1));
   elsif Arg_Count > 1 then
      --  Parse Flags into Search_Flags array
      Jot_Store.Reader.Parse_Flags
         (Flag_Strings => Ada.Command_Line.Argument (1),
          Jot_Flags    => Search_Flags);
      if Search_Flags (B) and then Search_Flags (T) then
         if Arg_Count /= 3 then
            Ada.Text_IO.Put_Line ("Wrong number of arguments for flags -bt");
         else
            Jot_Store.Reader.Search_Jot_Bodies_Nested
               (Ada.Command_Line.Argument (2),
                Ada.Command_Line.Argument (3));
         end if;
      elsif Search_Flags (B) then
         if Arg_Count /= 2 then
            Put_Line ("Wrong number of arguments for flags -b");
         else
            Jot_Store.Reader.Search_Jot_Bodies (Ada.Command_Line.Argument (2));
         end if;
      elsif Search_Flags (T) then
         if Arg_Count /= 2 then
            Put_Line ("Wrong number of arguments for flags -t");
         else
            Jot_Store.Reader.Search_Jots
               (Query => Ada.Command_Line.Argument (2));
         end if;
      else --  no flags
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
               Put_Line ("Note Title: " & Jot.Title);
               Put_Line ("Note Tags: " & Note_Tags);
               Put_Line ("Note Body: " & Note_Body);
               Jot_Store.Writer.Create_Jot (JotNote => Jot);
            end;
         end if;
      end if;
   end if;
end Jot;