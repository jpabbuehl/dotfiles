#!/bin/bash
cp /tmp/welcome.txt /etc/motd
set -x
# set -euxo pipefail

# Important
service unattended-upgrades stop
service mask unattended-upgrades
service apt-daily-upgrade.timer stop
echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections

# Profile for all users
touch /etc/profile.d/user.sh
export profile_user='/etc/profile.d/user.sh'
echo '#!/bin/bash' >> $profile_user

# Configure local
apt update && apt install -y locales
sed -i 's/^# *\(en_US.UTF-8\)/\1/' /etc/locale.gen
locale-gen
echo "export LC_ALL=en_US.UTF-8" >> $profile_user
echo "export LANG=en_US.UTF-8" >> $profile_user
echo "export LANGUAGE=en_US.UTF-8" >> $profile_user

# Install X11 Requirement
echo "Packages installation."
apt update && apt install -y -q \
  apt-utils \
  apt-transport-https \
  atop \
  build-essential \
  chromium \
  curl \
  gcc \
  gdebi-core \
  gedit \
  git \
  git-lfs \
  htop \
  jq \
  lib32gcc1 \
  lib32stdc++6 \
  libasound2 \
  libbz2-dev \
  libc6-i386 \
  libclang-7-dev \
  libclang-common-7-dev \
  libclang-dev \
  libclang1-7 \
  libcurl4-openssl-dev \
  libdbi1 \
  libegl1-mesa \
  libffi-dev \
  libgc1c2 \
  libgl1-mesa-glx \
  liblzma-dev \
  libncurses5-dev \
  libncursesw5-dev \
  libobjc-8-dev \
  libobjc4 \
  libpq-dev \
  libreadline-dev \
  libsqlite3-dev \
  libssh2-1-dev \
  libssl-dev \
  libxcb-xkb1 \
  libxcomposite1 \
  libxcursor1 \
  libxi6 \
  libxkbcommon-x11-0 \
  libxml2-dev \
  libxrandr2 \
  libxss1 \
  libxtst6 \
  llvm \
  make \
  procps \
  python-openssl \
  python3-pip \
  software-properties-common \
  terminator \
  tk-dev \
  tldr \
  tmux \
  vim \
  wget \
  xfce4 \
  xrdp \
  xz-utils \
  zip \
  zlib1g-dev

# Update to AWS cli v2
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip -qq awscliv2.zip
./aws/install
rm -rf aws
rm awscliv2.zip

# Install Docker
curl -sSL https://get.docker.com/ | sh
service docker stop
mkdir /etc/docker
touch /etc/docker/daemon.json
echo "{ \"features\": { \"buildkit\": true } }" | tee /etc/docker/daemon.json
service docker start

# Install Docker-compose
curl -L "https://github.com/docker/compose/releases/download/1.27.4/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose

# Pull Docker default image
docker pull debian:10.3-slim
docker pull debian:10.3
docker pull postgres:11

# Install Postgres
echo "deb http://apt.postgresql.org/pub/repos/apt $(lsb_release -cs)-pgdg main" | tee /etc/apt/sources.list.d/pgdg.list
wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add -
apt update && apt install -y -q \
  postgresql-client-common \
  postgresql-client-12

# Install linux Tools
wget --quiet https://github.com/jmespath/jp/releases/download/0.1.2/jp-linux-amd64 -O /usr/local/bin/jp
chmod +x /usr/local/bin/jp

# Install R
R_BASE_VERSION=3.6.3
echo 'deb http://cloud.r-project.org/bin/linux/debian buster-cran35/' | tee /etc/apt/sources.list.d/backports.list
apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-key 'E19F5F87128899B192B1A2C2AD5F960A256A04AF'
apt update && apt install -y -q \
  littler \
  r-cran-littler \
  r-base=${R_BASE_VERSION}-* \
  r-base-dev=${R_BASE_VERSION}-* \
  r-recommended=${R_BASE_VERSION}-* && \
  ln -s /usr/lib/R/site-library/littler/examples/install.r /usr/local/bin/install.r && \
  ln -s /usr/lib/R/site-library/littler/examples/install2.r /usr/local/bin/install2.r && \
  ln -s /usr/lib/R/site-library/littler/examples/installGithub.r /usr/local/bin/installGithub.r && \
  ln -s /usr/lib/R/site-library/littler/examples/testInstalled.r /usr/local/bin/testInstalled.r && \
  install.r docopt

# Install R Studio Server
wget --quiet https://download2.rstudio.org/server/bionic/amd64/rstudio-server-1.3.959-amd64.deb -O rstudio-server.deb
gdebi -n rstudio-server.deb
rm rstudio-server.deb

# Install R Studio
wget --quiet https://download1.rstudio.org/desktop/bionic/amd64/rstudio-1.3.1093-amd64.deb -O rstudio.deb
gdebi -n rstudio.deb
rm rstudio.deb

# Install VSC
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
install -o root -g root -m 644 packages.microsoft.gpg /etc/apt/trusted.gpg.d/
echo "deb [arch=amd64 signed-by=/etc/apt/trusted.gpg.d/packages.microsoft.gpg] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list
apt update && apt install -y -q code
rm packages.microsoft.gpg

# Install Anaconda
wget --quiet https://repo.anaconda.com/archive/Anaconda3-5.3.1-Linux-x86_64.sh -O anaconda_install.sh
sh anaconda_install.sh -b -p /opt/anaconda3
rm anaconda_install.sh
chgrp -R developer /opt/anaconda3
chmod 770 -R /opt/anaconda3
echo "export PATH=$PATH:/opt/anaconda3/bin/" >> $profile_user

# Install Jupyter
echo "alias pip='pip3'" >> $profile_user
pip3 install jupyterlab

# Install Node.js
curl -sL https://deb.nodesource.com/setup_15.x | bash -
apt-get install -y nodejs

# Install linuxHomebew
mkdir -p /home/homebrew && curl -L https://github.com/Homebrew/brew/tarball/master | tar xz --strip 1 -C /home/homebrew
chown :brew -R /home/homebrew
chmod 774 -R /home/homebrew
mkdir -p .linuxbrew/bin
ln -s /home/homebrew/bin/brew .linuxbrew/bin
echo "export PATH=$PATH:/home/homebrew/bin/" >> $profile_user
echo "eval /homebrew/bin/brew shellenv" >> $profile_user

# Post installation configuration
git config --global push.default current
git config --global core.editor "vim"
# eof
