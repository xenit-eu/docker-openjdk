# Java Docker Images

This repository contains Xenit's distribution's Openjdk Java images for java <=7 and the Adoptopenjdk images (https://adoptopenjdk.net/) for java >=8.


## Supported tags

* `alfresco-6.0-centos`, `alfresco-6.1-centos`, `jdk-11u3-centos-7`, `jdk-11-centos-7`, `jdk-11u3-centos`, `jdk-11-centos`
* `alfresco-6.0-ubuntu`, `alfresco-6.1-ubuntu`, `jdk-11u3-ubuntu-18.04`, `jdk-11-ubuntu-18.04`
* `jdk-6u41-centos-6`, `jdk-6-centos-6`
* `alfresco-4.0-ubuntu`, `alfresco-4.1-ubuntu`, `jdk-6u41-ubuntu-14.04`, `jdk-6-ubuntu-14.04`
* `jdk-7u221-centos-7`, `jdk-7-centos-7`, `jdk-7u221-centos`, `jdk-7-centos`
* `alfresco-4.2-ubuntu`, `jdk-7u211-ubuntu-14.04`, `jdk-7-ubuntu-14.04`
* `alfresco-5.1-centos`, `alfresco-5.2-centos`, `jdk-8u212-centos-7`, `jdk-8-centos-7`, `jdk-8u212-centos`, `jdk-8-centos`
* `alfresco-5.0-ubuntu`, `jdk-8u212-ubuntu-14.04`, `jdk-8-ubuntu-14.04`
* `alfresco-5.1-ubuntu`, `alfresco-5.2-ubuntu`, `jdk-8u212-ubuntu-16.04`, `jdk-8-ubuntu-16.04`, `jdk-8u212-ubuntu`, `jdk-8-ubuntu`, `jdk-8u212`, `jdk-8`
* `jdk-8u212-ubuntu-18.04`, `jdk-8-ubuntu-18.04`


## Quick reference

**Where to get help:**

Channel [#docker](https://xenitengineering.slack.com/app_redirect?channel=docker) on Slack

**Where to file [issues](https://xenitsupport.jira.com/issues/?jql=project%20%3D%20DOCKER%20AND%20component%20%3D%20Java):**

In _JIRA_, Project `DOCKER`, select Component `Java`.

**TO DO: change to github once moved there**

**Maintained by:**

Toon Geens <toon.geens@xenit.eu>, Roxana Angheluta <roxana.angheluta@xenit.eu>

**Supported Architectures:**

* linux-x64

**Supported Docker versions:**

* down to 1.10 (on a best-effort basis)


## Environment Variables

The `xeniteu/openjdk` image supports the following environment variables:

### JAVA_OPTS_xxx

This image iterates over all environment variables that start with `JAVA_OPTS_` and collects them into the environment variable `JAVA_OPTS` when the container is started. This `JAVA_OPTS` variable can be used to pass JVM arguments to the _java_ process.

The environment variable should have the format `JAVA_OPTS_xxx="-Dkey=value"`, where the key `xxx` is ignored.

_Note:_ This ignored key can be useful, when you want to override a particular JVM argument when using multiple _docker-compose.yml_ files or _docker-compose.override.yml_. See the [Docker Compose documentation](https://docs.docker.com/compose/extends/#example-use-case) for more information.

## Image variants

The `openjdk` images come in a few flavors, where the variants use the following tag-structure:

```
openjdk:<type>-<version>-<os>
```

There are permutations possible of three parameters in this project.

* **Type**: the Java distribution type, one of `jdk`, `jre` or `server-jre`. At the moment only `jdk` is implemented.
* **Version**: the Java version, for example `8u212`
* **OS**: the Operating system, for example `ubuntu-16.04`, with optionally some additional variants

Please file an issue if you need a different combination of parameters.

### Java versions

In general, the latest update of the LTS-releases of the different distributions are maintained, both for `-ubuntu` and `-centos`,
based on the latest LTS release, of that distribution.

* jdk-6:
    - `jdk-6-ubuntu`
    - `jdk-6-centos`
* jdk-7
    - `jdk-7-ubuntu`
    - `jdk-7-centos`
* jdk-8:
    - `jdk-8-ubuntu`
    - `jdk-8-centos`
* jdk-11
    - `jdk-11-ubuntu`
    - `jdk-11-centos`

**NOTE**: the Java _update_ (=minor version) is **NOT** maintained. For example: the current Ubuntu JDK 8 image is tagged with `jdk-8-ubuntu-16.04` and has the additional tag `jdk-8u212-ubuntu-16.04` to indicate the Java 8 _update_ version. 
Once the next update is published, the image tagged `jdk-8-ubuntu-16.04` will be updated, but `jdk-8u212-ubuntu-16.04` will no longer be supported and will not receive OS or Java security patches.

Images are used as base images for building Alfresco. Supported stack for Alfresco is documented at (replace capital X's with the desired version):

* https://www.alfresco.com/sites/www.alfresco.com/files//supported_platforms_for_alfresco_enterprise_X.X.x.pdf for Alfresco <5.2
* https://docs.alfresco.com/X.X/concepts/supported-platforms-ACS.html for Alfresco >=5.2

When the OS reached end-of-life (Alfresco 4 - using Ubuntu 10.04, 12.04), next available LTS version is used. 
When multiple major Java versions are supported, the higher version is used.
Java update is always the latest one available.
 
At the moment, following versions are built:

| Alfresco      | Oracle Openjdk  | Adopt Openjdk      | Ubuntu                             | CentOS                           |
| ------------- | --------------  | ------------------ | ---------------------------------- | -------------------------------- |
| Alfresco 6.1  |                 |  JDK 11u3          | 18.04 - `jdk-11u3-ubuntu-18.04`    | 7 - `jdk-11u3-centos-7`          |
| Alfresco 6.0  |                 |  JDK 11u3          | 18.04 - `jdk-11u3-ubuntu-18.04`    | 7 - `jdk-11u3-centos-7`          | 
| Alfresco 5.2  |                 |  JDK 8u212         | 16.04 - `jdk-8u212-ubuntu-16.04`   | 7 - `jdk-8u212-centos-7`         |
| Alfresco 5.1  |                 |  JDK 8u212         | 16.04 - `jdk-8u212-ubuntu-16.04`   | 7 - `jdk-8u212-centos-7`         |
| Alfresco 5.0  |                 |  JDK 8u212         | 14.04 - `jdk-8u212-ubuntu-14.04`   |                                  |
| Alfresco 4.2  | JDK 7u211       |                    | 14.04 - `jdk-7u211-ubuntu-14.04`   |                                  |
| Alfresco 4.1  | JDK 6b41        |                    | 14.04 - `jdk-6u41-ubuntu-14.04`    |                                  |
| Alfresco 4.0  | JDK 6b41        |                    | 14.04 - `jdk-6u41-ubuntu-14.04`    |                                  |

### Operating Systems

*  Ubuntu 18.04 LTS - `ubuntu:bionic`
*  Ubuntu 16.04 LTS - `ubuntu:xenial`
*  Ubuntu 14.04 LTS - `ubuntu:trusty`
*  CentOS 7 - `centos:7`
*  CentOS 6 - `centos:6`

## Initialization

This image uses Docker `ENTRYPOINT` to provide initialization hooks.

If you would like to do additional initialization in an image derived from this one, add one or more `*.sh` scripts under `/docker-entrypoint.d/`. The scripts are _source_'d and do not need to be executable. This means these scripts run within the existing shell, any variables created or modified by the script will remain available after the script completes. These initialization scripts will be executed in sorted name order as defined by the current locale.

After initialization completes, the main `CMD` will be _exec_'ed, to avoid starting the main process in a subshell.

You can override or disable the initialization scripts by overriding the `ENTRYPOINT` instruction using the `docker run --entrypoint` flag.

## Contributions

### How to build

Release builds are produced by [Jenkins](https://jenkins-2.xenit.eu/) driving Gradle from a `Jenkinsfile`.

**TO DO: change to travis once moved to github**

To build a local version of the java image:

```
./gradlew buildDockerImage
```

Note that locally build image-tags will be prefixed with `local-`, so they can be clearly distinguished from _Release_-builds.
