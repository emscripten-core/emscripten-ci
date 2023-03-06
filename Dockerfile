## Base Image
FROM buildpack-deps:focal

## Package Installation (apt-get)
RUN EXTRA_CHROME_DEPS="lsb-release fonts-liberation libappindicator3-1" \
# preseed packages so that apt-get won't prompt for user input
    && echo "keyboard-configuration keyboard-configuration/layoutcode string us" | debconf-set-selections \
    && echo "ttf-mscorefonts-installer msttcorefonts/accepted-mscorefonts-eula select true" | debconf-set-selections \
    && apt-get update -q \
    && DEBIAN_FRONTEND=noninteractive apt-get install -q -y \
# build packages
        build-essential \
        cmake \
        openjdk-8-jre-headless `# openjdk-9 is also available, but hits #7232` \
        python-setuptools \
        python3 \
        python3-pip \
# docs packages
        sphinx-common \
# test packages
        $EXTRA_CHROME_DEPS \
        chromium-browser \
        dbus-x11 \
        firefox \
        menu \
        openbox \
        ttf-mscorefonts-installer \
        unzip \
        xinit \
        xserver-xorg \
        xserver-xorg-video-dummy \
        xvfb \
    && apt-get clean 

## Install pip2
RUN curl -fsSL https://bootstrap.pypa.io/pip/2.7/get-pip.py | python2

## Package Installation (pip)
RUN python2 -m pip install --no-cache-dir --upgrade pip \
    && python2 -m pip install --no-cache-dir flake8==3.7.8

RUN python3 -m pip install --no-cache-dir --upgrade pip \
    && python3 -m pip install --no-cache-dir flake8==3.7.8
