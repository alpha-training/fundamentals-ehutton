\l /home/ehutton/fundamentals-ehutton/stack1/proc/config/schema.q



\e 1
h:@[hopen;5010;{-1"failed to connect to tickerplant! exiting.";exit 1}]
t:.schema.t.trade
q:.schema.t.quote

sub:{[t]
  h(`.u.sub;t)
 }
upd:{[t;x]
  t upsert x
 }


getLast:{[s;incQuotes]    / getLast[`JPM`GOOG;0b]    gets last trade
   if[incQuotes~1b;:-1#select from aj[`sym`time;trade;quote] where sym in s];
   :-1#select from trade where sym in s
 }

.u.end:{[d]}

 /

 trade:([sym:6#`MSFT`GOOG`JPM] time:.z.d+til 6;price:6?100f;size:6?100;ex:6?`N`L`T)
quote:([sym:6#`MSFT`GOOG`JPM] time:.z.d+til 6;bid:6?100f;ask:6?100f)