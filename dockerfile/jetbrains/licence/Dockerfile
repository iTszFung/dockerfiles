FROM joytech/alpine:latest
LABEL maintainer='TszFung Lam <itszfung@itszfung.com>' \
docker.itszfung.description='Jetbrains Licence Server Base On Alpine' \
docker.itszfung.container.type='Jetbrains Server Licence'

ENV JOYTECH_APP_NAME="Jetbrains-Licence" \
    JOYTECH_APP_USER="itszfung"

COPY rootfs /
EXPOSE 1208
ENTRYPOINT [ "app-entrypoint" ]
CMD [ "init" ]
