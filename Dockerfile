FROM ubuntu:18.04 AS build

# We're pulling a specific tag/commit because minisign hasn't been released in a
# long time and we want to build a static artifact.
ENV TAG="dfb9963ce764b4b0d104ca52884c454cb332ef62"

# Setup Deps
RUN apt-get update && \
    apt-get install -y \
        cmake \
        libsodium-dev \
        pkg-config

# Download
ADD https://github.com/jedisct1/minisign/archive/$TAG.tar.gz /minisign.tgz

# Extract
RUN tar -xzf /minisign.tgz

# Build
WORKDIR "/minisign-$TAG/build"
RUN cmake -D BUILD_STATIC_EXECUTABLES=1 ..
RUN make install

# Copy over built artifact into empty container
FROM scratch

COPY --from=build /usr/local/bin/minisign /minisign

ENTRYPOINT ["/minisign"]