package Jott_Store is
   CLI_Argument_Error : exception;

   type Jott (Title_Length, Tag_Length, Body_Length : Natural) is record
      Title : String (1 .. Title_Length);
      Tags : String (1 .. Tag_Length);
      Jott_Body : String (1 .. Body_Length);
   end record;
private
   Path : constant String := "./jotts";
   Jott_File_Extension : constant String := ".md";
   Jott_File_Extension_Pattern : constant String := "*.md";
end Jott_Store;