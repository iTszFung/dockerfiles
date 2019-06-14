# Alpine

> Alpine Linux Docker 镜像

![LOGO](./icon.png)

## TL;DR;

## 最基本的 Alpine

基于官方的 Alpine 镜像中构建的最小镜像。可达到基本需求但并不能完全代替掉 [Debian](../debian)

**NOTE:** 需要 Docker 17.01 或更新的版本上运行

## 额外可执行文件

- tini：确保容器单一进程

```bash
tini -- execuable
```

- su-exec：切换用户允许

```bash
su-exec user command [ arguments... ]
```

## Environment Variables

| Parameter     | Description                                               |
| ------------- | --------------------------------------------------------- |
| DEBUG         | DEBUG 模式                                                |
| LANG          | 语言环境,默认为 `en_US`                                   |
| TIMEZONE      | 默认时区，一般有 `Shanghai`、`Beijing`、`HongKong` 为默认 |
| IMAGE_NAME    | 镜像名称                                                  |
| IMAGE_VERSION | 镜像版本                                                  |
| IMAGE_BUILD   | 镜像构建号                                                |
| APP_NAME      | APP 名称                                                  |
| APP_VERSION   | APP 版本                                                  |
| APP_BUILD     | APP 构建号                                                |
| USER_NAME     | 用户名                                                    |
| GROUP_NAME    | 属组名                                                    |
| USER_ID       | 用户 ID，默认 8888                                        |
| GROUP_ID      | 属组 ID，默认 8888                                        |
| USER_HOME     | 用户主目录，建议 `/var/lib/APP`                           |
| LOG_FILE      | 日志文件                                                  |

## 目录说明

- `/usr/local/bin/YOUR_SCRIPT_FILE` 存放自定义代码
- `/usr/share/APP_INSTALL_DIR` 或者 `/opt/APP_INSTALL_DIR` 安装软件目录，一般推荐后者
- `/var/lib/YOUR_DATA_DIR` 数据存放目录
- `/etc/YOUR_APP/YOUR_APP_CONF` 配置文件存放目录

## 获取镜像

从 [仓库](https://github.com/iTszFung/dockerfiles) 中获取

```bash
$ docker pull itszfung/alpine:latest
```

使用指定版本

```bash
$ docker pull itszfung/alpine:[TAG]
```

## 构建镜像

你可以根据自己需要构建不同 arch 或  版本

```bash
$ ./build
```

**NOTE：** 需要在文件中修改自己的版本号

## 保存数据

如果删除容器，则所有数据和配置都将丢失，下次运行映像时，将重新初始化数据库。为了避免数据丢失，应该挂载一个卷，该卷将在容器被移除后仍然存在。

对于持久化，应该在 `/var/lib/APP_NAME` 路径上挂载一个目录。如果挂载的目录为空，则在第一次运行时初始化它

```bash
$ docker run \
    --mount type=bind,source=/var/lib/APP_NAME,target=/APP_NAME \
    itszfung/alpine:latest
```

使用 Docker Compose:

```yaml
version: "3"

services:
  alpine:
    image: "itszfung/alpine:latest"
    volumes:
      - /path/to/store/your/data:/var/lib/APP_NAME
```

## 使用命令行

本案例将创建一个 Docker 实例

### 1. 创建网络

```bash
$ docker network create mynetwork --driver bridge
```

#### 2. 运行实例

使用 `--network mynetwork` 参数连接两个容器之间的网络

```bash
$ docker run -d --name alpine \
    --network mynetwork \
    itszfung/alpine:latest
```

## Docker Compose

如果没有指定网络，Docker 组合将自动设置一个新网络并将所有已部署的服务连接到该网络。然而，我们将明确
定义一个名为 `mynetwork` 的 `bridge` 网络。在本例中，假设希望从自己的自定义应用程序镜像连接到
Alpine 服务器，该映像在下面的代码片段中由服务名 `myapp` 标识。

```yaml
version: "2"

networks:
  mynetwork:
    driver: bridge

services:
  alpine:
    image: "joytech/alpine:latest"
    networks:
      - mynetwork
  myapp:
    image: "YOUR_APPLICATION_IMAGE"
    networks:
      - mynetwork
```

启动容器

```bash
$ docker-compose up -d
```

## 调试

通过 `DEBUG` 环境变量，可打印调试数据

```bash
$ docker run --name alpine -e DEBUG=true itszfung/alpine:latest
```

Docker Compose

```yaml
version: "2"

services:
  alpine:
    image: "itszfung/alpine:latest"
    ports:
      - "6379:6379"
    environment:
      - DEBUG=true
```

**Warning：** Debug 模式推荐仅开发时使用

## 日志

镜像发送容器日志  信息到 `stdout`. 观察 Log 使用

```bash
$ docker logs alpine
```

Docker Compose

```bash
$ docker-compose logs alpine
```

如果希望以不同的方式使用容器日志，配置容器的 [logging driver](https://docs.docker.com/engine/admin/logging/overview/) 使用 `--log-driver` 选项，在默认配置中，docker 使用 `json-file` 驱动程序

## 维护

### 更新此镜像

最新版本的 Alpine，包括安全补丁，这些补丁在升级后很快就会更新。建议按照以下步骤升级容器。

#### 1. 更新镜像

```bash
$ docker pull itszfung/alpine:latest
```

或使用 Docker Compose, 更新镜像版本属性 `itszfung/alpine:latest`

#### 2. 停止并备份当前镜像

停止

```bash
$ docker stop alpine
```

Docker Compose

```bash
$ docker-compose stop alpine
```

接着使用快照存储数据卷

```bash
$ rsync -a /path/to/your/data /path/to/your/data.bkp.$(date +%Y%m%d-%H.%M.%S)
```

#### 3. 移除当前运行的容器

```bash
$ docker rm -v alpine
```

Docker Compose

```bash
$ docker-compose rm -v alpine
```

#### 4. 运行新镜像

重新创建容器新镜像

```bash
$ docker run --name alpine itszfung/alpine:latest
```

Docker Compose

```bash
$ docker-compose start alpine
```

## 版权

[LICENSE](./LICENSE)
