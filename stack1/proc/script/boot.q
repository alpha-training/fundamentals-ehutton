
\l /home/ehutton/fundamentals-ehutton/stack1/proc/ipc.q
\l /home/ehutton/fundamentals-ehutton/stack1/lib/cron.q
\l /home/ehutton/fundamentals-ehutton/stack1/lib/event.q
\l /home/ehutton/fundamentals-ehutton/stack1/lib/log.q
\d .wrap

if[not `proc in key ARGS::first each .Q.opt .z.x;
 -1"missing argument: q boot.q -proc [PROC]"; exit 1
 ]
PROCESS: ("SSI*" ;enlist ",") 0:`:config/processes.csv;


PROC:ARGS`proc; /PROC is the arguments that are in the proc row
\d .
if[""~getenv(`DATA);
    -1"exiting! ",.wrap.PROC," environment variable is not define";
    exit 1
  ]

if["tick"~.wrap.PROC;-1"This is a tickerplant"];
if["rdb"~.wrap.PROC;-1"This is a Realtime Database"];
if["hdb"~.wrap.PROC;-1"This is an Historical Database"];

system "l ",(.wrap.PROC),".q";

PORT:7h$(flip (select port from .wrap.PROCESS where proc =`$.wrap.PROC))[`port][0]

-1"listening on port ",string PORT;
system "p ",string PORT /listening on the port

/
if["tick"~.wrap.PROC;-1"This is a tickerplant"];
if["rdb"~.wrap.PROC;-1"This is a Realtime Database"];







/Load any common libraries
/Load the process config file
/Load the relevant process file from the proc folder
/Listen on the appropriate port