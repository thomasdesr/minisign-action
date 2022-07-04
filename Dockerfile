FROM jedisct1/minisign@sha256:fab787053d0c6f600eb86344add051927caa729f1f73ebaba4aa42e0e7402609 as minisign

FROM alpine:latest
COPY --from=minisign /usr/local/bin/minisign /minisign
ADD entrypoint.sh /
ENTRYPOINT ["/entrypoint.sh"]
