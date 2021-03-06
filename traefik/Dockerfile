ARG BUILD_FROM

FROM $BUILD_FROM

ARG BUILD_ARCH
ARG TRAEFIK_VERSION

COPY run.sh /

RUN apk add --no-cache python3 py3-pip nginx && \
    pip3 install "j2cli[yaml]" && \
    if [ "$BUILD_ARCH" == "aarch64" ];then TRAEFIK_BUILD_ARCH=arm64;else TRAEFIK_BUILD_ARCH=$BUILD_ARCH;fi && \
    wget --quiet -O /tmp/traefik.tar.gz "https://github.com/containous/traefik/releases/download/v${TRAEFIK_VERSION}/traefik_v${TRAEFIK_VERSION}_linux_${TRAEFIK_BUILD_ARCH}.tar.gz" && \
    tar xzvf /tmp/traefik.tar.gz -C /usr/local/bin traefik && \
    chmod a+x /usr/local/bin/traefik && \
    chmod a+x /run.sh && \
    rm -f /tmp/traefik.tar.gz

COPY traefik.yaml.j2 env.j2 /etc/traefik/
COPY nginx.conf /etc/nginx/conf.d/default.conf

CMD [ "/run.sh" ]

LABEL \
    io.hass.name="Treafik for ${BUILD_ARCH}" \
    io.hass.description="Home Assistant Unofficial Add-on: ${BUILD_ARCH} Treafik image" \
    maintainer="Alex van den Hoogen <homeassistant@alxx.nl>" \
    org.opencontainers.image.title="Traefik for ${BUILD_ARCH}" \
    org.opencontainers.image.description="Home Assistant Unofficial Add-on: ${BUILD_ARCH} Traefik image" \
    org.opencontainers.image.vendor="Alex van den Hoogen" \
    org.opencontainers.image.authors="Alex van den Hoogen <homeassistant@alxx.nl>" \
    org.opencontainers.image.url="https://alxx.nl/hassio-addons/" \
    org.opencontainers.image.source="https://alxx.nl/hassio-addons/" \
    org.opencontainers.image.documentation="https://alxx.nl/hassio-addons/blob/master/traefik/README.md" \
    org.opencontainers.image.created=${BUILD_DATE} \
    org.opencontainers.image.revision=${BUILD_REF} \
    org.opencontainers.image.version=${BUILD_VERSION}
