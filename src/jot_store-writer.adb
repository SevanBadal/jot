with Ada.Text_IO; use Ada.Text_IO;
with Ada.Calendar; use Ada.Calendar;
with Ada.Directories; use Ada.Directories;
package body Jot_Store.Writer is
	function Create_Jot (JotNote : Jot) return Boolean is 
	Seconds_Since_Epoch : constant Integer := Natural(Clock - Time_Of(1970, 1, 1, 0.0));
	F : Ada.Text_IO.File_Type;
	begin
		Create_Path (Path);
		Create (File => F, Mode => Out_File, Name => Path & "/" & Seconds_Since_Epoch'Image & "-" & JotNote.Title & Jot_File_Extension);
		Put_Line(F, "# " & JotNote.Title);
		Put_Line(F, JotNote.Tags);
		Put_Line(F, JotNote.Jot_Body);
		Close(F);
		return True;
	end Create_Jot;
end Jot_Store.Writer;