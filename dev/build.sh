
rsync --human-readable --progress --recursive --copy-links ~/config/remoteconfig ./
# docker build --file dev.dockerfile --tag spidev .
# docker build --file dev.dockerfile --tag spidev:3.13 .
# docker build --file dev.dockerfile --tag spidevold .


# docker build --file udev.dockerfile --tag spiudev:3.13 .
docker build --progress=plain --no-cache --file udev.dockerfile --tag spiudev:3.13 .

rm -rf remoteconfig
