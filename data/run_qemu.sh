#!/bin/bash
# Add your startup script
cd /root/
qemu-system-x86_64 \
   -m 512 \
   -kernel bzImage \
   -append "root=/dev/sda console=ttyS0" \
   -hda rootfs.ext2 \
   -net nic,model=virtio -net user,hostfwd=tcp::2222-:22,hostfwd=tcp::9999-:9999 \
   -virtfs local,path=./challenge,mount_tag=host_file,security_model=passthrough,id=host_file \
   -nographic