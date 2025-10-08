\p 5010
\l C:/Users/ellio/fundamentals-ehutton/stack1/lib/cron.q

\d .u
w:(0#`)!()		/ dict of tables to subscribers 
sub:{[t] 
    w[t]:: distinct w[t],.z.w;
 }		/ register the subscriber's interest in t by amending w

pub:{[t;x] 
    neg[w t]@\:(`upd;t;x)
 }



COLS_DICT:()!()
COLS_DICT[`trade]:`time`sym`size`price`exchange
COLS_DICT[`quote]:`time`sym`bid`ask`bidSize`askSize`exchange

upd:{[t;x] 
  tbl: flip COLS_DICT[t]!x;
  .u.pub[t;tbl];
 }

end:{[]
    .u.pub[`.u.end; .z.d-1]
    }




.z.pc:{[h]
    w::{x except y}[;h] each w;
 }		/ remove any dropped handles from w

/ add the end of day function to the cron jobs table
.cron.add[`.u.end; .z.p + 00:00:03; 00:00:05]

\d .

/
Kieran Feedback

The feedback for .z.pc may be viewed in the feedback for the pubsub exercise

SCHEMA_DICT:()!()
SCHEMA_DICT[`trade]:`timestamp`symbol`long`float
SCHEMA_DICT[`quote]:`timestamp`symbol`float`float`long`long
