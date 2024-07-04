set -ex
export INSTALL_SCRIPTS_DIR=/notebooks/installation
killall rsync || true
cp "${INSTALL_SCRIPTS_DIR}/patches/etc/rsyncd.conf" /etc/rsyncd.conf
rsync --daemon
ssh -R j4gx3tqbipzssgfsag:8873:localhost:873 serveo.net
# on your machine run:
# ssh -L 8873:j4gx3tqbipzssgfsag:8873 serveo.net
# rsync --human-readable --stats --progress -a Eureka/* rsync://localhost:8873/Eureka/
