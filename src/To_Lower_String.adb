package body To_Lower_String
with SPARK_Mode => On
is

   procedure to_lower (Itm : in out String) is

      subtype convt is Positive range 65 .. 90
        with Static_Predicate => convt in 65 .. 90;

      subtype rest is Positive range 97 .. 122
        with Static_Predicate => rest in 97 .. 122;

      convert : convt := 65;
      restret : rest;

      Itm_Inicial : constant String   := Itm;
      Sum_To_Low  : constant Positive := 32;

   begin

      for I in Itm'First .. Itm'Last loop

         pragma Loop_Variant   (Increases => I);
         pragma Loop_Invariant (I in Itm'First .. Itm'Last);

         pragma Loop_Invariant (for all K in Itm'First .. I - 1 =>
                                  (if Character'Pos (Itm_Inicial (K)) in convt
                                   then Character'Pos (Itm (K))
                                   = Character'Pos (Itm_Inicial (K))
                                   + Sum_To_Low
                                   else Itm (K) = Itm_Inicial (K)));

         pragma Loop_Invariant (for all K in I .. Itm'Last =>
                                  Itm (K) = Itm_Inicial (K));

         if Character'Pos (Itm (I)) in convt then

            case convert is
               when convt =>
                  convert := Character'Pos (Itm (I));
                  restret := convert + Sum_To_Low;
            end case;

            if restret in rest then
               Itm (I)  := Character'Val (restret);
            end if;

         end if;

      end loop;

   end to_lower;

end To_Lower_String;
