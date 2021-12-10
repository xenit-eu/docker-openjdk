# Java Docker Images

OpenJDK Docker Images built and maintained by XeniT

* Using [Eclipse Temurin](https://adoptium.net/) for Java 8 and later.
* Using Oracle OpenJDK from the Ubuntu or CentOS distributions for legacy JDK 7.


## Supported Tags

* `jdk-11-ubuntu-18.04`, `jdk-11-bionic`, `jdk-11`
* `jdk-8-ubuntu-18.04`, `jdk-8-bionic`, `jdk-8-ubuntu`, `jdk-8`
* `jdk-7-ubuntu-14.04`, `jdk-7-trusty`

### Alfresco Compatible Tags

* JDK 11: `alfresco-6.0-ubuntu`, `alfresco-6.1-ubuntu`, `alfresco-6.2-ubuntu`
* JDK 8: `alfresco-5.0-ubuntu`, `alfresco-5.1-ubuntu`, `alfresco-5.2-ubuntu`
* JDK 7: `alfresco-4.2-ubuntu`, `jdk-7u211-ubuntu-14.04`, `jdk-7-ubuntu-14.04`


Additional tags are provided:
* images are also tagged with the exact JDK version (for example `jdk-8u312-bionic`), but these tags will not receive future updates.
* tags containing a `-SNAPSHOT` postfix are development artifacts (automated builds from the master branch).
* tags without any postfix are release artifacts


## Environment variables

There are several environment variables available to tweak the behaviour. While none of the variables are required, 
they may significantly aid you in using these images.
The variables are read by an init script which further appends to JAVA_OPTS.

Environment variables:

| Variable                         |  Default  | Java variable |
| -------------------------------- | --------- | ------------- |
| JAVA_XMS                         |           | -Xmx          |
| JAVA_XMX                         |           | -Xms          |
| DEBUG                            | false     | -Xdebug -Xrunjdwp:transport=dt_socket,address=8000,server=y,suspend=n |
| JMX_ENABLED                      | false     | -Dcom.sun.management.jmxremote.authenticate=false -Dcom.sun.management.jmxremote.local.only=false -Dcom.sun.management.jmxremote.ssl=false -Dcom.sun.management.jmxremote -Dcom.sun.management.jmxremote.rmi.port=5000 -Dcom.sun.management.jmxremote.port=5000 -Djava.rmi.server.hostname=$JMX_RMI_HOST |
| JMX_RMI_HOST                     | 0.0.0.0   |               |
| JAVA_OPTS_\<variable\>=\<value\> | \<value\> | \<variable\>  |                                                             |  |


## Quick reference

**Where to get help:**

Channel [#xeniteu/docker](https://gitter.im/xeniteu/docker) on Gitter


**Maintained by:**

XeniT <docker@xenit.eu>

**Supported Architectures:**

* linux-x64

**Supported Docker versions:**

* down to 1.10 (on a best-effort basis)


## Environment Variables

The `docker.io/xenit/openjdk` image supports the following environment variables:

### JAVA_OPTS_xxx

This image iterates over all environment variables that start with `JAVA_OPTS_` and collects them into the environment 
variable `JAVA_OPTS` when the container is started. This `JAVA_OPTS` variable can be used to pass JVM arguments to 
the _java_ process.

The environment variable should have the format `JAVA_OPTS_xxx="-Dkey=value"`, where the key `xxx` is ignored.

_Note:_ This ignored key can be useful, when you want to override a particular JVM argument when using multiple 
_docker-compose.yml_ files or _docker-compose.override.yml_. See the 
[Docker Compose documentation](https://docs.docker.com/compose/extends/#example-use-case) for more information.

## Image variants

The `openjdk` images come in a few flavors, where the variants use the following tag-structure:

```
openjdk:<type>-<version>-<os>
```

There are permutations possible of three parameters in this project.

* **Type**: the Java distribution type, one of `jdk`, `jre` or `server-jre`. At the moment only `jdk` is supported.
* **Version**: the Java version, for example `8u312`
* **OS**: the Operating system, for example `ubuntu-18.04`, with optionally some additional variants

Please file an issue if you need a different combination of parameters.

### Java versions

In general, the latest update of the LTS-releases are maintained.

**NOTE**: the Java _update_ (=minor version) is **NOT** maintained. For example: the current Ubuntu JDK 8 image is 
tagged with `jdk-8-ubuntu-18.04` and has the additional tag `jdk-8u312-ubuntu-18.04` to indicate the Java 8 _update_ version. 
Once the next update is published, the image tagged `jdk-8-ubuntu-18.04` will be updated, but `jdk-8u312-ubuntu-18.04` 
will no longer be supported and will not receive OS or Java security patches.

Images are used as base images for Alfresco services.

When the OS reached end-of-life (Alfresco 4 - using Ubuntu 10.04, 12.04), next available LTS version is used. 
When multiple major Java versions are supported, the higher version is used.
Java update is always the latest one available.
 
At the moment, following versions are built:

| Alfresco      | OpenJDk            | Ubuntu                             |
| ------------- | ------------------ | ---------------------------------- |
| [Alfresco 6.2]  | JDK 11u13         | 18.04 - `jdk-11-ubuntu-18.04`  |
| [Alfresco 6.1]  | JDK 11u13         | 18.04 - `jdk-11-ubuntu-18.04`  |
| [Alfresco 6.0]  | JDK 11u13         | 18.04 - `jdk-11-ubuntu-18.04`  |
| [Alfresco 5.2]  | JDK 8u312          | 18.04 - `jdk-8-ubuntu-18.04`   |
| Alfresco 5.1  | JDK 8u312          | 18.04 - `jdk-8-ubuntu-18.04`   |
| Alfresco 5.0  | JDK 8u312          | 18.04 - `jdk-8-ubuntu-18.04`   |
| Alfresco 4.2  | JDK 7u211 (Oracle) | 14.04 - `jdk-7-ubuntu-14.04`   |

[Alfresco 6.2]: https://docs.alfresco.com/content-services/6.2/support/
[Alfresco 6.1]: https://docs.alfresco.com/content-services/6.1/support/
[Alfresco 6.0]: https://docs.alfresco.com/content-services/6.0/support/
[Alfresco 5.2]: https://docs.alfresco.com/content-services/5.2/support/


### Operating Systems

*  Ubuntu 18.04 LTS - `ubuntu:bionic`
*  Ubuntu 16.04 LTS - `ubuntu:xenial`
*  Ubuntu 14.04 LTS - `ubuntu:trusty`

## Initialization

This image uses Docker `ENTRYPOINT` to provide initialization hooks.

If you would like to do additional initialization in an image derived from this one, add one or more `*.sh` scripts 
under `/docker-entrypoint.d/`. The scripts are _source_'d and do not need to be executable. This means these scripts 
run within the existing shell, any variables created or modified by the script will remain available after the script 
completes. These initialization scripts will be executed in sorted name order as defined by the current locale.

After initialization completes, the main `CMD` will be _exec_'ed, to avoid starting the main process in a subshell.

You can override or disable the initialization scripts by overriding the `ENTRYPOINT` instruction using the 
`docker run --entrypoint` flag.

## Contributions

### How to build

Builds are produced by [GitHub Actions](https://docs.github.com/en/free-pro-team@latest/actions) driving Gradle from a
GitHub workflow file.

To build a local version of the java image:

```
./gradlew buildDockerImage
```

## FAQ

### How do I access the Java debug port?

Set the environment variable `DEBUG=true`. The debug port is `8000`.

### How do I enable JMX?

Set the environment variable `JMX_ENABLED=true`. The JMX port is `5000`.
