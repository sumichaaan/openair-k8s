FROM alpine:3.11.5

# Label
LABEL \
    org.label-schema.maintainer="Yoshifumi Sumida" \
    org.label-schema.name="unbound" \
    org.label-schema.description="Docker version of Unbound based on Alpine Linux" \
    org.label-schema.version="1.0" \
    org.label-schema.vcs-url="https://github.com/sumichaaan/openair-k8s-ubuntu" \
    org.label-schema.schema-version="1.0"

# Image specific layers under this line
RUN apk add --no-cache \
        unbound \
        openssl \
        curl \
        bind-tools \
        tzdata && \
    rm -rf /tmp/* /var/tmp/* /var/cache/apk/*

# Create configuration directories
ENV ROOT_HINT_FILE https://www.internic.net/domain/named.cache
RUN install -o unbound -g unbound -m 775 -d \
        /etc/unbound \
        /etc/unbound/conf.d \
    curl -o /etc/unbound/root.hints ${ROOT_HINT_FILE} && \
    /usr/sbin/unbound-anchor -a /etc/unbound/trusted-key.key | true && \
    apk del --no-cache curl

# Port exposed to
EXPOSE 53/udp 53/tcp

ENTRYPOINT ["/usr/sbin/unbound", "-d", "-c", "/etc/unbound/unbound.conf"]
