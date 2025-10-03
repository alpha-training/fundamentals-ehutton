h:hopen 5010
SYMS: `JPM`GOOG`TSLA`BRK


/ this needs to take raw data and convert them into lists
genListTrade:{[]
            N: 1+rand 1000;
            (`trade;(
            N#.z.p;
            N?SYMS;
            N?100;
            N?1000.0
    ))
 }


/ this needs to take raw data and convert them into lists 
genListQuote:{[]
            N: 1+rand 1000;
            (`quote;(
            N#.z.p;      / a list of timestamps
            N?SYMS;      / a list of symbols
            N?1000.0;    / a list of bids
            N?1000.0;    / a list of asks
            N?100;       / a list of bid sizes as integers
            N?100        / a list of ask sizes as integers
      ))
  }
 

/ upon each tick this need to send an async command to run the upd function in the ticketplant

 .z.ts:{
    Q: genListQuote[];
    T: genListTrade[];
    neg[h](`.u.upd;Q[0];Q[1]);
    neg[h](`.u.upd;T[0];T[1])
 }

\t 100


/ 
Kieran Feedback

neg[h](`.u.upd;Q 0;Q 1);   / lose the square brackets
Your style of doing it across multiple lines is not traditional q-like but it has its advantages and it works, which is the main thing