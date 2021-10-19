TEMP_DEB="$(mktemp)"



sh build-gst.sh
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
source $HOME/.cargo/env

cd /vagrant
cargo build --release -p gst-meet
