FROM alpine:3.9

LABEL maintainer="TszFung Lam <itszfung@icloud.com>" \
  docker.itszfung.desc="Alpine Basic Layer" \
  docker.itszfung.type="infrastructure"

ENV DEBUG="" \
  LANG=en_US.UTF-8 \
  TIMEZONE="Hongkong" \
  IMAGE_NAME=alpine \
  IMAGE_VERSION=3.9 \
  IMAGE_BUILD=1.0

ENV MIRROR="https://mirrors.aliyun.com/alpine/v${IMAGE_VERSION}"

RUN echo -e "${MIRROR}/main\n${MIRROR}/community" > /etc/apk/repositories && \
  apk add --no-cache bash tini su-exec tzdata xz && \
  cp "/usr/share/zoneinfo/$TIMEZONE" "/etc/localtime"

COPY rootfs /

ENTRYPOINT ["tini", "--", "entrypoint"]
CMD ["bash"]
