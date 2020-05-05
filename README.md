The patch(es) are to be applied on top of 

changeset:   57904:0905868db490
user:        chagedorn
date:        Fri Jan 31 09:32:00 2020 +0100
summary:     8235332: TestInstanceCloneAsLoadsStores.java fails with -XX:+StressGCM

To test heap snapshotting, run with -XX:HeapSnapshottingMode=4 first to generate the snapshot and supporting structures

/build/linux-x64/images/jdk/bin/java -XX:+UnlockExperimentalVMOptions -XX:+UseEpsilonGC -Xmx1024M -XX:EpsilonMaxTLABSize=8M -XX:MinTLABSize=8M -XX:HeapSnapshottingMode=3 [any program]

(the snapshot is saved in a hardcoded location visible in source code). This will save snapshot and exit. Then, run again with 
-XX:HeapSnapshottingMode=4 to use the snapshot during boot:

/build/linux-x64/images/jdk/bin/java -XX:+UnlockExperimentalVMOptions -XX:+UseEpsilonGC -Xmx1024M -XX:EpsilonMaxTLABSize=8M -XX:MinTLABSize=8M -XX:HeapSnapshottingMode=4 [any program]

## TIMING

time difference has been analyzed between this restoration mode, and just normal execution (HeapSnapshottingMode=0). The details of this time analysis are in run.sh, output of run.sh is in log.txt. Afterwards, the tcl script has done analysis of log.txt and the output of that, with some comments, is in report.txt. The verdict, in short, is that snapshot restoring right now takes more time than just running normally.
