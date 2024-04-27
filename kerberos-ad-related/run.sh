#!/usr/bin/env bash

docker rm -f webshell krb5
docker network rm localnet

docker network create  localnet 

docker run -d --privileged \
--security-opt seccomp=unconfined \
--net localnet \
--name webshell -p 8018:80 \
-e ALLOWED_NETWORKS=0.0.0.0/0 bwsw/webshell 

docker run -d -v $(pwd)/code/:/home/ubuntu/krb5/ \
--net localnet \
--name krb5 raggupta/ubuntu-testvm:v1


# Show the ipaddress of krb5 container , along with username as 'ubuntu' and password as 'changeme' in a nice format

tee view.txt <<EOF
echo "Url: http://localhost:8018"

echo "Server IP Address: $(docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' krb5)"
echo "Port: 22"
echo "Username: ubuntu"
echo "Password: changeme"
EOF

# docker exec -u ubuntu -it krb5 bash
