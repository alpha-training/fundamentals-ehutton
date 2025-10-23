\l db

hdbPath:getenv`HDB

if[""~hdbPath; / exiting if environment variable is not defined
    -1"exiting! HDB environment variable is not define";
    exit 1
  ]

/ 2. Define the reload function to load the database from the HDB path
reload:{getenv`HDB}


reload[];

getTrades:{[dateRange;syms;incQuotes] / getTrades[2025.09.03 2025.10.20;`GOOG`MSFT;1b]
  r:dateRange[0]+til dateRange[1]-dateRange[0]-1;
  imt:select from trade where date in r,sym in syms;
  imq:select from quote where date in r,sym in syms;
  if[incQuotes~1b;:select sym,time,price,size,bid,ask from aj[`sym`time;imt;imq]];
  :select sym,time,price,size from trade where date in r,sym in syms
 }

getPort:{0N!(`start;.z.t);do[1000;til 500000];0N!(`end;.z.t);system "p"}

testB:{10 20 30}