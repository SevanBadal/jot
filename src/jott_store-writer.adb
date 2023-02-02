with Ada.Text_IO; use Ada.Text_IO;
with Ada.Calendar; use Ada.Calendar;
with Ada.Directories; use Ada.Directories;
with Ada.Strings.Fixed; use Ada.Strings.Fixed;
package body Jott_Store.Writer is
   procedure Create_Jott (JottNote : Jott) is
      Seconds_Since_Epoch : constant Integer := Natural (Clock - Time_Of (1970, 1, 1, 0.0));
      F : Ada.Text_IO.File_Type;
   begin
      Create_Path (Path);
      Create (
         File => F,
         Mode => Out_File,
         Name => Path & "/" &
         Trim (Seconds_Since_Epoch'Image, Ada.Strings.Left) &
               "-" & JottNote.Title & Jott_File_Extension
         );
      Put_Line (F, "# " & JottNote.Title);
      Put_Line (F, JottNote.Tags);
      Put_Line (F, JottNote.Jott_Body);
      Close (F);
      Put_Line (Path & "/" &
      Trim (Seconds_Since_Epoch'Image, Ada.Strings.Left) &
            "-" & JottNote.Title & Jott_File_Extension);
   end Create_Jott;
end Jott_Store.Writer;