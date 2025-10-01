\p 5010
\d .u

SUBS:(0#`)!()

sub:{[t]  $[11=type t;.z.s each t;SUBS[t],.z.w]}

.z.pc:{SUBS::SUBS except 'x}

pub1:{[t;h] neg[h](-1;"You received an update for ", string t)}

pub:{[t] pub1[t] each SUBS t}
\d .