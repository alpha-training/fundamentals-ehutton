/ rdb.q

h:hopen 5010
sub:{[t];
    h(`.u.sub;t);
 }
upd:upsert		/ Set this to upsert, nothing more needs to be done

/
Kieran Feedback

sub:{[t];  -> sub:{[t]  you don't need a ; after the arguments