ARG KEYCLOAK_VERSION=26.8.1

FROM quay.io/keycloak/keycloak:${KEYCLOAK_VERSION} AS builder

ENV KC_DB=mysql \
    KC_HEALTH_ENABLED=true \
    KC_METRICS_ENABLED=true

COPY --chown=1000:0 providers/ /opt/keycloak/providers/
COPY --chown=1000:0 themes/ /opt/keycloak/themes/

RUN /opt/keycloak/bin/kc.sh build

FROM quay.io/keycloak/keycloak:${KEYCLOAK_VERSION}

ENV KC_DB=mysql \
    KC_HEALTH_ENABLED=true \
    KC_METRICS_ENABLED=true

COPY --from=builder --chown=1000:0 /opt/keycloak/ /opt/keycloak/

ENTRYPOINT ["/opt/keycloak/bin/kc.sh"]
CMD ["start", "--optimized"]

