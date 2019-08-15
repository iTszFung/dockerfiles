FROM alpine:latest

LABEL maintainer="TszFung Lam <itszfung@nordons.com>" \
  docker.itszfung.desc="Jira Project Management" \
  docker.itszfung.type="Project Management And Bug Trace"

ARG APP_NAME=jira-software
ARG APP_VERSION=7.8.0
ARG GLIBC_VERSION=2.27-r0
ARG DOCKERIZE_VERSION=v0.6.0

ENV APP_NAME=${APP_NAME} \
  APP_VERSION=${APP_VERSION} \
  USER_ID=1000 \
  GROUP_ID=1000 \
  USER_NAME=jira \
  GROUP_NAME=jira \
  # JIRA_HOME 是数据存储目录，并非安装目录
  APP_HOME=/var/atlassian/jira \
  APP_CONTEXT_PATH=ROOT \
  APP_INSTALL_DIR=/opt/jira \
  APP_SCRIPTS_DIR=/usr/local/share/atlassian \
  APP_PACKAGE_NAME=atlassian-jira-software-${APP_VERSION}-x64.bin \
  APP_PACKAGE_URL=https://www.atlassian.com/software/jira/downloads/binary/atlassian-jira-software-${APP_VERSION}-x64.bin \
  DOCKERIZE_VERSION=${DOCKERIZE_VERSION} \
  DOCKERIZE_DOWNLOAD_URL=https://github.com/jwilder/dockerize/releases/download/${DOCKERIZE_VERSION}/dockerize-alpine-linux-amd64-${DOCKERIZE_VERSION}.tar.gz \
  APP_DEPS_LIB_VERSION=${GLIBC_VERSION:-2.27-r0} \
  APP_DEPS_LIB_REPO_URI=https://github.com/sgerrand/alpine-pkg-glibc/releases/download/${GLIBC_VERSION}/glibc

# COPY script ${APP_SCRIPTS_DIR}
COPY response.varfile /

RUN set -eux; \
  addgroup -g $GROUP_ID ${GROUP_NAME} && \
  adduser -u ${USER_ID} -G ${GROUP_ID} -D -h ${APP_HOME} -s /sbin/nologin -S ${USER_NAME} && \
  apk add --allow-untrusted ${APP_DEPS_LIB_REPO_URI}-${APP_DEPS_LIB_VERSION}.apk && \
  apk add --allow-untrusted ${APP_DEPS_LIB_REPO_URI}-bin-${APP_DEPS_LIB_VERSION}.apk && \
  apk add --allow-untrusted ${APP_DEPS_LIB_REPO_URI}-i18n-${APP_DEPS_LIB_VERSION}.apk && \
  apk add --no-cache \
  gzip \
  su-exec \
  tini \
  xmlstarlet && \
  wget -qO- ${DOCKERIZE_DOWNLOAD_URL} | tar xz -C /usr/local/bin && \
  mkdir -p ${APP_INSTALL_DIR} && \
  chmod -R 775 ${APP_INSTALL_DIR} && \
  chown -R ${USER_NAME}:${GROUP_NAME} ${APP_INSTALL_DIR} && \
  wget -O /jira.bin -q ${APP_PACKAGE_URL} && \
  chmod +x /jira.bin && \
  su-exec ${USER_NAME} /jira.bin -q -varfile /response.varfile && \
  apk del gzip && \
  chmod -R 775 /usr/local/bin/dockerize ${APP_INSTALL_DIR} && \
  chown -R ${USER_NAME}:${GROUP_NAME} /usr/local/bin/dockerize ${APP_INSTALL_DIR} && \
  rm -rf /var/cache/apk/* /tmp/* /var/log/*

USER jira
COPY rootfs /
# COPY cracker/atlassian-extras-3.2.jar /opt/jira/atlassian-jira/WEB-INF/lib/
EXPOSE 8080
EXPOSE 8005
WORKDIR ${APP_HOME}
VOLUME ["${APP_HOME}"]
ENTRYPOINT ["tini","--","app-entrypoint"]
CMD ["jira"]
