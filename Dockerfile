FROM alpine:latest

ENV ALPINE_VERSION=3.8
ENV ALPINE_MIRROR=http://nl.alpinelinux.org/alpine

RUN set -xe \
	&& echo ${ALPINE_MIRROR}/v${ALPINE_VERSION}/main > /etc/apk/repositories \
    && echo ${ALPINE_MIRROR}/v${ALPINE_VERSION}/community >> /etc/apk/repositories \
    && apk add --no-cache clamav wget clamav-libunrar

COPY conf /etc/clamav

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

RUN mkdir /data
RUN mkdir /run/clamav

EXPOSE 3310/tcp

ENTRYPOINT ["/entrypoint.sh"]
CMD ["clamd"]