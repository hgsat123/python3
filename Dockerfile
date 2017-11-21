FROM debian:latest
MAINTAINER "Satish Hegde" <satish.hegde@wipro.com>

#Install buiild essentials
RUN apt-get update && apt-get -y install wget procps
RUN apt-get install -y build-essential libssl-dev python-pip python-dev

#Download Python 3.5.x version
ENV PYTHON_VER=3.5.2

WORKDIR /tmp
RUN wget https://www.python.org/ftp/python/${PYTHON_VER}/Python-${PYTHON_VER}.tgz && tar xzvf Python-${PYTHON_VER}.tgz && rm -rf Python-${PYTHON_VER}.tgz

RUN cd /tmp/Python-${PYTHON_VER} \
       && /tmp/Python-${PYTHON_VER}/configure --prefix=/usr/local

WORKDIR /tmp/Python-${PYTHON_VER}
RUN make && make install \
    && ln -s /usr/local/bin/python3.5 /usr/local/bin/python \
    && rm -rf /tmp/Python-${PYTHON_VER}

WORKDIR /
CMD /bin/bash
