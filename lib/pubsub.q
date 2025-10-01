/ pubsub1.q
	
\p 5005		
	
SYMS:`JPM`MSFT`TSLA`AAPL`GOOG

.z.ts:{
	.u.pub[`trade;genTrade`];
	.u.pub[`quote;genQuote`];
 }
	
\d .u
	
w:(0#`)!()		/ this is a dictionary of table names to handles
	


/ in here i need something like 
/ subscribers:()
/ sub:{subscribers,:.z.w} -> adds the calling handle to the list

sub:{[t] 
    w[t]:: distinct w[t],.z.w
	/ Register the client's interest in that table using their handle
	/ Ensure that handles are unique
 }
	/for the below need to look back at the `upd in the vid




pub:{[t;x]
    neg[sub] @\: (`upd;`trade;trade)     / find out who is interested in this table
 / publish to them by calling `upd on the client
 / assume that upd expects a table name and the data
 } / THIS IS WHEN we need to send the info to each person in sub
	  
.z.pc:{w[t]::w[t] except x
 / Clean up (.u.)w when a handle drops
 } /so i need to do something like except x here how we did in the vid
	
genTrade:{
  / Get a random number of rows to generate
  N: 1+rand 10;
  
  ([] / this is how we create a table
    time: N#.z.p;      / Take N copies of the current timestamp
    sym: N?SYMS;      / Randomly draw N symbols from the SYMS list
    size: N?100;       / Generate N random integers for size
    price: N?1000.0     / Generate N random floats for price
  )
 }
	
genQuote:{
    N: 1+rand 10 / get a random number of rows to generate
    ([] /this is how we create a table
    time: N?.z.p;    / N copies of the time stamp
    sym: N?SYMS;     / N random symbols
    bid: N?1000.0;   / N random bids
    bidSize: N?100;  / N random bid sizes
    ask: N?1000.0;   / N random asks
    askSize: N?100   / N random ask sizes
    )
 }
		
\t 1000 / run the timer every second