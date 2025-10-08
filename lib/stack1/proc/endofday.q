.u.end:{[d]
/ include a log statement here that .u.end has been called for date=...
/ call savetable for each table in memory (can use tables` to get that)
-1".u.end has been called for date ", string[.z.d-1];


 }
 
savetable:{[d;t] 
	/ print log statement here that prints out 
	/   the arguments
	/   current count of the table t
	/ save the table to data/[date]/[tablename]
	/ e.g. data/2025.08.30/trade
	/ once it's saved, clear out the table in memory
	/ this can be done with -> delete from t;
	}