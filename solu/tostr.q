tostr: {[x] $[type[x]=0h; .z.s each x; $[type[x]=-11h; string x; x]]}

/

three problems here, one minor, one medium and one major.

we'll start with the  minor problem

you do 'type[x]' twice, we never like to repeat work, always think of saving this in a variable, and '0=type x' would be nicer, the h is not needed

The second (slightly bigger) problem is you have done

$[condition;if-true;$[condition;if-true;else]]

what you should do is:

$[condition;if-true;condition;if-true;else]

i.e. you can put a condition in the third section, and in fact you can keep chaining your conditions like so

And finally to the major problem

q)tostr 10
10

your function doesn't turn anything but symols into strings

it also fails for lists of symbols

q)tostr`hey`there
`hey`there

Here is a suggested edit:

tostr: {$[0=t:type x;.z.s each x;10=abs t;x;string x]}

This function:

- Does recursion for general lists
- for a char (-10) and a string (10) it returns the argument
- anything else it strings