hdbPath: getenv`hdb

if[""~hdbPath; / exiting if environment variable is not defined
    -1"exiting! ",.wrap.PROC," environment variable is not define";
    exit 1
  ]

/ 2. Define the reload function to load the database from the HDB path
reload:{[]
  -1 "Reloading HDB from disk...";
  system "l ", ssr[getenv`HDB;"\\";"/"]
  };


reload[];

