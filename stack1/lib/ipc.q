/ Inter-process communication

\l event.q
\e 1
\d .ipc

/ A config dictionary to map process names to their ports
dict:`server1`server2!5001 5002
/ BEFORE SUBMITTING TRY AND DO THIS WITHOUT THE DICTIONARY
conns:1!flip`name`port`handle!"sii"$\:()

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