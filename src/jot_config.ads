package Jot_Config is
   type State is (Waiting, Running, Ending);
   type Flag_Index is range 1 .. 3;
   type Flag is (B, P, T, I);
   type Flag_Array is array (Flag) of Boolean;
   procedure Configure_Datastore;
end Jot_Config;