# docker-elasticsearch-aws

Ready to use lean Elasticsearch Docker image ready for using within Elastic Continer Service (ECS)


* Ubuntu 14.04
* Oracle JDK 8
* Elasticsearch 2.2.0
* [AWS plug-in](https://www.elastic.co/guide/en/elasticsearch/plugins/current/cloud-aws.html)

## Pre-requisites

* EC2 credentials for reading EC2 tags
* EC2 tag key and tag value for identifying machines used in the cluster

## Run


Ready to use node for cluster `myclustername`:
```
docker run --name elasticsearch \
	--detach \
	--privileged \
	--volume /path/to/data_folder:/data \
	-p 9200:9200 \
	-p 9300:9300 \
	-e ES_HEAP_SIZE=4g \
	-e CLUSTER_NAME=myclustername \
	-e AWS_KEY=xxxxxxxxxxxx \
	-e AWS_SECRET=xxxxxxxxxxxx \
	-e TAG_KEY=xxxxxxxxxxxx \
	-e TAG_VALUE=xxxxxxxxxxxx \
	-e AWS_REGION=xxxxx \ //ap-southeast-2
        -e AWS_SECURITY_GROUP=xxxxx \ //sg-xxxx 
	sajid2045/elasticsearch-ecs
```

