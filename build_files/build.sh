#!/bin/bash

set -euxo pipefail

# arch deckify
echo "ALL ALL=(ALL) NOPASSWD: /usr/bin/sed -i s/^Session=*/Session=*/ /etc/sddm.conf" | sudo tee "/etc/sudoers.d/session_override.conf" > /dev/null

sed -i "s/#Session=/Session=plasma/g" /etc/sddm.conf
cat /etc/sddm.conf

dnf install -y steam gamescope mangohud
cd /tmp
git clone https://github.com/shahnawazshahin/steam-using-gamescope-guide
cd steam-using-gamescope-guide/usr

for f in $(ls ./bin); do
    cp -r ./bin/$f /usr/bin/$f
done

plasma-apply-wallpaperimage

cp ./share/wayland-sessions/steam.desktop /usr/share/wayland-sessions/steam.desktop

rsync -rvK /ctx/sys/ /

cd /tmp

systemctl enable podman.socket
systemctl enable deckify-init
