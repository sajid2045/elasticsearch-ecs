#!/bin/sh

# provision elasticsearch user
#addgroup sudo
#adduser -D -g '' elasticsearch
#adduser elasticsearch sudo
#chown -R elasticsearch /usr/share/elasticsearch/ /usr/share/elasticsearch/data
#echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

#http://logz.io/blog/elasticsearch-cluster-disconnects/
ethtool -K eth0 sg off

mkdir -p -v /usr/share/elasticsearch/data/data
mkdir -p -v /usr/share/elasticsearch/data/log

ln -s /usr/share/elasticsearch/data/log /var/log/elasticsearch

sysctl -w vm.max_map_count=262144

chown -R elasticsearch /usr/share/elasticsearch /usr/share/elasticsearch/data


AWS_PRIVATE_IP=`curl http://169.254.169.254/latest/meta-data/local-ipv4`

echo "*******************************************************************************************************"
echo "MY IP:  $AWS_PRIVATE_IP"
echo "AWS_REGION=$AWS_REGION"
echo "CLUSTER_NAME=$CLUSTER_NAME"
echo "NODE_MASTER=$NODE_MASTER"
echo "NODE_DATA=$NODE_DATA"
echo "HTTP_ENABLE=$HTTP_ENABLE"
echo "AWS_KEY=$AWS_KEY"
echo "AWS_SECRET=$AWS_SECRET"
echo "TAG_VALUE=$TAG_VALUE"
echo "AWS_SECURITY_GROUP=$AWS_SECURITY_GROUP"
echo "*******************************************************************************************************"



# set environment
export CLUSTER_NAME=${CLUSTER_NAME:-elasticsearch-default}
export NODE_MASTER=${NODE_MASTER:-true}
export NODE_DATA=${NODE_DATA:-true}
export HTTP_ENABLE=${HTTP_ENABLE:-true}
export MULTICAST=${MULTICAST:-true}

# AWS stuff
export AWS_SECURITY_GROUP=${AWS_SECURITY_GROUP:-mygroup}
export AWS_REGION=${AWS_REGION:-ap-southeast-2}
export AWS_KEY=${AWS_KEY:-myawskey}
export AWS_SECRET=${AWS_SECRET:-myawssecret}
export TAG_KEY=${TAG_KEY:-somekey}
export TAG_VALUE=${TAG_VALUE:-somevalue}

# allow for memlock
ulimit -l unlimited

# run
#/usr/share/elasticsearch/bin/elasticsearch


sudo -E -u elasticsearch /usr/share/elasticsearch/bin/elasticsearch --network.bind_host=0 --network.publish_host=$AWS_PRIVATE_IP --bootstrap.mlockall=true




