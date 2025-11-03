p:1+(1+til 5)?'10;

pyr:{[p]
    first {moves:reverse each flip (1_x;-1_x); / finds the list of available moves
    y+'max each moves} over reverse p
    
 }

/ pyr over reverse p