with Ada.Directories; use Ada.Directories;

package Jot_Store.Reader is
	procedure List_Jots;
	procedure Search_Jots (Query : in String);
	procedure Print_File (Dir : in Directory_Entry_Type);
end Jot_Store.Reader;