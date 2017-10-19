FROM frolvlad/alpine-glibc:alpine-3.6

RUN apk update && apk upgrade && \
    apk add --no-cache bash git openssh

ENV OPENSHIFT_VERSION v1.3.0
ENV OPENSHIFT_HASH 3ab7af3d097b57f933eccef684a714f2368804e7

RUN apk add --no-cache --virtual .build-deps \
        curl \
        tar \
    && curl --retry 7 -Lso /tmp/client-tools.tar.gz "https://github.com/openshift/origin/releases/download/${OPENSHIFT_VERSION}/openshift-origin-client-tools-${OPENSHIFT_VERSION}-${OPENSHIFT_HASH}-linux-64bit.tar.gz" \
    && tar zxf /tmp/client-tools.tar.gz --strip-components=1 -C /usr/local/bin \
    && rm /tmp/client-tools.tar.gz \
    && apk del .build-deps

COPY env.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/env.sh

ENTRYPOINT ["env.sh"]
CMD ["sh"]