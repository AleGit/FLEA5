# *FLEA* tools and libraries installation hints for macOS (Intel or Apple Silicon)


1. Install general tools

1.1. Install Xcode developer tools

Install Xcode from [Apple Developer](https://developer.apple.com/xcode/) or [Mac App Store](https://apps.apple.com/app/xcode/id497799835?mt=12) 

```zsh
# The xcode command line tools may be necessary and sufficient
% xcode-select install
```

1.2 Install [Homebrew](https://brew.sh), i.e. the missing package manager for macOS.


2. Install [Yices22](https://yices.csl.sri.com)

2.1. Install with homebrew package manager

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

2.2. Build form source code or download and install binaries.

See [https://yices.csl.sri.com](https://yices.csl.sri.com) for instructions.


3. Install [Z3](https://github.com/Z3Prover/z3/wiki)

3.1. Install with homebrew package manager

```zsh
% brew install z3
% Z3 --version
Z3 version 4.8.10 - 64 bit
```

3.2. Build from source or download and install binaries

See [Z3](https://github.com/Z3Prover/z3) for instructions.

- [Source Code](https://github.com/Z3Prover/z3)

- [Releases](https://github.com/Z3Prover/z3/releases)




