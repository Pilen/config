FROM python:3.11

RUN \
    apt-get update &&\
    apt-get -y install sudo less jq iputils-ping ssh &&\
    groupadd --gid 1000 spi &&\
    useradd --uid 1000 --gid 1000 --group sudo --create-home --shell /bin/bash spi &&\
    echo '%spi ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers &&\
    sudo -u spi pip install ipython mypy pytest pytest-cov openpyxl requests pymongo && \
    echo ""\
    apt-get update &&\
    apt-get install -y ca-certificates curl gnupg lsb-release &&\
    mkdir -m 0755 -p /etc/apt/keyrings &&\
    curl -fsSL https://download.docker.com/linux/debian/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg &&\
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null &&\
    apt-get update &&\
    apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin &&\
    touch /var/run/docker.sock &&\
    chmod o+rw /var/run/docker.sock &&\
    echo ""

USER spi:spi
COPY remoteconfig /home/spi/remoteconfig
ENV REMOTE_CONFIG_DIR="/home/spi/remoteconfig"
RUN \
    echo 'source $REMOTE_CONFIG_DIR/bashrc' > /home/spi/.bashrc &&\
    echo 'export HISTFILE="/home/spi/persistent/history/spidev"' >> /home/spi/.bashrc &&\
    echo 'export PATH="/home/spi/.local/bin:$PATH"' >> /home/spi/.bashrc && \
    echo 'export HISTFILESIZE=' >> /home/spi/.bashrc && \
    echo 'export HISTSIZE=' >> /home/spi/.bashrc && \
    # curl https://sh.rustup.rs -sSf | bash -s -- -y && \
    # echo 'source $HOME/.cargo/env' >> /home/spi/.bashrc && \
    echo ""


CMD ["bash"]
