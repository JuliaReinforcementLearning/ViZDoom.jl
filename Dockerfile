FROM julia:1.6-buster

RUN apt-get update && apt-get install -y git curl

# Doom dependencies
RUN apt-get update && apt-get install -y cmake build-essential zlib1g-dev libsdl2-dev libjpeg-dev \
        nasm tar libbz2-dev libgtk2.0-dev cmake git libfluidsynth-dev libgme-dev \
        libopenal-dev timidity libwildmidi-dev unzip wget \
        libboost-all-dev

# Add a user for docker best practice & mounting fixes with devcontainer
# This fixes an issue where the root docker user creates the _vizdoom folder that can't be removed/mounted
# Note this user doesn't have root access so all apt-get commands must be run before this line
RUN adduser --disabled-password docker
USER docker

# Copy ViZDoom to /home/docker/ViZDoom, as the docker user
COPY --chown=docker:docker . /home/docker/ViZDoom
WORKDIR /home/docker/ViZDoom

# Run the install
RUN julia -e 'using Pkg; Pkg.add(path="./")'

ENTRYPOINT [ "/bin/bash" ]