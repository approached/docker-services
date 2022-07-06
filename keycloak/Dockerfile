FROM quay.io/keycloak/keycloak:18.0.2 as builder

# build
ARG KC_DB=postgres
ARG KC_HEALTH_ENABLED=false
ARG KC_METRICS_ENABLED=false
ARG KC_FEATURES=token-exchange

ENV KC_DB=$KC_DB
ENV KC_HEALTH_ENABLED=$KC_HEALTH_ENABLED
ENV KC_METRICS_ENABLED=$KC_METRICS_ENABLED
ENV KC_FEATURES=$KC_FEATURES

RUN /opt/keycloak/bin/kc.sh build

# start
FROM quay.io/keycloak/keycloak:18.0.2
COPY --from=builder /opt/keycloak/ /opt/keycloak/
WORKDIR /opt/keycloak
ENTRYPOINT ["/opt/keycloak/bin/kc.sh"]
