
https://wiki.debian.org/NvidiaGraphicsDrivers#Debian_12_.22Bookworm.22
comment out cdrom line in /etc/apt/sources.list
reboot

wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg > sublimehq-pub.gpg
gpg --no-default-keyring --keyring ./temp-keyring.gpg --import ./sublimehq-pub.gpg
gpg --no-default-keyring --keyring ./temp-keyring.gpg --export --output sublimehq-pub.gpg
rm temp-keyring.gpg
sudo mv sublimehq-pub.gpg /etc/apt/trusted.gpg.d/
echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list 

apt install git apt-transport-https sublime-text zsh

sh -c "$(wget https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O -)"
chsh -s $(which zsh) <username>

wget "https://discord.com/api/download?platform=linux&format=deb" -O /tmp/discord.deb

apt install /tmp/discord.deb

wget https://zoom.us/client/5.15.0.4063/zoom_amd64.deb -O /tmp/zoom_amd64.deb
apt install /tmp/zoom_amd64.deb

wget https://go.microsoft.com/fwlink/?LinkID=760868 -O /tmp/vscode.deb
apt install /tmp/vscode.deb

apt install -y make build-essential libssl-dev zlib1g-dev libbz2-dev \
libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev libncursesw5-dev \
xz-utils tk-dev libffi-dev liblzma-dev

NON-ROOT $ curl -L https://raw.githubusercontent.com/pyenv/pyenv-installer/master/bin/pyenv-installer | bash

add to end of .zshrc
export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
# needed? eval "$(pyenv virtualenv-init -)"

reboot

wget https://developer.download.nvidia.com/compute/cuda/12.1.1/local_installers/cuda_12.1.1_530.30.02_linux.run
sudo sh cuda_12.1.1_530.30.02_linux.run --toolkit --silent --override --toolkitpath=/opt/cuda-12.1.1