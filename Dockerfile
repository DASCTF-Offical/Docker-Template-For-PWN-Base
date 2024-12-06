FROM ubuntu:16.04

RUN sed -i "s/http:\/\/archive.ubuntu.com/http:\/\/mirrors.ustc.edu.cn/g" /etc/apt/sources.list && \
    apt-get update && apt-get -y dist-upgrade && \
    apt-get install -y lib32z1 xinetd file patchelf qemu-system-x86 binutils

COPY ./data/ /root/
RUN chmod +x /root/*.sh


RUN useradd -m ctf

WORKDIR /home/ctf


RUN mkdir /home/ctf/dev && \
    mknod /home/ctf/dev/null c 1 3 && \
    mknod /home/ctf/dev/zero c 1 5 && \
    mknod /home/ctf/dev/random c 1 8 && \
    mknod /home/ctf/dev/urandom c 1 9 && \
    chmod 666 /home/ctf/dev/*

RUN mkdir /home/ctf/bin && \
    cp /root/binary/* /home/ctf/bin
	
RUN mkdir /home/ctf/daslibs && \
    cp /root/daslibs/* /home/ctf/daslibs

RUN mkdir /home/ctf/challenge



RUN cp /root/ctf.xinetd /etc/xinetd.d/ctf


CMD ["/root/start.sh"]

EXPOSE 9999
