TEMP_DEB="$(mktemp)"



sudo sh /vagrant/build-gst.sh
sudo curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs > rust.sh
sudo sh rust.sh -y
sudo source $HOME/.cargo/env

cd /vagrant
sudo su
cargo build --release -p gst-meet
