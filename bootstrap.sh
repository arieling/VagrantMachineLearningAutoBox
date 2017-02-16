#!/usr/bin/env bash

echo 'Update packages list...'
echo "------------------------"
apt-get -y update

echo 'Install Xubuntu Desktop & co...'
echo "------------------------"
export DEBIAN_FRONTEND=noninteractive
apt-get -y --force-yes --no-install-recommends install xubuntu-desktop mousepad xubuntu-icon-theme \
xfce4-goodies xubuntu-wallpapers gksu cifs-utils xfce4-whiskermenu-plugin firefox \
xarchiver filezilla synaptic curl vim wget

echo 'Install VB addon and x11 display'
sudo apt-get -y --force-yes --no-install-recommends install virtualbox-guest-utils virtualbox-guest-x11 virtualbox-guest-dkms

echo 'Set New York timezone...'
echo "------------------------"
echo "America/New_York" | sudo tee /etc/timezone
sudo dpkg-reconfigure --frontend noninteractive tzdata

echo 'Set English keyboard layout...'
echo "------------------------"
sudo sed -i 's/XKBLAYOUT="us"/g' /etc/default/keyboard

echo 'Install Chrome...'
echo "------------------------"
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb -P /tmp
sudo dpkg -i /tmp/google-chrome*
sudo apt-get -f install -y
rm /tmp/google*chrome*.deb

echo 'Install JDK 8 in /usr/lib/jvm/java-8-oracle...'
echo "------------------------"
sudo add-apt-repository ppa:webupd8team/java -y
sudo apt-get update -y
sudo echo debconf shared/accepted-oracle-license-v1-1 select true | sudo debconf-set-selections
sudo echo debconf shared/accepted-oracle-license-v1-1 seen true | sudo debconf-set-selections
sudo apt-get install -y oracle-jdk8-installer -y
sudo apt-get install oracle-java8-set-default -y
export JAVA_HOME=/usr/lib/jvm/java-8-oracle/
export PATH=$JAVA_HOME/bin:$PATH

echo 'Create Development directory...'
echo "------------------------"
mkdir /home/vagrant/Development
mkdir /home/vagrant/Development/git
sudo chmod 777 -R /home/vagrant/Development/

echo 'Install Git and create local repository directory'
echo "------------------------"
sudo apt-get install git -y

echo 'Install Git Flow...'
echo "------------------------"
wget -q – http://github.com/nvie/gitflow/raw/develop/contrib/gitflow-installer.sh –no-check-certificate -P /tmp
sudo chmod a+x /tmp/gitflow-installer.sh
sudo sh /tmp/gitflow-installer.sh

echo 'Install Oh My Zsh'
echo "------------------------"
sudo apt-get install zsh -y
touch /home/vagrant/.zshrc
# wget --no-check-certificate https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | sh
# sh -c "$(wget --no-check-certificate https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
sudo chsh -s /bin/zsh vagrant
sudo zsh
sudo chown vagrant:vagrant /home/vagrant/.zshrc
sudo chown -R vagrant:vagrant /home/vagrant/.oh-my-zsh

# Change the oh my zsh default theme.
mkdir /home/vagrant/workspace
sudo chown -R vagrant:vagrant /home/vagrant/workspace
sudo sed -i 's/ZSH_THEME="robbyrussell"/ZSH_THEME="agnoster"/g' ~/.zshrc
sudo sed -i 's/plugins=(git)/plugins=(git ruby rails bower bundler docker gem git-extras mvn npm python redis-cli)/g' ~/.zshrc
git clone https://github.com/powerline/fonts.git /home/vagrant/workspace/powerline
sh /home/vagrant/workspace/powerline/install.sh
rm -rf /home/vagrant/workspace/powerline

#Install Python Anaconda
echo 'Installing Anaconda 2-4.0.0'

wget -q https://repo.continuum.io/archive/Anaconda2-4.0.0-Linux-x86_64.sh -P /tmp
cd /tmp
bash Anaconda2-4.0.0-Linux-x86_64.sh -b -p /home/vagrant/anaconda
echo 'export PATH="/home/vagrant/anaconda/bin:$PATH"' >> /home/vagrant/.bashrc

echo 'Create VM'
export PATH="/home/vagrant/anaconda/bin:$PATH"
echo $PATH
bash 
conda create -n tensorflow python=2.7
echo 'Activate VM'
source activate tensorflow
pip install --ignore-installed --upgrade https://storage.googleapis.com/tensorflow/linux/cpu/tensorflow-1.0.0-cp27-none-linux_x86_64.whl
