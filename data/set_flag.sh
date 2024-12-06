#!/bin/bash
# Add your startup script
if [ ! $DASFLAG ];then
 echo DASCTF{TEST_DASFLAG}|tee /root/challenge/flag
else
 echo $DASFLAG|tee /root/challenge/flag 
fi
