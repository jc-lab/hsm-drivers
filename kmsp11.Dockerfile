FROM alpine:3.20 as builder

RUN apk add \
	ca-certificates wget


ARG DEST_DIR=/opt/pkcs11/kmsp/
RUN wget -O libkmsp11.tar.gz https://github.com/GoogleCloudPlatform/kms-integrations/releases/download/pkcs11-v1.6/libkmsp11-1.6-linux-amd64.tar.gz && \
    echo "af19692e442750b2e1315cb3fce3eddc5e8e4fa00b4d59b8fb16839658b8c1b8  libkmsp11.tar.gz" | sha256sum -c - && \
    mkdir -p ${DEST_DIR} && \
    tar -xf libkmsp11.tar.gz -C ${DEST_DIR} --strip-components=1

COPY copy.sh /

RUN chmod +x /copy.sh

ENV INSTALL_DIR=/opt/pkcs11
CMD /copy.sh

