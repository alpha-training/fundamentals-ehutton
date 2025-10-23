/ rdb.q
\e 1
\l /home/ehutton/fundamentals-ehutton/stack1/proc/script/dbedit.q
\l /home/ehutton/fundamentals-ehutton/stack1/proc/config/schema.q

/h:hopen 5010
PROCS:("SSI";enlist",") 0:`:config/processes.csv;
trade:.schema.t.trade
quote:.schema.t.quote
\l db

sub:{[t];
    h(`.u.sub;t);
 }
upd:{[t;x]
    $[t in `trade`quote;upsert[t;x];
       t =`.u.end;.u.end x;
       -1"Unknown message type received by upd: ",string t]
    };



.u.end:{[d] -1"end of day has been called for date: ",string d;
    savetable[d] each tables`;
    hdbPort:7h$(flip select port from PROCS where proc=`hdb)[`port][0];
    -1"Attempting to connect to HDB on port ",(string hdbPort)," to trigger reload...";
    hdbHandle:@[hopen;hdbPort;{-1"HDB reload failed: ",x}];

  / 5. If connection succeeded, send the reload command and close the handle
    if[not null hdbHandle;
      -1"HDB reload signal sent.";
      hdbHandle"reload[]";
      hclose hdbHandle;
      ];
 }


savetable:{[d;t] / need to edit this to save the the environment variable 
  -1"Saving table ",string[t]," for date ",string[d],". Row count: ",string count get t;
  hdbPath:getenv`HDB;  
  sorted:`sym`time xasc get t;
  parted:update `p#sym from sorted;
  / 2. Construct the file path for saving
  file:hsym`$hdbPath,"/",string[d],"/",string[t],"/"; / added the/ at the end to make it splayed
  file set .Q.en[hsym`$hdbPath;parted];
  delete from t
 }

getTrades:{[dateRange;syms;incQuotes] / getTrades[2025.09.03 2025.10.20;`GOOG`MSFT;1b]
  r:dateRange[0]+til dateRange[1]-dateRange[0]-1;
  if[not .z.d in r;:()];
  imt:select from trade where date in r,sym in syms;
  imq:select from quote where date in r,sym in syms;
  if[incQuotes~1b;:aj[`sym`time;imt;imq]];
  :select from trade where date in r,sym in syms
 }
getPort:{0N!(`start;.z.t);do[1000;til 500000];0N!(`end;.z.t);system "p"}

testA:{10 20 30}
testB:{40 50 60}
/
-1 "Subscribing to `trade and `.u.end...";
h(`.u.sub;`trade);
h(`.u.sub;`.u.end);
/
Kieran Feedback

sub:{[t];  -> sub:{[t]  you don't need a ; after the arguments
`:2025.09.03/trade/.d`:2025.09.02/trade/.d