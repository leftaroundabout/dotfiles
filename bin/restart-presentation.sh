#!/bin/bash
ps -C cabal -o pid,args | grep kolloq | while read p
do
  pid=$(sed 's/\([0-9]*\).*/\1/' <<< "$p")
  cmd=$(sed 's/[0-9]* //' <<< "$p")
  pkill -TERM -P $pid
  # $cmd
done
