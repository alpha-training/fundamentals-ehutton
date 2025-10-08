/ allcols`:db/2025.09.01/quote
/ return the contents of the .d file in that directory
\e 1


allcols:{[tabledir] 
    file: `$(string (hsym tabledir));   
    list: (file; `.d);
    path: ` sv list;
    col:get path; /this returns the columns names only need up to here for allcols
    list: (file;col[0]);
    path: ` sv list;
    get path
 }


/ add1col[`:db/2025.09.01/quote;`volume;0N]
/ accepts the full path to a table directory, the name of the column, and default value
/ if the colname is not already in the .d file, do the following
/	- print out a statement saying what you're about to do (include args)
/	- obtain the count of the first column in the .d file, to determine how many records exist
/	- create a new file in the directory populated with deafault values of the same length
/	- add the new column name to the .d file


add1col:{[tabledir;colname;defaultvalue]
   -1"fetching size of",(string tabledir)," and adding the column: ",(string colname)," to the table";
    file: `$(string (hsym tabledir));   
    list1: (file; `.d);
    path1: ` sv list1;
    col:get path1; /this returns the columns names only need up to here for allcols

    list2: (file; col[0]);
    path2: ` sv list2;
    size: count get path2; /this successfully gets the size of the table
    colpath: `$((string tabledir), "/", (string colname)); / added the/ at the end to make it splayed
    defaultData: size#(defaultvalue);
    colpath set defaultDdata;
    path1 set col,colname;
  }



/ delete1col[`:db/2025.09.01/trade;`volume]
/ accepts the full path to a table directory, and the name of the column
/ if the column is in the .d file
/ 	- print out a statement saying what you're about to do (include args)
/ 	- delete the column file from folder
/ 	- delete the column name from the .d file
delete1col:{[tabledir;col]
/ can probably use except `colname in here
   /  `:quote/.d set `time`ask`bid
  }
/
To take another example, if you call add1col for a given db/date/table folder, in which all the columns are — say — 10 long, and for the second argument you have `tradetime and the default value is 0Np (null timestamp), then your .d file should have `tradetime added to it, and a new tradetime file should be added to that folder which is equal to 10#0Np.

Hint - @ with files
The expressions @[folderpath;filename;monad] and @[folderpath;filename;dyad;arg2]can be very useful for editing files on disk:

q)`:db/L set 1 2 3
`:db/L
q)
q)get`:db/L
1 2 3
q)
q)@[`:db;`L;neg]
`:db
q)get`:db/L
-1 -2 -3
q)@[`:db;`L;,;5]		/ monad
`:db
q)get`:db/L				/ dyad
-1 -2 -3 5
