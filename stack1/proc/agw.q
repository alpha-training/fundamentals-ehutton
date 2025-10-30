\l /home/ehutton/fundamentals-ehutton/stack1/proc/ipc.q
\p 5015
\d .gw

CLIENT_REQ:1000i;
SERVER_REQ:1000i;
clientRequests:1!flip`clientReqID`handle`requests`responses`responded!"iiiib"$\:();
serverRequests:flip`serverReqID`clientReqID`responded`result`error!"iib**"$\:();

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

asyncCallback:{neg[.z.w] get x}

query:{[funcArgs] /.gw.query[(`getTrades;(2025.09.03 2025.10.29;`GOOG`MSFT;1b))]
    func:funcArgs 0;arg:funcArgs 1;
    fservers:(key servers) where func in/: value servers; / servers the function is on (`rdb`hdb)
    handles:exec handle from .ipc.conns where name in fservers;
    .gw.CLIENT_REQ+::1;
    `.gw.clientRequests upsert (.gw.CLIENT_REQ;.z.w;count fservers;0;0b);
    {[h1;f;a]`.gw.serverRequests upsert (.gw.SERVER_REQ+::1;.gw.CLIENT_REQ;0b;(::);(::));
    neg[h1](`gwResponse;.gw.CLIENT_REQ;.gw.SERVER_REQ;f;a);
    neg[h1][]; /dont really need this flush but it does no harm 
    }[;func;arg] each handles;
    update responded:1b from `.gw.clientRequests where clientReqID=.gw.CLIENT_REQ;
/ now need to call the gwResponse function to actually send the asynch calls
 }

serverResponse:{[cid;sid;res]
  update responses:responses+1 from `.gw.clientRequests where clientReqID=cid;
  if[`ERR~first res;
    update error:enlist 1_res from `.gw.serverRequests where serverReqID=sid
    ];
  update responded:1b,result:enlist res from `.gw.serverRequests where serverReqID=sid;
  rr:raze value exec requests,responses from `.gw.clientRequests where clientReqID=cid;
  h2:first exec handle from .gw.clientRequests where clientReqID=cid;
  if[rr[1]~rr[0];neg[h2](`.u.sub;raze exec result from .gw.serverRequests where clientReqID=cid)]
  }

.z.pc:{[h]
  cids:exec clientReqID from .gw.clientRequests where handle=h;
  delete from `.gw.clientRequests where handle=h;
  delete from `.gw.serverRequests where clientReqID in cids;
 }
\d .
/

saquery:{[funcArgs] / query[(`getTrades;`dateRange`syms`incQuotes)]
  fservers:(key servers) where funcArgs[0] in/: value servers;
  handles:exec handle from .ipc.conns where name in fservers; 
  neg[handles]@\:(asyncCallback;(funcArgs[0];funcArgs[1])); / send to each handles
  neg[handles]@\:(::); / flush
  raze handles@\:(::); / wait
 }
 