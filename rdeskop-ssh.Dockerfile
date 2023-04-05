FROM linuxserver/rdesktop
RUN apk update && \
    apk add --no-cache openssh-server && \
    mkdir /run/sshd && \
    echo 'abc:abc' | chpasswd
EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]

