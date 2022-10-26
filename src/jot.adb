with Ada.Text_IO;
with Ada.Command_Line;
with Jot_Config;
with Jot_Store;
with Jot_Store.Writer;
with Jot_Store.Reader;

procedure Jot is
begin
   if Ada.Command_Line.Argument_Count = 0 then
      Jot_Store.Reader.List_Jots;
      return;
   elsif Ada.Command_Line.Argument_Count = 1 then
      Jot_Store.Reader.Search_Jots;
      return;
   elsif Ada.Command_Line.Argument_Count /= 3 then
      Ada.Text_IO.Put_Line ("Wrong number of arguments");
      return;
   end if;
   declare
      Note_Title : constant String := Ada.Command_Line.Argument (1);
      Note_Tags : constant String := Ada.Command_Line.Argument (2);
      Note_Body : constant String := Ada.Command_Line.Argument (3);
      Res : Boolean := True;
      Jot : Jot_Store.Jot := (
         Title_Length => Note_Title'Length,
         Tag_Length => Note_Tags'Length,
         Body_Length => Note_Body'Length,
         Title => Note_Title,
         Tags => Note_Tags,
         Jot_Body => Note_Body
      );
   begin
      Jot_Config.Configure_Datastore;
      Ada.Text_IO.Put_Line ("Note Title: " & Jot.Title);
      Ada.Text_IO.Put_Line ("Note Tags: " & Note_Tags);
      Ada.Text_IO.Put_Line ("Note Body: " & Note_Body);
      Res := Jot_Store.Writer.Create_Jot (JotNote => Jot);
   end;
end Jot;