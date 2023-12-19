
rsync --human-readable --progress --recursive --copy-links /home/spi/config/remoteconfig ./
# docker build --file dev.dockerfile --tag spidev .
docker build --file dev.dockerfile --tag spidev-3.11 .
# docker build --file dev.dockerfile --tag spidevold .
rm -rf remoteconfig
