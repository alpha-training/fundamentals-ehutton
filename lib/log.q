\d .log

print: {[msgType;message] -1 string[.z.p] ," ",msgType," ", string[.z.w]," ", message;}

info: print["INFO";]
error: print["ERROR";]

\d .

/ 

good
when you have a projection of the first argument, you don't need the the trailing ;

info: print["INFO"]    is fine

and in fact, you don't even need the square brackets

info:print"INFO"    is also fine

also try to get out of the (common) habit of leaving a whitespace after the : when assigning a variable

Notice no whitesspace above, still readable

in your print function, some unnecessary whitespace, perhaps shorten variable name to its essence
 
print:{[msgType;msg] -1 string[.z.p]," ",msgType," ",string[.z.w]," ",msg;}

A good q function should be no longer than it needs to be, while still being readable

we are down to the last 5% here, your solution is good
