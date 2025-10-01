/ client1.q
	
/ start this only after the pubsub is up
/ otherwise it will fail to connect
	
h:hopen 5005
	
upd:{[t;x]
 -1"Received update for ",string[t]," of ",string[count x]," records";
 t upsert x;		/ upsert will create the table on the first update
 }
	  
sub:{[t]
 / use h to call .u.sub function on the pubsub, with t as the argument
 }
	
/

to get things rolling you can do
sub`trade
sub`quote
or sub each`trade`quote
	
check if the tables are growing
count trade 
count quote