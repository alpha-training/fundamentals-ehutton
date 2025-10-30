\l /home/ehutton/fundamentals-ehutton/stack1/lib/event.q

\e 1

\d .cron

jobs:1!flip`func`start`period`lastRun`nextRun`error!"spnpp*"$\:()

.tst.time:()
.tst.pass:{-1"Pass function ran at ",string .z.t; .tst.time,: .z.t}
.tst.fail:{-1"Fail function ran at ",string .z.t; .tst.time,: .z.t;10+`a} / This will cause a 'type error



/ adds a a row to the jobs table, i.e someone comes along and schedules a job to be run
/ THIS WORKS
add:{[func;start;period]
    `.cron.jobs upsert (func; 12h$start; 16h$period; 0Np; 0Np; ""); / need to come back here and handle the error message 
 }


/ runs a job i.e executes function
run1:{[job;now]
  period:(jobs job)[`period];
  output:@[(get job);`;{x}];
  .cron.jobs:update lastRun:now,nextRun:now+period,error: enlist output from jobs where func=job;
 }



 /finds all overdure jobs and runs the run1 function on each of them 
run:{run1[;x]each exec func from .cron.jobs where nextRun<x;}

\d .

.event.addHandler[`.z.ts;`.cron.run]

\t 1000

/

/ test commands

.cron.add[`.tst.pass; .z.p + 0:00:030; 00:00:05]
.cron.add[`.tst.fail; .z.p + 00:00:04; 00:00:10]
.cron.add[`.u.end; .z.p + 0:00:03; 00:00:05]
