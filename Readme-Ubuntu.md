# *FLEA* tools and libraries installation hints for Ubuntu Linux

1. Install general tools

1.1. Install developer tools

- git version control

```bash
% sudo apt install git
% git --version
git version 2.25.1

- Install clang and pkg-config

% sudo apt install clang
% clang --version; 
% pkg-config --version
```

- install Apple Swift 5.3.x Prequisites

```bash
% sudo apt install \
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

- install build tools for the parsing library
% sudo apt install \
          make \
          bison \
          flex
```

1.2 Install Apple Swift

```bash
# Download Swift from https://swift.org/download/ 
# and follow the instructions on https://swift.org/download/#linux
# Hint: Use `sudo` in front of the commands.
# Put director into path.

$ swift --version
Swift version 5.3.2 (swift-5.3.2-RELEASE)
Target: x86_64-unkonwn-linux.gnu
```

2. Install [Yices2](http://yices.csl.sri.com)

2.1. Install with package manager

```bash
% sudo add-apt-repository ppa:sri-csl/formal-methods
% sudo apt-get update
% sudo apt-get install yices2
% yices --version                   # TODO: Ubuntu Linux

2.2. Build form source code or download and install binaries.

See [https://yices.csl.sri.com](https://yices.csl.sri.com) for instructions.


3. Install [Z3](https://github.com/Z3Prover/z3/wiki)

3.1. Install with package manager

3.2. Build from source or download and install binaries

See [Z3](https://github.com/Z3Prover/z3) for instructions.

- [Source Code](https://github.com/Z3Prover/z3)

- [Releases](https://github.com/Z3Prover/z3/releases)


