package Jot_Store is
   CLI_Argument_Error : exception;

   type Jot (Title_Length, Tag_Length, Body_Length : Natural) is record
      Title : String (1 .. Title_Length);
      Tags : String (1 .. Tag_Length);
      Jot_Body : String (1 .. Body_Length);
   end record;
private
   Path : constant String := "./jots";
   Jot_File_Extension : constant String := ".md";
   Jot_File_Extension_Pattern : constant String := "*.md";
end Jot_Store;