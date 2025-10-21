/ config/schema.q

files:key `:schemas/quote.csv;

/ two empty dictionaries for columns (c) and tables (t)
c:()!()
t:()!()

/ 3. Loop over each file to load its schema
schmLoad:{[file]
  tableName:`$ssr[string file;".csv";""];
  schema:("ct";enlist",") 0:file;
  c[tableName]:schema`c;
  dbg;
  t[tableName]:0#flip schema`c!value each (string schema`t),"$()";
 }
schmLoad each files