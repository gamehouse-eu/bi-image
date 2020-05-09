FROM ubuntu:20.04

COPY build-image.sh /tmp/
RUN /tmp/build-image.sh && rm -f /tmp/build-image.sh
