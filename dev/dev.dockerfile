from python:3.8

run \
    apt-get update &&\
    apt-get -y install sudo less jq iputils-ping &&\
    groupadd --gid 1000 spi &&\
    useradd --uid 1000 --gid 1000 --group sudo --create-home --shell /bin/bash spi &&\
    echo '%spi ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers &&\
    echo 'export PATH="/home/spi/.local/bin:$PATH"' >> /home/spi/.bashrc &&\
    sudo -u spi pip install ipython mypy pytest pytest-cov openpyxl requests pymongo && \
    echo ""

user spi:spi
copy remoteconfig /home/spi/remoteconfig
ENV REMOTE_CONFIG_DIR="/home/spi/remoteconfig"
run \
    echo 'source $REMOTE_CONFIG_DIR/bashrc' > /home/spi/.bashrc &&\
    echo 'export HISTFILE="/home/spi/persistent/history/spidev"' >> /home/spi/.bashrc &&\
    echo 'export PATH="/home/spi/.local/bin:$PATH"' >> /home/spi/.bashrc


CMD ["bash"]
