#
# Build Image
#
FROM ubuntu:18.04 as base

ARG PYTHON_VERSION=3.11
WORKDIR /khaiii

RUN apt-get update
RUN apt-get install -y language-pack-ko
RUN locale-gen en_US.UTF-8
RUN update-locale LANG=en_US.UTF-8

RUN apt-get install -y build-essential
RUN apt-get install -y python3
RUN apt-get install -y python3-pip
RUN pip3 install --upgrade pip
RUN apt-get install -y cmake

RUN touch install.log
RUN echo "[Python]\n * $(python3 --version 2>&1)" >> install.log
RUN echo "[PIP]\n * $(pip --version 2>&1)" >> install.log
RUN echo "[CMake]\n * $(cmake --version 2>&1)" >> install.log
RUN echo "[g++]\n$(g++ --version 2>&1)" >> install.log

COPY ./khaiii/ .
RUN mkdir build

RUN cd build && cmake ..
RUN cd build && make all
RUN cd build && make resource

RUN cd build && make install
RUN cd build && make package_python \
  && cd package_python && pip install .

ENV LANG=en_US.UTF-8

VOLUME [ "/ws" ]
#
# Runtime image
#
FROM ubuntu:18.04 as runtime

ENV LANG=en_US.UTF-8

RUN apt-get update
RUN apt-get install -y python3
RUN apt-get install -y python3-pip
RUN pip3 install --upgrade pip
RUN apt-get install -y tree

WORKDIR /khaiii
COPY --from=base /khaiii/build build

RUN ls -al /khaiii/build

COPY --from=base /usr/local /usr/local

RUN echo "[/usr/local/bin]\n" && tree /usr/local/bin
RUN echo "[/usr/local/include]\n" && tree /usr/local/include
RUN echo "[/usr/local/libd]\n" && tree -L 2 /usr/local/lib
RUN echo "[/usr/local/share]\n" && tree /usr/local/share

RUN apt-get install -y language-pack-ko
RUN locale-gen en_US.UTF-8
RUN update-locale LANG=en_US.UTF-8

VOLUME [ "/ws" ]

ENTRYPOINT [ "bash" ]

