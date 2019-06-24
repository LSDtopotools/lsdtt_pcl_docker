# The *LSDTopoTools* complete container

![](https://raw.githubusercontent.com/LSDtopotools/lsdtt_alpine_docker/master/images/LSD-logo.png)

This is the full *LSDTopoTools* distrubtion that includes the [Point Cloud Library (PCL)](https://en.wikipedia.org/wiki/Point_Cloud_Library). It is built on top of an Ubunutu operating system. This is a rather large (663 Mb) container since PCL is large and has many dependencies. If you don't anticipate [extracting terraces](https://www.earth-surf-dynam.net/5/369/2017/), [using swaths](https://www.earth-surf-dynam.net/2/97/2014/), or [playing with point clouds to estimate biomass](https://esajournals.onlinelibrary.wiley.com/doi/abs/10.1890/14-0649.1), then consider using the much more lightweight [LSDTopoTools Alpine container](https://hub.docker.com/r/lsdtopotools/lsdtt_alpine_docker/). 

Information about the automatically built container can be found here: https://hub.docker.com/r/lsdtopotools/lsdtt_pcl_docker/ 

For full documentation, [see the LSDTopoTools documentation site](https://lsdtopotools.github.io/LSDTT_documentation/).

You can also read [specific installation instruction](https://lsdtopotools.github.io/LSDTT_documentation/LSDTT_installation.html#_installing_lsdtopotools_using_docker).

## Instructions

### Installing Docker

These are the bare bones instructions. For a bit more detail and potential bug fixes, scroll down to the section on [Docker notes](#docker-notes).

1. Download and install [Docker for Windows](https://www.docker.com/docker-windows) (only works with Windows 10 enterprise), [Docker for Mac](https://www.docker.com/docker-mac), or Docker for [Ubuntu](https://www.docker.com/docker-ubuntu) or [Debian](https://www.docker.com/docker-debian).
  * On MacOS we recommend installing docker using brew: `brew cask install docker`
  * On MacOs and Linux, after you install docker you will need to add permissions: `sudo usermod -a -G docker $USER`
  * On Windows 10 you will need to alter a bunch of settings. See [DNSection][Docker notes] 
2. We will henceforth assume that you actually have a functioning version of Docker on your host machine. If you want more details about how to use docker, or getting it set up (particularly in Windows, in Linux and MacOS this is more straightforward), see our [Docker notes](#docker-notes).

### Running the container

#### Part 1: set up an LSDTopoTools directory on your host machine

1. You will want to be able to see *LSDTopoTools* output on your host operating system, so we will need to create a directory for hosting your *LSDTopoTools* data, code, and scripts. 
2. For the purposes of this tutorial, I will assume you are using windows and that you have made a directory `C:\LSDTopoTools`. 
  * You can put this directory anywhere you want as long as you remember where it is. You don't need to put anything in this directory yet. 
  
#### Part 2: Download and run the container

1. To get the container, go into a terminal (MacOS or Linux) or Powershell window (Windows) that has docker enabled and run:
```console
$ docker pull lsdtopotools/lsdtt_pcl_docker
```
2. Now you need to run the container:
```console
$ docker run -it -v C:\LSDTopoTools:/LSDTopoTools lsdtopotools/lsdtt_pcl_docker
```
  1. The `-it` means "interactive".
  2. The `-v` stands for "volume" and in practice it links the files in the docker container with files in your host operating system. 
  3. After the `-v` you need to tell docker where the directories are on both the host operating system (in this case `C:\LSDTopoTools`) and the container (in this case `/LSDTopoTools`). These are separated by a colon (`:`).
3. Once you do this you will get a `#` symbol showing that you are inside the container. You can now do *LSDTopoTools* stuff. 
4. *IMPORTANT* you will need to run a script to clone or update *LSDTopoTools*. Run this by simply entering `Start_LSDTT.sh` into the command line. 
5. To exit the container use `ctrl-D`. The containers all have linux environments so you will be able to use linux command line tools within the docker container.

### Docker notes

If you want to know all about Docker, make sure to read the [docker documentation](https://docs.docker.com/). A note of warning: Docker documentation is similar to documentation for the [turbo encabulator](https://www.youtube.com/watch?v=rLDgQg6bq7o). Below are some brief notes to help you with the essentials. 

#### Docker quick reference
***
Here are some shortcuts if you just need a reminder of how docker works. 

List all containers
```console
$ docker ps -a
```

List containers with size
```console
$ docker ps -as
```

Remove all unused containers
```console
$ docker system prune
```
***

#### Docker on Linux

After you install docker on Linux, you will need to add users to the docker permissions:

```console
$ sudo usermod -a -G docker $USER
```

Once you have done this you will need to log out and log back in again. 


#### Docker for Windows

I have not made any scientific study of this but most *LSDTopoTools* users are on Windows operating systems. 

Firstly, you need to have *Windows 10 Enterprise*. It will not work otherwise (well, that is [not exactly true](https://stefanscherer.github.io/yes-you-can-docker-on-windows-7/) but getting it to work on Windows 7 is a massive pain). If you don't have Windows 10 Enterprise but are on Windows you probably should use Vagrant; see [our vagrant documentation](https://lsdtopotools.github.io/LSDTT_documentation/LSDTT_installation.html#_installing_lsdtopotools_using_virtualbox_and_vagrant). If you do have Windows 10 enterprise then you can download and install Docker for Windows CE. After you install this you will need to restart your computer not once but twice: once after install and a second time to activate the hyper-V feature, which allows you to have 64 bit guest operating systems.

Second, if you have that and have it installed, you might also need to add yourself to the `docker-users` group. To do that, do this (instructions from here: https://github.com/docker/for-win/issues/868):

1. Logon to Windows as Administrator
2. Go to Windows Administrator Tools
3. Look for Windows Computer Management and click on it.
4. Or you can skip steps 1-3, right mouse clicking Computer Management, go to more, and select run as administrator and provide Administrator password.
5. Double click docker-users group and add your account as member.
6. Also add your account to Hyper-V Administrator. This was added when you installed docker for Windows.
7. Log off from Windows and log back on.
8. Click on Windows icon on bottom left and start Docker for Windows. This will start docker windows service.
9. Start Windows Powershell and type docker --version. It will show Docker version 17.09.1-ce, build 19e2cf6, or whatever version you have.