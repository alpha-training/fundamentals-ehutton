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