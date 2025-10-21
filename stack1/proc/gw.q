\l /home/ehutton/fundamentals-ehutton/stack1/proc/ipc.q
/ remember to delete this load in function since it will already be loaoded in when we launch with boot

procs:("SSI*";enlist ",") 0:`:config/processes.csv;
args:first each .Q.opt .z.x;

s:"|" vs (exec arg from procs where name=`$args`name)[0]
s[0]:ssr[s[0];"-servers ";""]
s:`$s

.ipc.conn each s
handles:exec handle from .ipc.conns where name in s

getFuns:{[h] h@\:"\\f"}
funs:getFuns handles
servers:s!funs

getfuncArgs:{[func] / getfuncArgs[`sub] returns a list size 2. first entry the function and the second a list of its arguments 
  fservers:(key servers) where func in/: value servers;
  handle:exec handle from .ipc.conns where name in fservers;
  args:(handle@\:"(value ",string[func],")[1]")[0];
  :(func;args);
  }

query:{[funcArgs] / query[(`getTrades;`dateRange`syms`incQuotes)]
  fservers:(key servers) where funcArgs[0] in/: value servers;
  handles:exec handle from .ipc.conns where name in fservers; 
  :raze handles@\:(funcArgs[0];funcArgs[1]);
 }