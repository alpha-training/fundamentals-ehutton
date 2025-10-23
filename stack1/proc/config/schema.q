/ config/schema.q

\d .schema

q:("SS";enlist ",") 0:`:config/schemas/quote.csv;
t:("SS";enlist ",") 0:`:config/schemas/trade.csv

cq:q`c;
ct:t`c;
typet:raze string t`t
typeq:raze string q`t


f1:{[tp] tp$()} / takes a type and returns its null value
trade:flip ct!f1 each typet
quote:flip cq!f1 each typeq
c: `trade`quote ! (ct; cq)
t: `trade`quote ! (trade; quote)
\d .
/
trade:ct!f1 each typet
quote:cq!f1 each typeq
"sij"$\:()

/
Kieran Feedback

- You can load the type column as a char (C), not S
- The way you have defined the c & t dictionaries means you cannot use dot notation

I have fleshed out this exercise with a couple of more tips, as admittedly it was a bit sparse on info

Here is what I have for this:

\d .schema

c:t:1#.q

{{[dir;f]
  a:("SC";enlist",")0:` sv dir,f;
  tn:first` vs f;   / table name
  t[tn]:flip r:a[`c]!a[`t]$\:();
  c[tn]:cols r;
  }[x]each f where(f:key x)like"*csv"}`:config/schemas;

\d .