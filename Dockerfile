from ubuntu:18.04
# Install prerequisites

run apt-get update && apt-get install apt-utils -y

run apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y \
    build-essential \
    cmake \
    curl \
    libcurl3-dev \
    libleptonica-dev \
    liblog4cplus-dev \
    libopencv-dev \
    libtesseract-dev \
    wget \
    python3 python3-pip \
    tesseract-ocr \
    software-properties-common

run add-apt-repository ppa:alex-p/tesseract-ocr -y
run apt-get update -y && apt-get purge libtesseract-dev -y  \
    libtesseract-dev \
    git
    
workdir /srv/

run git clone https://github.com/openalpr/openalpr.git

# Setup the build directory
run mkdir /srv/openalpr/src/build
workdir /srv/openalpr/src/build

# Setup the compile environment
run cmake -DCMAKE_INSTALL_PREFIX:PATH=/usr -DCMAKE_INSTALL_SYSCONFDIR:PATH=/etc .. && \
    make -j2 && \
    make install

workdir /srv/openalpr/src/bindings/python
run python3 setup.py install
workdir /data

CMD [ "/bin/bash" ]

