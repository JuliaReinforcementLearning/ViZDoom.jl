FROM julia:1.6-buster

RUN apt-get update && apt-get install -y git curl

# Doom dependencies
RUN apt-get update && apt-get install -y cmake build-essential zlib1g-dev libsdl2-dev libjpeg-dev \
        nasm tar libbz2-dev libgtk2.0-dev cmake git libfluidsynth-dev libgme-dev \
        libopenal-dev timidity libwildmidi-dev unzip wget \
        libboost-all-dev

# Copy ViZDoom to /home/root/ViZDoom
COPY . /home/root/ViZDoom
WORKDIR /home/root/ViZDoom

# Run the install
RUN julia -e 'using Pkg; Pkg.add(path="./")'

ENTRYPOINT [ "/bin/bash" ]