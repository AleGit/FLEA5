Ubuntu 20.4 LTS

```zsh
# install git version contorl
% sudo apt install git
% git --version
git version 2.25.1

# install clang (includes pkg-config)
$ sudo apt install clang
$ clang --version; echo; pkg-config --version
clang verison 10.0.0-4ubuntu1
Target: x86_64-pc-linux-gnu
Thread model: posix
InstalledDir: /usr/bin

0.29.1

# Install Apple Swift 5.3.x Prequisites

$ sudo apt-get install \
          binutils \
          git \
          gnupg2 \
          libc6-dev \
          libcurl4 \
          libedit2 \
          libgcc-9-dev \
          libpython2.7 \
          libsqlite3-0 \
          libstdc++-9-dev \
          libxml2 \
          libz3-dev \
          pkg-config \
          tzdata \
          zlib1g-dev

sudo apt install make bison flex

# Download Swift from https://swift.org/download/ 
# and follow the instructions on https://swift.org/download/#linux
# Hint: Use `sudo` in front of the commands.
# Put director into path.

$ swift --version
Swift version 5.3.2 (swift-5.3.2-RELEASE)
Target: x86_64-unkonwn-linux.gnu

# Intall Z4 Prover
# Download z3 4.8.8.9 from https://githumb/Z3Prover/releases




# Download and extract
# yices-2.6.2-x86_64-pc-linux-gnu-static-gmp.tar.gz
# to folder
# yices-2.6.2

% cd yices-2.6.2
% sudo ./install-yices
Installing Yices in /usr/local

find /usr/local -iname "*yices*"





```
