FROM ubuntu:22.04

#Locale
ENV LANG C.UTF-8

ARG USERNAME=vscode
ARG USER_UID=1000
ARG USER_GID=$USER_UID


RUN apt-get update \
	&& apt-get install -y sudo ca-certificates aria2 zsh \
	&& apt-get install -y wget curl git xz-utils zip unzip clang cmake ninja-build pkg-config libgtk-3-dev liblzma-dev --no-install-recommends 

RUN	apt-get autoremove -y \
	&& apt-get clean -y \
	&& rm -rf /var/lib/apt/lists/* 

RUN	groupadd --gid $USER_GID $USERNAME \
	&& useradd -s /bin/bash --uid $USER_UID --gid $USER_GID -m $USERNAME \
	&& echo $USERNAME ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/$USERNAME \
	&& chmod 0440 /etc/sudoers.d/$USERNAME 

USER $USERNAME
WORKDIR /home/$USERNAME

ENV FLUTTER_CHANNEL="stable"
ENV FLUTTER_VERSION="3.3.9"

ENV FLUTTER_HOME=/home/$USERNAME/flutter
ENV PATH=${PATH}:${FLUTTER_HOME}/bin

RUN aria2c -x4 -o flutter.tar.xz https://storage.googleapis.com/flutter_infra_release/releases/${FLUTTER_CHANNEL}/linux/flutter_linux_${FLUTTER_VERSION}-${FLUTTER_CHANNEL}.tar.xz \
	&& tar -xf flutter.tar.xz -C ~ \
	&& rm flutter.tar.xz 
RUN flutter config --no-analytics \
	&& flutter update-packages

RUN sh -c "$(wget -O- https://github.com/deluan/zsh-in-docker/releases/download/v1.1.2/zsh-in-docker.sh)" -- \
    -t robbyrussell \
    -p git \
    -p copyfile \
    -p extract \
    -p colorize \
    -p flutter