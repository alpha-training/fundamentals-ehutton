\d .log

print: {[msgType;message] -1 string[.z.p] ," ",msgType," ", string[.z.w]," ", message;}

info: print["INFO";]
error: print["ERROR";]

\d .