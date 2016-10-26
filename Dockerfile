FROM mcristinagrosu/bigstepinc_java_8

RUN apk update 
RUN apk add --no-cache openssh wget tar bash curl unzip alpine-sdk

# Apache Kafka
RUN cd /opt && \
    wget http://apache.mirror.anlx.net/kafka/0.10.1.0/kafka_2.11-0.10.1.0.tgz 
    
RUN cd /opt && \
    tar xzvf kafka_2.11-0.10.1.0.tgz 
    
ENV KAFKA_HOME /opt/kafka_2.11-0.10.1.0 

RUN rm -rf $KAFKA_HOME/kafka_2.11-0.10.1.0.tgz && \
    rm -rf /opt/jdk1.8.0_92 

ADD script.sh /opt/
RUN bash /opt/script.sh
RUN rm /opt/script.sh

ADD entrypoint.sh /opt/entrypoint.sh
RUN chmod 777 /opt/entrypoint.sh

RUN apk del wget tar curl unzip

EXPOSE 2181

ENTRYPOINT ["/opt/entrypoint.sh"]
