#!/bin/bash
 x=1
 #i=0
while [ $x -le 3 ]
do
java -jar /jenkins-cli.jar -s http://10.60.2.9:8080/ -auth admin:admin build Testing_jenkins_cli -p param1=hello
x=$(($x+1))
#i=$(($i+1))
#echo $i
done