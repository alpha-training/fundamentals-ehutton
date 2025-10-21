/ Inter-process communication
\e 1
\l /home/ehutton/fundamentals-ehutton/stack1/lib/event.q
\d .ipc

/ conns:1!flip`name`port`handle!"sii"$\:() / in here for process config

conns:update handle:0Ni from 1!("SSI" ;enlist ",") 0:`:config/processes.csv
/ If conns has a non-null handle for this process name, return it
/ If it doesn't, call tryConnect to try and establish a connection to that process
/ If successful, update conns with the handle
/ Whether the successful or not, return 0Ni or the handle respectively
conn:{[pname]
  if[not null h:(conns pname)`handle;
    :h
    ];
  pport:(exec port from .ipc.conns where name=pname)[0];
  h:.ipc.tryConnect(7h$pport);
  if[not null h;
    conns::update handle:h from conns where name=pname;
    ];

 }
/ conns update proc:name,port:pport,handle:h from conns where name=pname
/ Return 0Ni if a handle cannot be successfully established to the port
/ Otherwise return the new handle
tryConnect:{[port] @[hopen;port;0Ni]}


/ update the .ipc.conns table to set that handle to null
disconnect:{[h]
  conns::update handle:0Ni from conns where handle=h;
  }

\d .

.event.addHandler[`.z.pc;`.ipc.disconnect]