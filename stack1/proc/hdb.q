\l db
\e 1
hdbPath:getenv`HDB

if[""~hdbPath; / exiting if environment variable is not defined
    -1"exiting! HDB environment variable is not define";
    exit 1
  ]

/ 2. Define the reload function to load the database from the HDB path
reload:{getenv`HDB}


reload[];

getTrades:{[dateRange;syms;incQuotes] / getTrades[2025.09.03 2025.10.29;`GOOG`MSFT;1b]
  imt:select from trade where date within dateRange,sym in syms;
  imq:select from quote where date within dateRange,sym in syms;
  if[incQuotes~1b;
  :aj[`sym`time;imt;imq]];
  select from trade where date in r,sym in syms
 }
gwResponse:{[cid;sid;func;Args] /gwResponse[1003;1003;`getTrades;(2025.09.03 2025.10.29;`GOOG`MSFT;1b)]
  res:.[get func;Args;{:`ERR,x}]; /run func and get result
  neg[h](`.gw.serverResponse;cid;sid;res); /send back result by calling serverResponse
 }
/
 .u.runQuery:{[funcArgs] / .u.runQuery[(`getTrades;(2025.09.03 2025.10.29;`GOOG`MSFT;1b))]
  neg[h](`.gw.query;funcArgs)
 }










/ 
getPort:{0N!(`start;.z.t);do[1000;til 500000];0N!(`end;.z.t);system "p"}

testB:{10 20 30}
testB:{10 20 30}

add in heartbeat