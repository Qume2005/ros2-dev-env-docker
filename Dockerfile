FROM ubuntu:22.04

LABEL maintainer="qume2005@outlook.com"

ENV LANG=en_US.UTF-8

#init
ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=Etc/UTC

RUN apt update -y && \
    apt install -y tzdata && \
    ln -fs /usr/share/zoneinfo/Etc/UTC /etc/localtime && \
    dpkg-reconfigure --frontend noninteractive tzdata && \
    apt update -y && apt install -y \
    build-essential \
    curl \
    gnupg2 \
    lsb-release \
    locales \
    software-properties-common \
    x11-apps && \
    apt-get clean -y && rm -rf /var/lib/apt/lists/*

#setup ros2
ENV ROS_DISTRO=humble
RUN apt update -y && apt install -y locales && \
    locale-gen en_US en_US.UTF-8 && \
    update-locale LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8 && \
    export LANG=en_US.UTF-8 && \
    apt install -y software-properties-common && \
    add-apt-repository -y universe && \
    apt update -y && apt install -y curl && \
    curl -sSL https://raw.githubusercontent.com/ros/rosdistro/master/ros.key -o /usr/share/keyrings/ros-archive-keyring.gpg && \
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/ros-archive-keyring.gpg] http://packages.ros.org/ros2/ubuntu $(. /etc/os-release && echo $UBUNTU_CODENAME) main" | tee /etc/apt/sources.list.d/ros2.list > /dev/null && \
    apt update -y && \
    apt upgrade -y && \
    apt install -y ros-humble-desktop && \
    apt install -y ros-dev-tools && \
    apt update -y && \
    apt install -y ros-humble-turtlesim && \
    apt update -y && \
    apt install -y '~nros-humble-rqt*' && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

#setup ros2 env
RUN echo "source /opt/ros/humble/setup.bash" >> /etc/bash.bashrc

ENTRYPOINT ["sleep", "infinity"]
