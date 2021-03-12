# *FLEA* tools and libraries installation hints

## Ubuntu 20.04 Linux

### Install general tools

* Install dependencies

```bash
# install required dependencies
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

# install build tools to the parsing library
% sudo apt install clang make bison flex
```

* Install [Apple Swift](https://swift.org/download/ )

Follow the instructions on https://swift.org/download/#linux

```bash
# Hint: Use `sudo` in front of the commands.
# Put swift directory into path.

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


