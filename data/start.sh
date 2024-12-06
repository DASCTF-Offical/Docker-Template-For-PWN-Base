#!/bin/bash
# Add your startup script
###


if [ ! -f "/root/challenge/entrypoint.sh" ]; then
    echo "Error: File pwn does not exist."
    exit 2
fi

line=$(cat /root/challenge/entrypoint.sh)
# 使用正则表达式提取第一个以 './' 开头的路径
exec_path=$(echo "$line" | grep -o '\./[^ ]*' | head -n 1)

NX_PROTECTION=$(readelf -W -l "/root/challenge/$exec_path" 2>/dev/null | grep 'GNU_STACK')

if [[ $NX_PROTECTION =~ "RWE" ]]; then
    echo "NX Protection: Disabled (Stack is executable)"
    /root/patch.sh
    /root/set_flag.sh
    /root/run_qemu.sh
else
    echo "NX Protection: Enabled (Stack is not executable)"
	cp -r /root/challenge/* /home/ctf/challenge
    /root/patch2.sh
	cp -r /home/ctf/challenge/* /home/ctf
    if [ ! $DASFLAG ];then
        echo DASCTF{TEST_DASFLAG_N}|tee /home/ctf/flag
    else
        echo $DASFLAG|tee /home/ctf/flag 
    fi
	chown -R root:ctf /home/ctf
	chmod -R 750 /home/ctf
	chmod 740 /home/ctf/flag
	chmod 666 /home/ctf/dev/null
	/etc/init.d/xinetd start;
fi


####
sleep infinity;