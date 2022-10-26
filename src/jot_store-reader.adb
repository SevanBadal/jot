with Ada.Text_IO; use Ada.Text_IO;
with Ada.Directories; use Ada.Directories;
with Ada.Command_Line;
package body Jot_Store.Reader is
	procedure List_Jots is 
	Dir : Directory_Entry_Type;
	Dir_Search : Search_Type;
	begin 
		-- READER
		Start_Search(Search => Dir_Search,
			Directory => Path,
			Pattern => Jot_File_Extension_Pattern);
		while More_Entries(Dir_Search) loop 
			Get_Next_Entry(Dir_Search, Dir);
			Put(Full_Name(Dir));
			Set_Col(50);
			if Kind(Dir) = Ordinary_File then
				Put(Size(Dir)'Image);
			end if;
			Set_Col(60);
			Put_Line(Kind(Dir)'Image);
		end loop; 
	end List_Jots;
	
	procedure Search_Jots is
		Query : constant String := Ada.Command_Line.Argument (1);
	begin 
		Put_Line (Query);
	end Search_Jots;

end Jot_Store.Reader;