FROM ubuntu:18.04

RUN apt-get update && apt-get install -y --no-install-recommends \
        git \
        make \
        gcc \
        g++ \
        libssl-dev \
        ca-certificates \
        ssl-cert && \
        mkdir /supla-mqtt-client && cd /supla-mqtt-client && \
        git clone https://github.com/SUPLA/supla-core.git && \
        cd supla-core && \
        git checkout mqtt-experimental && \
        cd supla-mqtt-client/Release && \
        make clean && \
        make all && \
        cd /supla-mqtt-client && \
        cp supla-core/supla-mqtt-client/Release/supla-mqtt-client . && \
        cp -r supla-core/supla-mqtt-client/config . && \
        mv config config-supla && \
        apt-get remove -y git make gcc g++ libssl-dev && \
        apt-get autoremove -y && \
        rm -rf /supla-mqtt-client/supla-core && \
        rm -rf /var/lib/apt/lists

ADD run.sh /supla-mqtt-client/

WORKDIR /supla-mqtt-client

CMD [ "./run.sh" ]

