\p 5010

\d .u
w:(0#`)!()		/ dict of tables to subscribers 
sub:{[t] 
    w[t]:: distinct w[t],.z.w;
 }		/ register the subscriber's interest in t by amending w

pub:{[t;x] 
    neg[w t]@\:(`upd;t;x)
 }


COLS_DICT:()!()
COLS_DICT[`trade]:`time`sym`size`price
COLS_DICT[`quote]:`time`sym`bid`ask`bidSize`askSize

upd:{[t;x] 
  tbl: flip COLS_DICT[t]!x;
  .u.pub[t;tbl];
 }





.z.pc:{[h]
    w::{x except y}[;h] each w;
 }		/ remove any dropped handles from w

\d .