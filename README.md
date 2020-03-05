The patch(es) are to be applied on top of 

changeset:   57904:0905868db490
user:        chagedorn
date:        Fri Jan 31 09:32:00 2020 +0100
summary:     8235332: TestInstanceCloneAsLoadsStores.java fails with -XX:+StressGCM

To test heap snapshotting, run with -XX:NewCodeParameter=2 first to generate the snapshot and supporting structures

java -XX:+UnlockExperimentalVMOptions -XX:+UseEpsilonGC -Xmx32M -XX:NewCodeParameter=2 [any program]

(this is saved in a hardcoded location visible in source code). This will save snapshot and exit. Then, run again with 
-XX:NewCodeParameter=1 to use the snapshot during boot:

java -XX:+UnlockExperimentalVMOptions -XX:+UseEpsilonGC -Xmx32M -XX:NewCodeParameter=1 [any program]

You can trace the ececuted bytecodes to notice that 14 bytecodes at the start are not executed.
Execution seems to work as normal, at least I have not yet found a program which it would not work for.
However, this is higly system-dependent, currently I'm just developing with my own laptop as target.
