
rsync --human-readable --progress --recursive --copy-links ~/config/remoteconfig ./
docker build --file dev.dockerfile --tag spidev .
rm -rf remoteconfig
