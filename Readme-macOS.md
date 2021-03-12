# *FLEA* tools and libraries installation hints

## macOS 11 (arm64, x86_64)

### Install general tools

* Install Xcode developer tools

Install Xcode from [Apple Developer](https://developer.apple.com/xcode/) or [Mac App Store](https://apps.apple.com/app/xcode/id497799835?mt=12) 

```zsh
# The xcode command line tools may be necessary and sufficient
% xcode-select install
```

- Install [Homebrew](https://brew.sh), i.e. the missing package manager for macOS.


### Install [Yices2](https://yices.csl.sri.com)

* Install with homebrew package manager

```zsh
% brew install SRI-CSL/sri-csl/yices2 
% yices --version
Yices 2.6.1
Copyright SRI International.
Linked with GMP 6.1.2
Copyright Free Software Foundation, Inc.
Build date: 2019-09-01
Platform: x86_64-apple-darwin18.7.0 (release)
```

* Build form source code or download and install binaries.

See [https://yices.csl.sri.com](https://yices.csl.sri.com) for instructions.


### Install [Z3](https://github.com/Z3Prover/z3/wiki)

* Install with homebrew package manager

```zsh
% brew install z3
% Z3 --version
Z3 version 4.8.10 - 64 bit
```

* Build from source or download and install binaries

See [Z3](https://github.com/Z3Prover/z3) for instructions.

- [Source Code](https://github.com/Z3Prover/z3)

- [Releases](https://github.com/Z3Prover/z3/releases)




