# 3D City Database PostGIS Docker image

This fork is used to create legacy 3DCityDB containers based on specific versions.

**!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!**

**Deprecation notice:** This repository has been deprecated on 6th of September 2021.
The Docker images and this documentation will no longer be updated, because the content
has moved to the [official 3DCityDB repository](https://github.com/3dcitydb). The old
images will remain available on DockerHub, however, we recommend to migrate to the new
version.

Please find the **new Docker images** and **updated documentation** here:

* Source code, Dockerfiles: https://github.com/3dcitydb/3dcitydb
* Documentation: https://3dcitydb-docs.readthedocs.io/en/latest/3dcitydb/docker.html
* Docker image repository: https://hub.docker.com/repository/docker/3dcitydb/3dcitydb-pg

**!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!**

This repo contains Dockerfiles to create a
[3D City Database (3DCityDB)](https://github.com/3dcitydb)
running on a [PostgreSQL](https://www.postgresql.org/) DBMS with
[PostGIS](https://postgis.net/). To get the 3DCityDB PostGIS Docker
images visit the [tumgis/3dcitydb-postgis](https://hub.docker.com/r/tumgis/3dcitydb-postgis/) DockerHub page.

To get started immediately go to the [quick start](#quick-start) section.

> **Note:** The content in this repo is in development stage.
> If you experience any problems or have a suggestion/improvement
> please let me know by creating an
> [issue](https://github.com/tum-gis/3dcitydb-docker-postgis/issues)
> or make a contribution with a
> [pull request](https://github.com/tum-gis/3dcitydb-docker-postgis/pulls).

## News

* Current build status: [![Build Status](https://img.shields.io/travis/tum-gis/3dcitydb-docker-postgis/master.svg?label=master)](https://travis-ci.com/tum-gis/3dcitydb-docker-postgis) [![Build Status](https://img.shields.io/travis/tum-gis/3dcitydb-docker-postgis/devel.svg?label=devel)](https://travis-ci.com/tum-gis/3dcitydb-docker-postgis#devel)

* 2020/10 - 3DCityDB v4.0.3 now supported.
* 2019/11 - Upgrade to Postgresql 12 and PostGIS 3.0
* 2019/08 - 3DCityDB v4.0.2 now supported.
* 2019/01 - 3DCityDB v4.0.1 now supported.
* 2018/09 - 3DCityDB v4.0.0 now supported.
* 2018/03 - Alpine Linux image versions released!

## Features

* *Quickstart scripts* for interactive container creation for
convenience and Docker newcomers.
* Helper scripts for *adding*, *removing* and *purging* a
3DCityDB instance inside a container.

## More 3DCityDB Docker Images

Check out the Docker images for the *3D City Database Web Feature Service (WFS)*
and the *3D City Database Web-Map-Client* too:

* [3DCityDB Web Feature Service(WFS) image](https://github.com/tum-gis/3dcitydb-wfs-docker/)
* [3DCityDB Web-Map-Client image](https://github.com/tum-gis/3dcitydb-web-map-docker/)

## Content

- [3D City Database PostGIS Docker image](#3d-city-database-postgis-docker-image)
  - [News](#news)
  - [Features](#features)
  - [More 3DCityDB Docker Images](#more-3dcitydb-docker-images)
  - [Content](#content)
  - [Image versions (tags)](#image-versions-tags)
  - [What is the 3D City Database](#what-is-the-3d-city-database)
  - [Quick start](#quick-start)
  - [How to use this image](#how-to-use-this-image)
    - [Linux Bash](#linux-bash)
    - [Windows CMD](#windows-cmd)
  - [Environment variables](#environment-variables)
    - [Usage examples](#usage-examples)
      - [Example Linux Bash](#example-linux-bash)
      - [Example Windows CMD](#example-windows-cmd)
  - [Helper scripts](#helper-scripts)
    - [Add/Create a 3DCityDB instance](#addcreate-a-3dcitydb-instance)
    - [Remove a 3DCityDB instance](#remove-a-3dcitydb-instance)
    - [Remove a 3DCityDB instance (entire database)](#remove-a-3dcitydb-instance-entire-database)
  - [Data storage and persistence](#data-storage-and-persistence)
    - [Volumes (recommended)](#volumes-recommended)
    - [Bind mounts](#bind-mounts)
    - [Tmpfs mounts](#tmpfs-mounts)
    - [Data within the writable layer of the container](#data-within-the-writable-layer-of-the-container)
  - [How to build](#how-to-build)
  - [Build parameters](#build-parameters)
    - [Build example](#build-example)
  - [Quick reference](#quick-reference)
  - [License](#license)

## Image versions (tags)

The full list of all available image versions (tags) is available on [DockerCloud](https://cloud.docker.com/swarm/tumgis/repository/docker/tumgis/3dcitydb-postgis/tags) or [DockerHub](https://hub.docker.com/r/tumgis/3dcitydb-postgis/tags/).

* **latest**, **alpine** - Latest stable version based on latest version of the 3DCityDB. Built from [master](https://github.com/tum-gis/3dcitydb-docker-postgis/tree/master) branch.
* **devel**, **devel-alpine** - Development version containing latest features. Based on latest release of the 3DCityDB. Built from [devel](https://github.com/tum-gis/3dcitydb-docker-postgis/tree/devel) branch. **Note:** Visit the [Github page of the devel](https://github.com/tum-gis/3dcitydb-docker-postgis/tree/devel) branch for the documentation of the latest features.
* **v3.0.0**, **v3.1.0**, **v3.2.0**, **v3.3.0**, **v3.3.1**, **v4.0.0**, **v4.0.1**, **v4.0.2**, **v4.0.3** - Same content as **latest** image, but built with a specific version (**vX.X.X**) of the 3DCityDB. Built from master branch.
* **alpine** - Lightweight Alpine Linux image versions are available for all above listed images by appending **-alpine** to the tag. For instance, **v3.3.1** -> **v3.3.1-alpine**.

Use `docker pull tumgis/3dcitydb-postgis:TAG` to download the latest version of the image with the specified `TAG` to your system. For instance, use `docker pull tumgis/3dcitydb-postgis:latest` or `docker pull tumgis/3dcitydb-postgis:latest-alpine` to pull the latest Debian or Alpine image versions.

## What is the 3D City Database

The award winning 3D City Database is a free geo database to store, represent,
and manage virtual 3D city models on top of a standard spatial relational
database. The database schema implements the CityGML standard with semantically
rich and multi-scale urban objects facilitating complex analysis tasks, far
beyond visualization. 3DCityDB is in productive and commercial use for more
than 10 years in many places around the world. It is also employed in numerous
research projects related to 3D city models.

The 3D City Database comes with tools for easy data exchange and coupling with
cloud services. The 3D City Database content can be directly exported in KML,
COLLADA, and glTF formats for the visualization in a broad range of
pplications like Google Earth, ArcGIS, and the WebGL-based Cesium Virtual Globe.

![3DCityDB](https://www.3dcitydb.org/3dcitydb/fileadmin/default/templates/images/logo.jpg "3DCityDB logo")
> [3DCityDB Official Homepage](https://www.3dcitydb.net/)
> [3DCityDB Github](https://github.com/3dcitydb)
> [CityGML](https://www.citygml.org/)
> [3DCityDB and CityGML Hands-on Tutorial](https://www.gis.bgu.tum.de/en/projects/3dcitydb/#c1425)

## Quick start

This section describes how to get a 3DCityDB PostGIS Docker container running as quick and easy as possible.

1. Install Docker on your system.
   This step is mandatory. Downloads and detailed instructions for various operating systems can be found here: [https://docs.docker.com/install/](https://docs.docker.com/install/)
2. Download (Rightclick -> Save target as) and execute a *Quickstart scripts*.
   The Quickstart scripts are meant for Docker newcomers and convenient usage of the images. They will guide you through the process of setting up a 3DCityDB Docker container. There is no previous knowledge on Docker required! The scripts will download the 3DCityDB PostGIS Docker image for form [DockerHub](https://hub.docker.com/r/tumgis/3dcitydb-postgis/) for you and interactively request all required configuration.

* [quickstart.bat](https://github.com/tum-gis/3dcitydb-docker-postgis/blob/devel/quickstart.bat) for **Windows** operating systems
* [quickstart.sh](https://github.com/tum-gis/3dcitydb-docker-postgis/blob/devel/quickstart.sh) for **Linux** based operating systems

## How to use this image

In this section you will find information on how to work with the 3DCityDB Docker image. For a comprehensive description of all *environment variables* and *usage examples* look further below. If you are new to Docker, I recommend reading the section on *data storage and persistence*. For building your own image scroll down to the *build* section at the bottom.

To quickly get a 3DCityDB instance running on Docker run following command and adapt the `POSTGRES_PASSWORD`, `SRID`, `SRSNAME` environment variables and the `-p` switch according to your needs.

> **Note:**
> Setting the `POSTGRES_PASSWORD` variable is mandatory.

### Linux Bash

```bash
docker run -dit --name citydb-container -p 5432:5432 \
    -e "POSTGRES_PASSWORD=changeMe!" \
    -e "SRID=31468" \
    -e "SRSNAME=urn:adv:crs:DE_DHDN_3GK4*DE_DHN92_NH" \
  tumgis/3dcitydb-postgis
```

### Windows CMD

```bat
docker run -dit --name citydb-container -p 5432:5432^
    -e "POSTGRES_PASSWORD=changeMe!"^
    -e "SRID=31468"^
    -e "SRSNAME=urn:adv:crs:DE_DHDN_3GK4*DE_DHN92_NH"^
  tumgis/3dcitydb-postgis
```

> **Note:**
> In the examples above long commands are broken to several lines for readability using the Bash (`\`) or CMD (`^`) line continuation.

When your Docker container is running according to the example above, you can connect to the 3DCityDB instance using e.g. the 3DCityDB ImporterExporter with the following credentials:

```text
HOST        my.docker.host
PORT        5432
TYPE        PostGIS
USERNAME    postgres
PASSWORD    changeMe!
DBNAME      citydb
```

To check if the 3DCityDB docker container is operational take a look at the container's log using `docker logs CONTAINER`. You will find a summary of the *database connection credentials* and the *spatial reference system* configuration in the log as well.

```bash
# example: follow log of container named "citydb-container"
docker logs -f citydb-container
```

## Environment variables

The `-p <host port>:<container port>` switch of the [`docker run`](https://docs.docker.com/engine/reference/commandline/run/) command allows you to specify on which port the 3DCityDB instance will listen on your host system. For instance, use `-p 1234:5432` if you want to access the database instance on port *1234* of the system hosting the Docker container.

To customize the 3DCityDB Docker container you need to adapt the environment variables specifying the EPSG code (`SRID`), the spatial reference system name (`SRSNAME`) and the database name (`CITYDBNAME`) according to your requirements. The table below gives an overview on the currently available configuration parameters. If a parameter is omitted in the [`docker run`](https://docs.docker.com/engine/reference/commandline/run/) call, its default value from the table is used.

| Parameter name    | Description                            | Default value     |
|-------------------|----------------------------------------|-------------------|
| CITYDBNAME        | Name of the database that is created at the first run of the container | *citydb* |
| SRID              | Spatial reference system identifier, SRID (EPSG code)     | *4326*            |
| SRSNAME           | Spatial reference system name          | *urn:ogc:def:crs:EPSG::4326*       |

The 3DCityDB Docker image provided here is based on the official PostgreSQL Docker image. There are much more configurations options available, e.g. for setting a custom *database user*, *password*, or *database data directory*. Please take a look at the [PostgreSQL Docker image documentation](https://hub.docker.com/_/postgres/) for more. For improved compatibility with the [3DCityDB ImporterExporter](https://github.com/3dcitydb/importer-exporter) default values for both database user and password are set, as listed in the table below.
**Please consider changing the default *username* and *password* combination for security reasons.**

| Parameter name    | Description                            | Default value     |
|-------------------|----------------------------------------|-------------------|
| POSTGRES_USER     | PostgreSQL database user               | *postgres*        |
| POSTGRES_PASSWORD | PostgreSQL database user password      | No default, variable is mandatory to be set with `docker run`.       |

### Usage examples

Below some examples for running a 3DCityDB container named *citydb-container* based on the *tumgis/3dcitydb-postgis* image are given. The 3DCityDB database name used in the example is *mycitydb*. The spatial reference system of the example 3DCityDB is *31468*, *urn:adv:crs:DE_DHDN_3GK4&ast;DE_DHN92_NH*. Moreover, we set the database to listen on port *1234* on our Docker host.

#### Example Linux Bash

```bash
# list all locally available images
docker images

# run container in foreground mode
docker run -it --name citydb-container -p 1234:5432 \
    -e "POSTGRES_PASSWORD=changeMe!" \
    -e "CITYDBNAME=mycitydb" \
    -e "SRID=31468" \
    -e "SRSNAME=urn:adv:crs:DE_DHDN_3GK4*DE_DHN92_NH" \
  tumgis/3dcitydb-postgis

# run container in foreground mode with interactive bash shell, e.g. for making changes to the container
docker run -it --name citydb-container -p 1234:5432 \
    -e "POSTGRES_PASSWORD=changeMe!" \
    -e "CITYDBNAME=mycitydb" \
    -e "SRID=31468" \
    -e "SRSNAME=urn:adv:crs:DE_DHDN_3GK4*DE_DHN92_NH" \
  tumgis/3dcitydb-postgis bash

# run container in detached (background) mode
docker run -dit --name citydb-container -p 1234:5432 \
    -e "POSTGRES_PASSWORD=changeMe!" \
    -e "CITYDBNAME=mycitydb" \
    -e "SRID=31468" \
    -e "SRSNAME=urn:adv:crs:DE_DHDN_3GK4*DE_DHN92_NH" \
  tumgis/3dcitydb-postgis

# Useful docker commands
docker ps -a                      # list all running and stopped containers
docker port citydb-container      # show the port mapping for the container named citydb-container
docker stop citydb-container      # stop a running container
docker start citydb-container     # start a stopped container
docker rm citydb-container        # remove a container
docker rm -fv citydb-container    # remove a running container and delete its data volume
```

#### Example Windows CMD

```bat
:: run container in foreground mode
docker run -it --name citydb-container -p 1234:5432^
    -e "POSTGRES_PASSWORD=changeMe!"^
    -e "CITYDBNAME=mycitydb"^
    -e "SRID=31468"^
    -e "SRSNAME=urn:adv:crs:DE_DHDN_3GK4*DE_DHN92_NH"^
    tumgis/3dcitydb-postgis

:: run container in foreground mode with interactive bash shell, e.g. for making changes to the container
docker run -it --name citydb-container -p 1234:5432^
    -e "POSTGRES_PASSWORD=changeMe!"^
    -e "CITYDBNAME=mycitydb"^
    -e "SRID=31468"^
    -e "SRSNAME=urn:adv:crs:DE_DHDN_3GK4*DE_DHN92_NH"^
    tumgis/3dcitydb-postgis bash

:: run container in detached (background) mode
docker run -d --name citydb-container -p 1234:5432^
    -e "POSTGRES_PASSWORD=changeMe!"^
    -e "CITYDBNAME=mycitydb"^
    -e "SRID=31468"^
    -e "SRSNAME=urn:adv:crs:DE_DHDN_3GK4*DE_DHN92_NH"^
    tumgis/3dcitydb-postgis
```

> **Note:**
> In the examples above long commands are broken to several lines for readability using the Bash (`\`) or CMD (`^`) line continuation.

## Helper scripts

The 3DCityDB PostGIS Docker image comes with helper scripts for *adding*, *removing* and *purging* a 3DCityDB instance inside a running container. The scripts can be applied from outside the container using the [docker exec](https://docs.docker.com/engine/reference/commandline/exec/) command. When using the utilities from outside a container, the container name or ID (`CONTAINER`) needs to be known. To get an interactive shell inside your container run:

```bash
docker exec -it CONTAINER bash
```

### Add/Create a 3DCityDB instance

The `addcitydb` utility creates a new 3DCityDB instance inside a container. The tool requires three parameters, a *database name* (`DBNAME`) and the `SRID` and `SRSNAME` of the spatial reference system of the database instance to create.

```bash
addcitydb DBNAME SRID SRSNAME   # Usage
# When inside container with interactive shell
addcitydb myNew-Database 31468 urn:adv:crs:DE_DHDN_3GK4*DE_DHN92_NH
# From outside the container (docker host shell)
docker exec -it CONTAINER addcitydb myNew-Database 31468 urn:adv:crs:DE_DHDN_3GK4*DE_DHN92_NH
```

### Remove a 3DCityDB instance

The `dropcitydb` utility removes the 3DCityDB schema (and all data) from an existing 3DCityDB instance inside a container. Use with care! The database is **not** removed. The only required parameter is the database name (`DBNAME`).

```bash
dropcitydb DBNAME   # Usage
# When inside container with interactive shell
dropcitydb my-Database
# From outside the container (docker host shell)
docker exec -it CONTAINER dropcitydb myNew-Database
```

### Remove a 3DCityDB instance (entire database)

The `purgedb` utility removes a database from the PostgreSQL server running inside the container. **All data and settings (e.g. user rights) of this database are lost.** Use with care! The only required parameter is the database name (`DBNAME`).

```bash
purgedb DBNAME   # Usage
# When inside container with interactive shell
purgedb my-Database
# From outside the container (docker host shell)
docker exec -it CONTAINER purgedb myNew-Database
```

## Data storage and persistence

When you are new to Docker, the way data is managed and stored is very likely to be different from what you expect. It is possible to store data used in Docker containers in four different ways, all of them with their pros and cons. If you are not sure which data persistence strategy to go for, it is recommend to use a **Volume**, which is the default behavior and suitable for most use cases. For more guidance regarding Docker data management head over to the [Docker data management](https://docs.docker.com/engine/admin/volumes/) article. Below, a brief excerpt of the original article and some examples are shown. One important difference between the data management alternatives is where the data lives on the Docker host, as depicted in the image below.

![Docker data storage](https://docs.docker.com/storage/images/types-of-mounts.png "Docker data storage")
  (Image from [Docker data management](https://docs.docker.com/engine/admin/volumes/))

* **Volumes** are stored in a part of the host filesystem which is managed by Docker (`/var/lib/docker/volumes/` on Linux).
  Non-Docker processes should not modify this part of the filesystem. Volumes are the best way to persist data in Docker.
* **Bind mounts** may be stored anywhere on the host system. They may even be important system files or directories. Non-Docker processes on the Docker host or a Docker container can modify them at any time.
* **tmpfs mounts** are stored in the host system’s memory only, and are never written to the host system’s filesystem.
* Data stored within the **writable layer of the container** can be committed to a new "docker image with data". There are several downsides to this approach and it should only be applied in special situations.

### Volumes (recommended)

Volumes are created and managed by Docker. You can create a volume explicitly using the [`docker volume create`](https://docs.docker.com/engine/reference/commandline/volume_create/) command, or Docker can create a volume during container or service creation. By default, Docker will take care of the volume creation and management for you when using the 3DCityDB Docker image. Following example shows how to create a *named volume* and mount it for usage with the 3DCityDB Docker container.

```bash
docker volume create pgdata
docker run -dit --name citydb-container -p 5432:5432 \
    -v pgdata:/var/lib/postgresql/data \
    -e "SRID=31468" \
    -e "SRSNAME=urn:adv:crs:DE_DHDN_3GK4*DE_DHN92_NH" \
    -e "POSTGRES_PASSWORD=changeMe!" \
  tumgis/3dcitydb-postgis
```

Your data will be persistently stored in the volume named *pgdata* (list volumes with `docker volume ls`) even if your container is stopped, removed or Docker engine crashes. To remove the volume and your data with it run `docker volume rm pgdata`. If you want to remove the volume when removing the container run `docker rm -v citydb-container`. Docker provides much more options when working with volumes. Take a look the [docker volume usage documentation](https://docs.docker.com/engine/admin/volumes/volumes/) for more insight.

### Bind mounts

When you use a bind mount, a file or directory on the host machine is mounted into a container. The file or directory is referenced by its full or relative path on the host machine. The example below will create (if not exists) the directory `/dockerdata/pgdata` on your host machine and will mount it to `/var/lib/postgresql/data` in the 3DCityDB Docker container.

```bash
docker run -dit --name citydb-container -p 5432:5432 \
    -v /dockerdata/pgdata:/var/lib/postgresql/data \
    -e "SRID=31468" \
    -e "SRSNAME=urn:adv:crs:DE_DHDN_3GK4*DE_DHN92_NH" \
    -e "POSTGRES_PASSWORD=changeMe!" \
  tumgis/3dcitydb-postgis
```

Your data will persistently reside in that directory until you remove it from the host system, even if the Docker container is stopped, removed or Docker engine crashes. Docker provides much more options when working with bind mounts. Take a look the [docker bind mount usage documentation](https://docs.docker.com/engine/admin/volumes/bind-mounts/) for more insight.

### Tmpfs mounts

There may be cases where you do not want to store a container’s data on the host machine, but you also don’t want to write the data into the container’s writable layer, e.g. for performance or security reasons. An example might be a temporary data set, for instance temporary data required during a GIS workflow. To give the container access to the data without writing it anywhere permanently, you can use a tmpfs mount, which is only stored in the host machine’s memory (or swap, if memory is low). Following example shows how to run a 3DCityDB container with its data stored in the host system's main memory using a tmpfs mount.

```bash
docker run -dit --name citydb-container -p 5432:5432 \
    --tmpfs /pgtmpfs \
    -e "PGDATA=/pgtmpfs" \
    -e "SRID=31468" \
    -e "SRSNAME=urn:adv:crs:DE_DHDN_3GK4*DE_DHN92_NH" \
    -e "POSTGRES_PASSWORD=changeMe!" \
  tumgis/3dcitydb-postgis
```

Docker provides much more options when working with tmpfs mounts. Take a look the [docker tmpfs mount usage documentation](https://docs.docker.com/engine/admin/volumes/tmpfs/) for more insight.

> **Note:**
> *tmpfs* mounts only work on Linux containers, and not on Windows containers.

### Data within the writable layer of the container

It is possible to store data within the writable layer of a container, but there are some downsides:

* The data won’t persist when that container is no longer running, and it can be difficult to get the data out of the container if another process needs it.
* A container’s writable layer is tightly coupled to the host machine where the container is running. You can’t easily move the data somewhere else.
* Writing into a container’s writable layer requires a storage driver to manage the filesystem. The storage driver provides a union filesystem, using the Linux kernel. This extra abstraction reduces performance as compared to using data volumes, which write directly to the host filesystem.

However, in certain situations it may be helpful to store data within the container's writable layer, for instance, when you need to provide a *Docker image containing data*. A possible scenario is a training course where you want to be able to easily provide several 3DCityDB instances including the same dataset for the course participants and performance or data persistence is not an issue. An 3DCityDB image for such use cases is in development and will be provided here soon.

## How to build

Building an image from the Dockerfile in this repo is done by downloading the source code from this repo and running the [`docker build`](https://docs.docker.com/engine/reference/commandline/build/) command. Follow the step below to build a 3DCityDB Docker image.

```bash
# 1. Download source code e.g. using git.
git clone https://github.com/tum-gis/3dcitydb-docker-postgis.git
# 2. Change to the source folder you just cloned.
cd 3dcitydb-docker
# 3. Build a docker image tagged as 3dcitydb-postgis.
docker build -t 3dcitydb-postgis .
```

## Build parameters

To build a Docker image with a specific *3DCityDB version* or a different *default database name* the [`docker build --build-arg "ARGNAME=VALUE"`](https://docs.docker.com/engine/reference/commandline/build/) parameter can be used. The table below lists the currently available build arguments and their default values.

| Parameter name         | Description                                               | Default value     |
|------------------------|-----------------------------------------------------------|-------------------|
| baseimage_tag          | Version/tag of the base image to use (use with caution!!) | *10*              |
| citydb_version         | Version of the 3DCityDB                                   | *v4.0.0*          |

### Build example

The example below builds a Docker image named *3dcitydb-postgis* tagged as *v3.0.0* from the *Dockerfile* in the current working directory using the given *build arguments*.

```bash
docker build -t 3dcitydb-postgis:pg9.6-v3.0.0 \
    --build-arg "baseimage_tag=9.6" \
    --build-arg "citydb_version=v3.0.0" \
  .
```

## Quick reference

* Where to get help:
  [the Docker Community Forums](https://forums.docker.com/), [the docker Community Stack](https://blog.docker.com/2016/11/introducing-docker-community-directory-docker-community-slack/), [Stack Overflow](https://stackoverflow.com/search?tab=newest&q=docker)
* Where to file issues:
  [tum-gis/3dcitydb-docker-postgis](https://github.com/tum-gis/3dcitydb-docker-postgis/issues)
* Maintained by:
  [Bruno Willenborg, Chair of Geoinformatics, Technical University of Munich (TUM)](https://www.gis.bgu.tum.de/)

## License

The content of this repository is released under the terms of the [Apache-2.0 License](https://github.com/tum-gis/3dcitydb-docker-postgis/blob/master/LICENSE). The software components used in this project may be subject to different licensing conditions. Please refer to the website of the individual projects for further information.
