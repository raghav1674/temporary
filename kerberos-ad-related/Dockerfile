FROM ubuntu:latest

ENV DEBIAN_FRONTEND=noninteractive
ENV SSH_USERNAME=ubuntu
ENV PASSWORD=changeme

# Install OpenSSH server and clean up 
RUN apt-get update \
    && apt-get install -y openssh-server iputils-ping telnet iproute2  vim openjdk-8-jdk sudo krb5-user postgresql-client \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN useradd -rm -d /home/ubuntu -s /bin/bash -g root -G sudo -u 1000 $SSH_USERNAME 

RUN  echo "$SSH_USERNAME:$PASSWORD" | chpasswd

# Set up SSH configuration
RUN mkdir -p /home/$SSH_USERNAME/.ssh && chown $SSH_USERNAME /home/$SSH_USERNAME/.ssh \
    && echo "PasswordAuthentication yes" >> /etc/ssh/sshd_config \
    && echo "PermitRootLogin yes" >> /etc/ssh/sshd_config && \
    mkdir -p /home/$SSH_USERNAME/jars && chown $SSH_USERNAME /home/$SSH_USERNAME/jars && \
    echo "$SSH_USERNAME ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers && \
    echo "export SSH_USERNAME=$SSH_USERNAME" >> /home/$SSH_USERNAME/.bashrc && \
    echo 'export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64' >> /home/$SSH_USERNAME/.bashrc && \
    echo 'export PATH=$PATH:$JAVA_HOME/bin' >> /home/$SSH_USERNAME/.bashrc && \
    echo 'export CLASSPATH=$CLASSPATH:$JAVA_HOME/lib:/home/$SSH_USERNAME/jars/' >> /home/$SSH_USERNAME/.bashrc

RUN service ssh start

# Copy jars
COPY files/*.jar /home/$SSH_USERNAME/jars/

EXPOSE 22

CMD ["/usr/sbin/sshd","-D"]
