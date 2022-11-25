pragma Ada_2022;
with Ada.Text_IO; use Ada.Text_IO;
with Ada.Characters.Handling; use Ada.Characters.Handling;

package body Jot_Store.Reader is
   procedure Parse_Flags (Flag_Strings : String;
                          Jot_Flags : in out Flag_Array;
                          Flag_Count : in out Integer) is
   begin
      if Flag_Strings (Flag_Strings'First) /= Flag_Delimiter then
         return;
      end if;
      for Flag_Char_Index in 2 .. Flag_Strings'Length loop
         declare
            Flag_String : constant String :=  "" &
               To_Upper (Flag_Strings (Flag_Char_Index));
            Input_Flag : Flag;
         begin
            Input_Flag := Flag'Value (Flag_String);
            Jot_Flags (Input_Flag) := True;
            Flag_Count := @ + 1;
            exception
               when Constraint_Error =>
                  Put_Line ("Invalid Flag Detected: "
                     & "-"
                        & To_Lower (Flag_String));
         end;
      end loop;
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
   procedure Search_Jots_With_Flags (Jot_Flags : Flag_Array;
                                     TQuery : String := "";
                                     BQuery : String := "") is
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
            Title_Tag_String : SU.Unbounded_String;
            Body_String : SU.Unbounded_String;
            Current_Line_Count : Integer := 1;
            Tag_Title_Match : Boolean := False;
         begin
            --  Iterate over first two lines in the file (title and tags)
            while not End_Of_File (File) loop
               if Current_Line_Count > 2 and then Jot_Flags (B) then
                  SU.Append (Body_String,
                                                   Get_Line (File));
               else
                  if Jot_Flags (T) then
                     SU.Append
                        (Title_Tag_String, Get_Line (File));
                     if SU.Index
                        ( Process_String(Jot_Flags, Title_Tag_String), Process_String(Jot_Flags, TQuery)) >= 0
                     then
                        Tag_Title_Match := True;
                     end if;
                  else
                     Skip_Line (File);
                  end if;
               end if;
               Current_Line_Count := Current_Line_Count + 1;
               exit when Current_Line_Count = 3
                  and Jot_Flags (T)
                  and not Tag_Title_Match;
            end loop;
            if Jot_Flags (T) and then not
               Jot_Flags (B) and then
               SU.Index (Process_String(Jot_Flags, Title_Tag_String), Process_String(Jot_Flags, TQuery)) > 0
            then
               Print_File (Dir);
            end if;
            if Jot_Flags (B) and then SU.Index
               (Process_String(Jot_Flags, Body_String), Process_String(Jot_Flags, BQuery)) > 0
            then
               Print_File (Dir);
            end if;
         end;
         Close (File);
      end loop;
   end Search_Jots_With_Flags;
   function Process_String ( Jot_Flags : Flag_Array; Some_String : String ) return String is
   begin
      if Jot_Flags (I) then
         return To_Lower (Some_String);
      else
         return Some_String;  
      end if;
   end Process_String;
   function Process_String ( Jot_Flags : Flag_Array; Some_Unbounded_String : SU.Unbounded_String ) return SU.Unbounded_String is
   begin
      if Jot_Flags (I) then
         return SU.To_Unbounded_String( To_Lower (SU.To_String (Some_Unbounded_String)));
      else
         return Some_Unbounded_String;  
      end if;
   end Process_String;
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