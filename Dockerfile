## Base Image
FROM buildpack-deps:jammy

## Package Installation (apt-get)
RUN EXTRA_CHROME_DEPS="lsb-release fonts-liberation libappindicator3-1 libu2f-udev libvulkan1 xdg-utils" \
    EXTRA_FIREFOX_DEPS="pulseaudio" \
# preseed packages so that apt-get won't prompt for user input
    && echo "keyboard-configuration keyboard-configuration/layoutcode string us" | debconf-set-selections \
    && echo "ttf-mscorefonts-installer msttcorefonts/accepted-mscorefonts-eula select true" | debconf-set-selections \
    && apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y \
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
        $EXTRA_FIREFOX_DEPS \
        $EXTRA_CHROME_DEPS \
        chromium-browser \
        libasound2 \
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

## Package Installation (pip)
RUN python3 -m pip install --no-cache-dir --upgrade pip \
    && python3 -m pip install --no-cache-dir flake8==3.7.8
