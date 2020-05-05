# run.sh
JVM0=/mnt/sams-ssd/Code-ssd/java/source/jdk/build/linux-x64/images/jdk/bin/java 
JVM1=$JVM0


#CMDS="-Xshare:on -cp ${HOME}/tmp HelloWorld"
#CMDS="-Xint -XX:-UsePerfData $CMDS"

#CMDS="-Xint -XX:-UsePerfData -version"
CMDS=-"XX:+UnlockExperimentalVMOptions -XX:+UseEpsilonGC -Xmx1024M -XX:EpsilonMaxTLABSize=8M -XX:MinTLABSize=8M -XX:HeapSnapshottingMode=0 -Xint -XX:-UsePerfData  -version"

if test "$1" = "init"; then
    set -x
    $JVM0 -Xshare:dump -Xlog:cds=debug | grep 'of total'
    $JVM1 -Xshare:dump -Xlog:cds=debug | grep 'of total'

    $JVM0 -showversion $CMDS
    $JVM1 -showversion $CMDS

    # Janiuk: dump the heap snapshot	
    CMDS=-"XX:+UnlockExperimentalVMOptions -XX:+UseEpsilonGC -Xmx1024M -XX:EpsilonMaxTLABSize=8M -XX:MinTLABSize=8M -XX:HeapSnapshottingMode=4 -Xint -XX:-UsePerfData  -version"
    $JVM1 $CMDS

    exit
fi


CMDS=-"XX:+UnlockExperimentalVMOptions -XX:+UseEpsilonGC -Xmx1024M -XX:EpsilonMaxTLABSize=8M -XX:MinTLABSize=8M -XX:HeapSnapshottingMode=0 -Xint -XX:-UsePerfData  -version"
CMDS2=-"XX:+UnlockExperimentalVMOptions -XX:+UseEpsilonGC -Xmx1024M -XX:EpsilonMaxTLABSize=8M -XX:MinTLABSize=8M -XX:HeapSnapshottingMode=3 -Xint -XX:-UsePerfData  -version"

$JVM0 $CMDS
$JVM1 $CMDS2

for i in 1 2 3 4 5 6 7 8 9 10; do
#for i in 1 2; do
    perf stat -r 400 $JVM0 $CMDS > /dev/null
    perf stat -r 400 $JVM1 $CMDS2 > /dev/null
done

