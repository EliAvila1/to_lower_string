package To_Lower_String
with SPARK_Mode => On
is

   procedure to_lower (Itm : in out String)
     with
       Pre => (Itm'First = 1)
       and then (Itm'Length >= 1)
       and then (Itm'Last = Itm'Length)
       and then (Itm'Length <= 100),
       Post => (for all I in Itm'First .. Itm'Last =>
                  (if Character'Pos (Itm'Old (I)) in 65 .. 90
                     then Character'Pos (Itm (I))
                   = Character'Pos (Itm'Old (I)) + 32
                       else Itm (I) = Itm'Old (I))),
       Global => null,
       Depends => (Itm => Itm);

end To_Lower_String;
