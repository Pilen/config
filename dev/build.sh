
rsync --human-readable --progress --recursive --copy-links /home/spi/config/remoteconfig ./
docker build --file dev.dockerfile --tag spidev .
rm -rf remoteconfig
