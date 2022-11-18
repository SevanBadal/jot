with Ada.Text_IO; use Ada.Text_IO;
with Ada.Strings.Unbounded;
with Ada.Strings.Fixed; use Ada.Strings.Fixed;
with Ada.Characters.Handling; use Ada.Characters.Handling;
package body Jot_Store.Reader is
   -- function String_To_Flag (Flag_String : String) return Flag is
   -- begin
   --    if 
   -- end String_To_Flag;
   procedure Parse_Flags (Flag_Strings : String; Jot_Flags : in out Flag_Array) is
   begin
      if Flag_Strings (Flag_Strings'First) /= Flag_Delimiter then
         return;
      end if;
      for Flag_Char_Index in 2 .. Flag_Strings'Length loop
         declare
            Flag_String : String :=  "" & To_Upper(Flag_Strings (Flag_Char_Index));
            Input_Flag : Flag;
         begin 
            Input_Flag := Flag'Value (Flag_String);
            Jot_Flags (Input_Flag) := True;
            exception
               when Constraint_Error =>
                  Put_Line ("Invalid Flag Detected: " & "-" & To_Lower(Flag_String));
         end;
      end loop;
      -- parse the flags
      -- update Flag_Array
   end Parse_Flags;
   procedure List_Jots is
      Dir : Directory_Entry_Type;
      Dir_Search : Search_Type;
   begin
      Start_Search (Search => Dir_Search,
                     Directory => Path,
                     Pattern => Jot_File_Extension_Pattern);
      while More_Entries (Dir_Search) loop
         Get_Next_Entry (Dir_Search, Dir);
         Print_File (Dir);
      end loop;
   end List_Jots;
   procedure Search_Jots (Query : String) is
      File : File_Type;
      Dir : Directory_Entry_Type;
      Dir_Search : Search_Type;
   begin
      --- Load files
      Start_Search (Search => Dir_Search,
                     Directory => Path,
                     Pattern => Jot_File_Extension_Pattern);
      --  Iterate over files
      while More_Entries (Dir_Search) loop
         Get_Next_Entry (Dir_Search, Dir);
         --  load file
         Open (File => File,
                  Mode => In_File,
                  Name => Full_Name (Dir));
         declare
            Title_Tag_String : Ada.Strings.Unbounded.Unbounded_String;
            Current_Line_Count : Integer := 1;
         begin
            --  Iterate over first two lines in the file (title and tags)
            while not  End_Of_File (File) loop
               Ada.Strings.Unbounded.Append (Title_Tag_String,
                                                Get_Line (File));
               Current_Line_Count := Current_Line_Count + 1;
               exit when Current_Line_Count = 3;
            end loop;
            --  Check for substring
            if Ada.Strings.Unbounded.Index (Title_Tag_String, Query) > 0 then
               Print_File (Dir);
            end if;
         end;
         Close (File);
      end loop;
   end Search_Jots;
   procedure Search_Jot_Bodies_Nested (TQuery : String; BQuery : String) is
      File : File_Type;
      Dir : Directory_Entry_Type;
      Dir_Search : Search_Type;
   begin
      --- Load files
      Start_Search (Search => Dir_Search,
                     Directory => Path,
                     Pattern => Jot_File_Extension_Pattern);
      --  Iterate over files
      while More_Entries (Dir_Search) loop
         Get_Next_Entry (Dir_Search, Dir);
         --  load file
         Open (File => File,
                  Mode => In_File,
                  Name => Full_Name (Dir));
         declare
            Title_Tag_String : Ada.Strings.Unbounded.Unbounded_String;
            Body_String : Ada.Strings.Unbounded.Unbounded_String;
            Current_Line_Count : Integer := 1;
            Tag_Title_Match : Boolean := False;
         begin
            --  Iterate over first two lines in the file (title and tags)
            while not End_Of_File (File) loop
               if Current_Line_Count > 2 then
                  Ada.Strings.Unbounded.Append (Body_String,
                                                   Get_Line (File));
               else
                  Ada.Strings.Unbounded.Append (Title_Tag_String,
                                                   Get_Line (File));
                  if Ada.Strings.Unbounded.Index (Title_Tag_String, TQuery) > 0 then
                     Tag_Title_Match := True;
                  end if;
               end if;
               Current_Line_Count := Current_Line_Count + 1;
               exit when Current_Line_Count = 3 and then not Tag_Title_Match;
            end loop;
            if Ada.Strings.Unbounded.Index (Body_String, BQuery) > 0 then
               Print_File (Dir);
            end if;
         end;
         Close (File);
      end loop;
   end Search_Jot_Bodies_Nested;
   procedure Search_Jot_Bodies (Query : String) is
      File : File_Type;
      Dir : Directory_Entry_Type;
      Dir_Search : Search_Type;
   begin
      --- Load files
      Start_Search (Search => Dir_Search,
                     Directory => Path,
                     Pattern => Jot_File_Extension_Pattern);
      --  Iterate over files
      while More_Entries (Dir_Search) loop
         Get_Next_Entry (Dir_Search, Dir);
         --  load file
         Open (File => File,
                  Mode => In_File,
                  Name => Full_Name (Dir));
         declare
            Title_Tag_String : Ada.Strings.Unbounded.Unbounded_String;
            Current_Line_Count : Integer := 1;
         begin
            --  Iterate over first two lines in the file (title and tags)
            while not  End_Of_File (File) loop
               if Current_Line_Count > 2 then
                  Ada.Strings.Unbounded.Append (Title_Tag_String,
                                                   Get_Line (File));
               else
                  Skip_Line (File);
               end if;
               Current_Line_Count := Current_Line_Count + 1;
            end loop;
            --  Check for substring
            if Ada.Strings.Unbounded.Index (Title_Tag_String, Query) > 0 then
               Print_File (Dir);
            end if;
         end;
         Close (File);
      end loop;
   end Search_Jot_Bodies;
   procedure Print_File (Dir : Directory_Entry_Type) is
   begin
      Put (Full_Name (Dir));
      Set_Col (50);
      if Kind (Dir) = Ordinary_File then
         Put (Size (Dir)'Image);
      end if;
      Set_Col (60);
      Put_Line (Kind (Dir)'Image);
   end Print_File;
end Jot_Store.Reader;