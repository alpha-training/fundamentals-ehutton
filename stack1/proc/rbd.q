/ rdb.q
trade1:([]
  sym:   `GOOG`MSFT`AAPL;
  time:  .z.p + 00:00:01*til 3;
  price: 100.1 100.2 100.3;
  size:  100 200 150
  )

trade2:([]
  sym:   `IBM`VOD`TSCO`AMZN;
  time:  .z.p + 00:00:10 + 00:00:01*til 4;
  price: 25.5 26.0 25.8 26.2;
  size:  500 1000 300 700
  )


h:hopen 5010
sub:{[t];
    h(`.u.sub;t);
 }
upd:upsert		/ Set this to upsert, nothing more needs to be done

.u.end:{[d]
  -1 ".u.end called for date: ", string d;
   d .u.savetable/: tables`;
 }
 
savetable:{[d;t] 
  -1 "Saving table ",string t," for date ",(string d),". Row count: ",string count get t;
/ Construct the file path for saving (e.g., `:data/2025.10.07/trade)
  fileHandle: `$(":data/", string[d], "/", string t);
 / Save the table to disk
  fileHandle set get t;
  / delete it from in-memory since its already saved on disk, so we free up ram for the next data
  delete from t;
 }