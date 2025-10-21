

/ .z.ts:{[] -1"sending heartbeat to cc"; neg[h] (`.cc.heartbeat; `rdb1; `used`heap#.Q.w[]);  }; 
\d .cc
procs:1!flip`name`proc`pid`status`last_heartbeat`used`heap!"ssispjj"$\:()

tab:("SSI";enlist ",") 0:`:config/processes.csv


procs:procs upsert enlist(`rdb1;`rdb;0i;`down;0Np;0j;0j);

/ always called by a remote process
/ update .cc.procs with the last heartbeat for that process
/ also update the status and pid columns
heartbeat:{[pname;x] / .cc.heartbeat[`rdb1;`used`heap#.Q.w[]]
    .cc.procs::update
    pid:.z.i,   
    status:`up,
    last_heartbeat:.z.p,
    used:x`used,
    heap:x`heap
    from .cc.procs where name=pname;
  }

start:{[pname] 	/ .cc.start`tp1  this works but there is an orphaned q process 5010 somewhere and hdb needs finishing
  QHOME:getenv`QHOME;
  port:(flip select port from tab where name=pname)[`port][0]; /exec
  file:(flip select proc from tab where name=pname)[`proc][0]; /exec
  command:"nohup ",QHOME,"/l64/q " string[file],".q -p",string[port], " </dev/null >> log/file1.log 2>&1 &";
  system command
  }

stop:{[pname]		/ .cc.stop`rdb1
  pid:(flip select pid from procs where name=pname)[`pid][0];
  cmd:"kill <",string[pid],">";
  system cmd
 }

startAll:{[] start each exec name from tab}

stopAll:{[] stop each exec name from tab}
	
kill:{[pname]		/ .cc.kill`rdb1
  pid:(flip select pid from procs where name=pname)[`pid][0];
  cmd:"kill -9 <",string[pi],">";
  system cmd   


   / this will use the system command kill -9 [PID]
   }

/ add a .z.pc event handler with this function
checkProcessDrop:{[h]
  -1"Handle ",string[h]," has dropped. Updating status.";
  `.cc.procs:: update status:`down,pid:0Ni,handle:0Ni from `.cc.procs where handle=h;
  }

\d .


/name				 table key, process name (same as name in .ipc.conns) e.g. `rdb1
/proc				 type of process e.g. `rdb
/pid					 (int), process id
/status				 symbol, one of `up`down`busy
/last_heartbeat		 timestamp
/used			 long, memory used
/heap			 long, heap memory used