\d .event	

handlers:(0#`)!()		/ dictionary of event names to handlers

/ addHandler is used to add a handler for an event
/ if it's the first handler for this event (i.e. 0=handlers event, you need to define that event)
/ e.g. if .event.addHandler[`.z.pc;`someFunc] is called, and `.z.pc is not a key in the handlers dictionary, you will need to define .z.pc. However if it is defined, you don't need to re-define it
/ To do this, use the phrase event set fire event
addHandler:{[event;handler]
  if[not count handlers event;
    event set .event.fire[event;] / event set is the same as writing `.z.pc:... we cant just write event:... as it will literally name a varibale called event
    ]; / .event.fire[...] is the path to the fire function (since we wrote it in \d .event) so q then runs the command (something like) `.z.pc: .event.fire[.z.pc;]
  handlers[event],:enlist handler; / this joins our current list of handlers (for this event) and joins it with the new handler
  }

/ next is to write the fire function
/ event is the event name e.g. `.z.pc
/ arg is the argument (e.g. .z.pc always takes a handle)
fire:{[event;arg] (handlers event)@\:arg} /we define the fire function here, we look up all of the functions in the dictionary under the event and @\:arg allows us to execute all of the functions with the same argument at once


\d .

\
everything from here down is ignored, due to the \ comment above
some sample code to test with

myOpenFunc1:{-1"Handle opened on ",string x;}
myOpenFunc2:{-1"Second handler for open on handle ",string x;}
.event.addHandler[`.z.po;`myOpenFunc1]
.event.addHandler[`.z.po;`myOpenFunc2]
Now you can test this by connecting to your process from another
