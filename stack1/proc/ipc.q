/ Inter-process communication
\e 1
\l C:\Users\ellio\fundamentals-ehutton\stack1\lib\event.q
\d .ipc

/ conns:1!flip`name`port`handle!"sii"$\:() / in here for process config

conns:update handle:0Ni from 1!("SSI" ;enlist ",") 0:`:config/processes.csv
/ If conns has a non-null handle for this process name, return it
/ If it doesn't, call tryConnect to try and establish a connection to that process
/ If successful, update conns with the handle
/ Whether the successful or not, return 0Ni or the handle respectively
conn:{[name]
  if[not null h:(conns name)`handle;
    :h
    ];
  port:(.ipc.conns `server1)[`port];
  h: .ipc.tryConnect (7h$port);
  if[not null h ;
    conns::conns upsert (name;port;h)
    ];
    :h

 }

/ Return 0Ni if a handle cannot be successfully established to the port
/ Otherwise return the new handle
tryConnect:{[port] @[hopen;port;0Ni]}


/ update the .ipc.conns table to set that handle to null
disconnect:{[h]
  conns:: update handle:0Ni from conns where handle=h;
  }

\d .

.event.addHandler[`.z.pc;`.ipc.disconnect]