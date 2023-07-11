1. First, follow the instructions on the [Debian Wiki](https://wiki.debian.org/NvidiaGraphicsDrivers#Debian_12_.22Bookworm.22) for installing Nvidia drivers.

2. Comment out the `cdrom` line in `/etc/apt/sources.list`:

    ```bash
    sudo vi /etc/apt/sources.list
    ```

    And then reboot your system:

    ```bash
    sudo reboot
    ```

3. Add the Sublime Text GPG key and repository:

    ```bash
    wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg > sublimehq-pub.gpg
    gpg --no-default-keyring --keyring ./temp-keyring.gpg --import ./sublimehq-pub.gpg
    gpg --no-default-keyring --keyring ./temp-keyring.gpg --export --output sublimehq-pub.gpg
    rm temp-keyring.gpg
    sudo mv sublimehq-pub.gpg /etc/apt/trusted.gpg.d/
    echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list 
    ```

4. Install git, apt-transport-https (needed for https repositories), Sublime Text, and Zsh:

    ```bash
    sudo apt install git apt-transport-https sublime-text zsh rsync zip obs-studio
    ```

5. Install Oh My Zsh and change your default shell to Zsh (replace `<username>` with your username):

    ```bash
    sh -c "$(wget https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O -)"
    chsh -s $(which zsh) <username>
    ```

6. Download and install Discord:

    ```bash
    wget "https://discord.com/api/download?platform=linux&format=deb" -O /tmp/discord.deb
    sudo apt install /tmp/discord.deb
    ```

7. Download and install Zoom:

    ```bash
    wget https://zoom.us/client/5.15.0.4063/zoom_amd64.deb -O /tmp/zoom_amd64.deb
    sudo apt install /tmp/zoom_amd64.deb
    ```

8. Download and install Visual Studio Code:

    ```bash
    wget https://go.microsoft.com/fwlink/?LinkID=760868 -O /tmp/vscode.deb
    sudo apt install /tmp/vscode.deb
    ```

9. Install development libraries:

    ```bash
    sudo apt install -y make build-essential libssl-dev zlib1g-dev libbz2-dev \
    libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev libncursesw5-dev \
    xz-utils tk-dev libffi-dev liblzma-dev ca-certificates curl gnupg2 software-properties-common
    ```

10. Install Pyenv (non-root command):

    ```bash
    curl -L https://raw.githubusercontent.com/pyenv/pyenv-installer/master/bin/pyenv-installer | bash
    ```

11. Add the following to the end of `.zshrc` (replace `<username>` with your username):

    ```bash
    echo 'export PYENV_ROOT="$HOME/.pyenv"' | sudo tee -a /home/<username>/.zshrc
    echo 'command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"' | sudo tee -a /home/<username>/.zshrc
    echo 'eval "$(pyenv init -)"' | sudo tee -a /home/<username>/.zshrc
    ```

    And then reboot your system:

    ```bash
    sudo reboot
    ```

12. Download and install CUDA toolkit:

    ```bash
    wget https://developer.download.nvidia.com/compute/cuda/12.1.1/local_installers/cuda_12.1.1_530.30.02_linux.run
    sudo sh cuda_12.1.1_530.30.02_linux.run --toolkit --silent --override --toolkitpath=/opt/cuda-12.1.1
    ```

13. Install and setup [ZFS](zfs_setup.md)

Remember to replace `<username>` with your actual username.

14. Install Docker CE
Prereqs installed before

Install gpg key and add repository

```zsh
curl -fsSL https://download.docker.com/linux/debian/gpg | gpg --dearmor -o /tmp/docker.gpg
sudo mv /tmp/docker.gpg /etc/apt/trusted.gpg.d/

sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/debian $(lsb_release -cs) stable"
```

Update package list and install

```zsh
sudo apt update
sudo apt install docker-ce

#check with hello-world
sudo docker run hello-world
```
setup mysql

```zsh
docker pull mysql:latest
docker run --name mysql_container -v /path/to/db/storage:/var/lib/mysql -e MYSQL_ROOT_PASSWORD=your_password -p 3306:3306 -d mysql:latest
```

Copy and run sql scripts in container

```zsh
docker cp /path/to/your/script.sql mysql_container:/script.sql
docker exec -it mysql_container /bin/bash -c "mysql -uroot -p'your_password' <db_name> < /script.sql"

```
connect to the db
```zsh
docker exec -it mysql_container /bin/bash -c "mysql -uroot -p'your_password' <db_name> "
```