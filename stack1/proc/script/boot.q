
\l C:\Users\ellio\fundamentals-ehutton\stack1\proc\ipc.q
\l C:\Users\ellio\fundamentals-ehutton\stack1\lib\cron.q
\l C:\Users\ellio\fundamentals-ehutton\stack1\lib\event.q
\l C:\Users\ellio\fundamentals-ehutton\stack1\lib\log.q
\d .wrap

if[not `proc in key ARGS::first each .Q.opt .z.x;
 -1"missing argument: q boot.q -proc [PROC]"; exit 1
 ]

PROC:ARGS`proc; /PROC is the arguments that are in the proc row

\d .
if[""~getenv(`$(.wrap.PROC));
    -1"exiting! ",.wrap.PROC," environment variable is not define";
    exit 1
  ]
if["tick"~.wrap.PROC;-1"This is a tickerplant"];
if["rdb"~.wrap.PROC;-1"This is a Realtime Database"];

system "l " ,(.wrap.PROC),".q";

PORT:(7h)$(flip (select port from .ipc.conns where proc = `$(.wrap.PROC)))[`port][0]

-1"listening on port ",string(PORT);
system "p ", string(PORT) /listening on the port

/
if["tick"~.wrap.PROC;-1"This is a tickerplant"];
if["rdb"~.wrap.PROC;-1"This is a Realtime Database"];







/Load any common libraries
/Load the process config file
/Load the relevant process file from the proc folder
/Listen on the appropriate port