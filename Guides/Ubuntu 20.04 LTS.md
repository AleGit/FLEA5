# Install Guide for Ubuntu 20.04 LTS
 
Build and run FLEA5 with Ubuntu 20.04 LTS.

## Install toolchain

We will download, extract and install the following tools:

- swift-5.2.4-RELEASE-ubuntu20.04.tar.gz
- yices-2.6.2-x86_64-pc-linux-gnu-static-gmp.tar.gz
- z3-4.8.8-x64-ubuntu-16.04.zip

### Swift 5.3 RELEASE

- Install requirements for Swift, see 
  [swift.org/download/#using-downloads](https://swift.org/download/#using-downloads)
  in the Linux section.

```
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
        
$ wget -q -O - https://swift.org/keys/all-keys.asc | gpg --import -
$ gpg --keyserver hkp://pool.sks-keyservers.net --refresh-keys Swift
```

- Download, extract and install Swift 5.3 RELEASE from 
  [swift.org/download/#releases](https://swift.org/download/#releases)

```
$ curl -L https://swift.org/builds/swift-5.3-release/ubuntu2004/swift-5.3-RELEASE/swift-5.3-RELEASE-ubuntu20.04.tar.gz --output swift.tgz
$ curl -L https://swift.org/builds/swift-5.3-release/ubuntu2004/swift-5.3-RELEASE/swift-5.3-RELEASE-ubuntu20.04.tar.gz.sig --output swift.tgz.sig
$ tar -xf swift.tgz
$ gpg --verify swift.tgz.sig
$ tar xzf swift.tgz
$ rm -rf ~/swift
$ mkdir -p ~/swift
$ mv swift-5.3-RELEASE-ubuntu20.04/usr ~/swift/ 
$ export PATH=~/swift/usr/bin:"${PATH}"
$ swift --version
Swift version 5.3 (swift-5.3-RELEASE)
Target: x86_64-unknown-linux-gnu
```

### Yices 2.6.2

- Install Yices 2.6.2 (recommended)

```
$ sudo add-apt-repository ppa:sri-csl/formal-methods
$ sudo apt-get update
$ sudo apt-get install yices2
$ yices --version
Yices 2.6.2
```

- or download, extract and install Yices 2.6.2 from 
  [yices.csl.sri.com](https://yices.csl.sri.com/)

```
$ curl https://yices.csl.sri.com/releases/2.6.2/yices-2.6.2-x86_64-pc-linux-gnu-static-gmp.tar.gz --output yices.tgz
$ tar -xf yices.tgz
$ cd yices-2.6.2
$ sudo ./install-yices
$ yices --version
Yices 2.6.2
Copyright SRI International.
Linked with GMP 6.1.2
Copyright Free Software Foundation, Inc.
Build date: 2020-04-13
Platform: x86_64-pc-linux-gnu (release/static)

/usr/local/include/yices_exit_codes.h
/usr/local/include/yices.h
/usr/local/include/yices_limits.h
/usr/local/include/yices_types.h
/usr/local/bin/yices-smt
/usr/local/bin/yices-smt2
/usr/local/bin/yices-sat
/usr/local/bin/yices
/usr/local/lib/libyices.so
/usr/local/lib/libyices.so.2.6
/usr/local/lib/libyices.so.2.6.2
```

### Z3 4.8.9

- Download, extract, and install Z3 4.8.9 
  from [github.com/Z3Prover](https://github.com/Z3Prover/z3/releases/tag/z3-4.8.9)

```
$ curl -L https://github.com/Z3Prover/z3/releases/download/z3-4.8.9/z3-4.8.9-x64-ubuntu-16.04.zip --output z3.zip
$ unzip z3.zip 
$ cd ./z3-4.8.8-x64-ubuntu-16.04
$ sudo cp ./bin/libz3* /usr/local/lib
$ sudo cp ./bin/z3* /usr/local/bin
$ sudo cp ./include/*.h /usr/local/include
$ z3 --version
Z3 version 4.8.9 - 64 bit

/usr/local/include/z3_fixedpoint.h
/usr/local/include/z3_rcf.h
/usr/local/include/z3_fpa.h
/usr/local/include/z3.h
/usr/local/include/z3_api.h
/usr/local/include/z3_spacer.h
/usr/local/include/z3_algebraic.h
/usr/local/include/z3_v1.h
/usr/local/include/z3_ast_containers.h
/usr/local/include/z3++.h
/usr/local/include/z3_version.h
/usr/local/include/z3_optimization.h
/usr/local/include/z3_polynomial.h
/usr/local/include/z3_macros.h
/usr/local/bin/z3
/usr/local/lib/libz3java.so
/usr/local/lib/libz3.a
/usr/local/lib/libz3.so
```

## Build FLEA5

### C Tptp Parsing library

```
$ sudo apt-get install make bison flex clang  
$ git clone https://github.com/AleGit/CTptpParsing.git
$ cd CTptpParsing
$ sudo make install
```

### Build, run, and test FLEA5

```
$ git clone https://github.com/AleGit/FLEA5.git
$ cd FLEA5
$ swift test
```

