from sajid2045/elasticsearch:2.2
MAINTAINER sajid2045@gmail.com

RUN apt-get -y update

RUN apt-get install -y vim
RUN apt-get install -y sudo
RUN apt-get install -y telnet 

# Override elasticsearch.yml config, otherwise plug-in install will fail
ADD do_not_use.yml /usr/share/elasticsearch/config/elasticsearch.yml

# Install Elasticsearch plug-ins
RUN /usr/share/elasticsearch/bin/plugin install mobz/elasticsearch-head
RUN /usr/share/elasticsearch/bin/plugin install cloud-aws
RUN /usr/share/elasticsearch/bin/plugin install royrusso/elasticsearch-HQ
RUN /usr/share/elasticsearch/bin/plugin install lmenezes/elasticsearch-kopf


# Now put the original installation in.
ADD elasticsearch.yml /usr/share/elasticsearch/config/elasticsearch.yml
ADD logging.yml /usr/share/elasticsearch/config/logging.yml

# Copy run script
COPY run.sh /

CMD ["/run.sh"]


# allow for memlock
#ulimit -l unlimited

# run
