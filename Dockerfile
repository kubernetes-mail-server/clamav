FROM alpine:latest

RUN apk add --no-cache clamav wget clamav-libunrar

COPY conf /etc/clamav

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

RUN mkdir /data
RUN mkdir /run/clamav

EXPOSE 3310/tcp

ENTRYPOINT ["/entrypoint.sh"]
CMD ["clamd"]