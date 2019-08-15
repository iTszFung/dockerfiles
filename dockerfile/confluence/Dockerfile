FROM joytech/openjdk:latest

LABEL maintainer="TszFung Lam <itszfung@itszfung.com>" \
      docker.itszfung.desc="Jira Confluence" \
      docker.itszfung.type="Enterprise WiKi"

ARG APP_VERSION=6.3.3
ARG APP_NAME=confluence

ENV JOYTECH_APP_NAME=${APP_NAME} \
    JOYTECH_APP_VERSION=$APP_VERSION \
    JOYTECH_USER=${APP_NAME} \
    JOYTECH_GROUP=${APP_NAME} \
    JOYTECH_UID=1008 \
    JOYTECH_GID=1008 \
    JOYTECH_HOME=/var/atlassian/application-data/confluence \
    JOYTECH_APP_INSTALL_DIR=/opt/atlassian/confluence \
    JOYTECH_APP_JVM_SUPPORT_ARGS= \
    JOYTECH_APP_PACKAGE_DOWNLOAD_URL=http://www.atlassian.com/software/confluence/downloads/binary/atlassian-confluence-${APP_VERSION}.tar.gz

ENV CONFLUENCE_HOME=${JOYTECH_HOME}

RUN set -ex; \
    userinit && \
    addpkg openssh \
    procps \
    openssl \
    perl \
    ttf-dejavu \
    libc6-compat && \
    mkdir -p ${JOYTECH_APP_INSTALL_DIR} && \
    wget -qO- ${JOYTECH_APP_PACKAGE_DOWNLOAD_URL} | tar -xz --strip-components=1 -C ${JOYTECH_APP_INSTALL_DIR} && \
    chown -R ${JOYTECH_USER}:${JOYTECH_GROUP} ${JOYTECH_APP_INSTALL_DIR} && \
    rm -rf /var/lib/{apt,dpkg,cache,log}/ /tmp/* /var/tmp/* && \
    sed -i -e 's/-Xms\([0-9]\+[kmg]\) -Xmx\([0-9]\+[kmg]\)/-Xms\${JOYTECH_APP_JVM_MIN_MEMORY:=\1} -Xmx\${JOYTECH_APP_JVM_MAX_MEMORY:=\2} \${JOYTECH_APP_JVM_SUPPORT_ARGS} -Dconfluence.home=\${CONFLUENCE_HOME}/g' ${JOYTECH_APP_INSTALL_DIR}/bin/setenv.sh && \
    sed -i -e 's/port="8090"/port="8090" secure="${catalinaConnectorSecure}" scheme="${catalinaConnectorScheme}" proxyName="${catalinaConnectorProxyName}" proxyPort="${catalinaConnectorProxyPort}"/' ${JOYTECH_APP_INSTALL_DIR}/conf/server.xml


COPY rootfs /
WORKDIR $JOYTECH_HOME
EXPOSE 8090
EXPOSE 8091
VOLUME ["${JOYTECH_HOME}", "${JOYTECH_APP_INSTALL_DIR}"]
ENTRYPOINT ["tini", "--", "app-entrypoint"]
CMD ["-fg"]

# docker run --name jira-confluence -itd --restart=always \
#  --network=jcnet \
#  -p "10180:8090" \
#  -v "confluence:/var/atlassian/application/confluence:Z" \
#  joytech/jira-confluence:latest