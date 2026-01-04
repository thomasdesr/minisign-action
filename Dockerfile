FROM jedisct1/minisign@sha256:ee60186c5d05e342e66cbc81133aa744d026752d909d8ea021a15c4d16b1193b as minisign

FROM alpine:latest
COPY --from=minisign /usr/local/bin/minisign /minisign
ADD entrypoint.sh /
ENTRYPOINT ["/entrypoint.sh"]
