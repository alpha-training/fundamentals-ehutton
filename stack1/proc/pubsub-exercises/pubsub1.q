/ pubsub1.q
	
\p 5005		
	
SYMS:`JPM`MSFT`TSLA`AAPL`GOOG

.z.ts:{
    -1"The timer is firing!!";
	.u.pub[`trade;.u.genTrade[]];
	.u.pub[`quote;.u.genQuote[]];
 }



\d .u

SYMS:`JPM`MSFT`TSLA`AAPL`GOOG

genTrade:{  
        N: 1+rand 10;  
        ([]
        time: N#.z.p;
        sym: N?SYMS;
        size: N?100;
        price: N?1000.0
        )
 }
	
genQuote:{
    N: 1+rand 10;
    ([]
    time: N#.z.p;
    sym: N?SYMS;
    bid: N?1000.0;
    bidSize: N?100;
    ask: N?1000.0;
    askSize: N?100
    )
 }    
w:(0#`)!()		/ this is a dictionary of table names to handles
	


/ in here i need something like 
/ subscribers:()
/ sub:{subscribers,:.z.w} -> adds the calling handle to the list

sub:{[t] 
    w[t]:: distinct w[t],.z.w;
	/ Register the client's interest in that table using their handle
	/ Ensure that handles are unique
 }
	/for the below need to look back at the `upd in the vid



pub:{[t;x] 
    neg[w t]@\:(`upd;t;x)
    }

 / find out who is interested in this table
 / publish to them by calling `upd on the client
 / assume that upd expects a table name and the data
 
 
 / THIS IS WHEN we need to send the info to each person in sub
	  
.z.pc:{[h]
     w::{x except y}[;h] each w;
 } /so i need to do something like except x here how we did in the vid
	


 
		
\t 1000 / run the timer every second
/
pub:{[t;x]
    handles: w[t]; / the list of handles subscribed to table t
    neg[handles](`upd;t;x); / send an async message, telling each receiver to execute the `upd function with t and the table name and x the data
 } 