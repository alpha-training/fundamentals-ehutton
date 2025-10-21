\l /home/ehutton/fundamentals-ehutton/stack1/proc/cc.q
\l /home/ehutton/fundamentals-ehutton/stack1/proc/ipc.q
\l /home/ehutton/fundamentals-ehutton/stack1/lib/cron.q
\e 1
\d .client

heartbeat:{[pname;x]	/ heartbeat[`rdb1;`used`heap#.Q.w[]] .client.heartbeat[`rdb1;`used`heap#.Q.w[]] this should take no arguments
	h:(exec port from .cc.tab where name=pname)[0];
	if[null h:.ipc.conn`cc;:()];
	neg[h](`.cc.heartbeat;pname;x);
	}

\d .
.cron.add[`.client.heartbeat;.z.p;00:00:05]
/ add a cron job to heartbeat every 5 seconds
/ first heartbeat should go out now