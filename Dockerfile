FROM jedisct1/minisign as minisign

FROM alpine:latest
COPY --from=minisign /usr/local/bin/minisign /minisign
ADD entrypoint.sh /
ENTRYPOINT ["/entrypoint.sh"]
