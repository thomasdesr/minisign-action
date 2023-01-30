FROM jedisct1/minisign@sha256:1326ddb799bdd117b802d19498ccfedf3987104f646a987e6d7f7652dc8ca201 as minisign

FROM alpine:latest
COPY --from=minisign /usr/local/bin/minisign /minisign
ADD entrypoint.sh /
ENTRYPOINT ["/entrypoint.sh"]
