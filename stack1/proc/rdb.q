/ rdb.q

\e 1
h:hopen 5010
PROCS:("SSI";enlist",") 0:`:proc/config/processes.csv;

sub:{[t];
    h(`.u.sub;t);
 }
upd:{[t;x]
    $[t in `trade`quote; upsert[t;x];
       t = `.u.end;      .u.end x;
       -1"Unknown message type received by upd: ", string t]
    };

trade1:([]
  sym:   `GOOG`MSFT`AAPL;
  time:  .z.p + 00:00:01*til 3;
  price: 100.1 100.2 100.3;
  size:  100 200 150;
  exchange: 3?`L`N`T
  )

trade2:([]
  sym:   `IBM`VOD`TSCO`AMZN;
  time:  .z.p + 00:00:10 + 00:00:01*til 4;
  price: 25.5 26.0 25.8 26.2;
  size:  500 1000 300 700;
  exchange: 4?`L`N`T
  )

.u.end:{[d] -1"end of day has been called for date: ",string d;
    savetable[d] each tables`;
  
    hdbPort: 7h$(flip select port from PROCS where proc=`hdb)[`port][0];

    -1 "Attempting to connect to HDB on port ",(string hdbPort)," to trigger reload...";
    hdbHandle: @[hopen;hdbPort;{ -1 "HDB reload failed: ",x}];

  / 5. If connection succeeded, send the reload command and close the handle
    if[not null hdbHandle;
      -1 "HDB reload signal sent.";
      hdbHandle"reload[]";
      hclose hdbHandle;
      ];
 }


savetable:{[d;t] / need to edit this to save the the environment variable 
  -1 "Saving table ",(string t)," for date ",(string d),". Row count: ",string count get t;
  hdbPath:getenv`HDB;  
  sorted: `sym`time xasc get t;
  parted: update `p#sym from sorted;
  / 2. Construct the file path for saving
  file: hsym`$hdbPath,"/",(string d),"/",(string t),"/"; / added the/ at the end to make it splayed
  file set .Q.en[hsym`$hdbPath;parted];
  
  delete from t
 }


/
-1 "Subscribing to `trade and `.u.end...";
h(`.u.sub;`trade);
h(`.u.sub;`.u.end);
/
Kieran Feedback

sub:{[t];  -> sub:{[t]  you don't need a ; after the arguments
