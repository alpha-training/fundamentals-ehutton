trade:([sym:`GOOG`MSFT`AAPL]size:100 200 500;price:150.25 240.10 175.50)
updates:([sym:`MSFT`AAPL`IBM];size:250 700 1000;price:242.00 178.20 130.40)

/
/ find the keys to insert or update
kti:(key updates)except key trade
ktu:(key updates)inter key trade

/ find the rows which need inserting or updating
rti:select from updates where sym in kti`sym
rtu:select from updates where sym in ktu`sym
/
/ make the necessary changes to the trade table 
if[count kti;`trade insert rti]
if[count ktu;`trade lj rtu]

.[data; indices; function; argument]

