myAbs: {[x] x * signum x}

/ 
decent
another option
myAbs:{x|neg x}

the issue with your solution is can change the type e.g.

q)myAbs 10h
10i
