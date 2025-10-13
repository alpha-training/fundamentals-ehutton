\d .wrap

if[not `proc in key ARGS:first each .Q.opt .z.x;
 -1"missing argument: q wrap.q -proc [PROC]"; exit 1
 ]

PROC:ARGS`proc;

\d .

if["tick"~.wrap.PROC;-1"This is a tickerplant"];
if["rdb"~.wrap.PROC;-1"This is a Realtime Database"];