package Jott_Config is
   type State is (Waiting, Running, Ending);
   type Flag_Index is range 1 .. 3;
   type Flag is (B, P, T, I, C);
   type Flag_Array is array (Flag) of Boolean;
   procedure Configure_Datastore;
end Jott_Config;