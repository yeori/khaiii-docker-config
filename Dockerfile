#
# Build Image
#
FROM ubuntu:18.04 as base

RUN apt-get update && apt install -y git
RUN echo "Downloading khaiii repo" \
  && git clone https://github.com/kakao/khaiii.git \
  && echo "repo downloaded"

WORKDIR /khaiii

RUN apt-get install -y \ 
  build-essential python3 python3-pip git cmake \
  && pip3 install --upgrade pip

RUN echo "[Stage] base" >> install.log \
  && echo " * Python\n$(python3 --version 2>&1)" >> install.log \
  && echo " * PIP\n$(pip --version 2>&1)" >> install.log \
  && echo " * CMake\n$(cmake --version 2>&1)" >> install.log \
  && echo " * g++\n$(g++ --version 2>&1)" >> install.log \
  && echo "\n"

# COPY ./khaiii/ .

RUN mkdir build

RUN cd build && cmake .. \
  && make all \
  && make resource \
  && make install \
  && make package_python \
  && cd package_python \
  && pip install .

### runtime image ##########################################
FROM ubuntu:18.04 as runtime

ENV LANG=en_US.UTF-8

RUN apt-get update \
  && apt-get install -y --no-install-recommends \
    python3 \
    python3-pip \
    tree \
    language-pack-ko \
  && pip3 install --upgrade pip

WORKDIR /khaiii
COPY --from=base /khaiii/install.log .
COPY --from=base /khaiii/build build
COPY --from=base /usr/local /usr/local

RUN locale-gen en_US.UTF-8 \
  && update-locale LANG=en_US.UTF-8

VOLUME [ "/ws" ]

ENTRYPOINT [ "bash" ]

