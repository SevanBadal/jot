with Ada.Text_IO; use Ada.Text_IO;
with Ada.Calendar; use Ada.Calendar;
with Ada.Directories; use Ada.Directories;
with Ada.Strings.Fixed; use Ada.Strings.Fixed;
package body Jot_Store.Writer is
   procedure Create_Jot (JotNote : Jot) is
      Seconds_Since_Epoch : constant Integer := Natural (Clock - Time_Of (1970, 1, 1, 0.0));
      F : Ada.Text_IO.File_Type;
   begin
      Create_Path (Path);
      Create (
         File => F,
         Mode => Out_File,
         Name => Path & "/" &
         Trim (Seconds_Since_Epoch'Image, Ada.Strings.Left) &
         "-" & JotNote.Title & Jot_File_Extension
         );
      Put_Line (F, "# " & JotNote.Title);
      Put_Line (F, JotNote.Tags);
      Put_Line (F, JotNote.Jot_Body);
      Close (F);
   end Create_Jot;
end Jot_Store.Writer;