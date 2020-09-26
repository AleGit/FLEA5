# Install guide for macOS 10.15

Build and run FLEA5 with macOS 10.15.

## Install toolchain

### Xcode 12

Install it from the mac app store or download it from [developer.apple.com](https://developer.apple.com). 
In both cases you have to register with a free Apple-ID, i.e. a (disposable) e-mail address of yours.

```
xcode-select --install
``

### Yices 2.6.2 Library

See [yices.csl.sri.com](https://yices.csl.sri.com)

```
$ brew install SRI-CSL/sri-csl/yices2
$ yices --version
Yices 2.6.2
```

### Z3 4.8.9 Library

See (github.com/Z3Prover/)[https://github.com/Z3Prover/]

```
$ brew install z3
z3 --version
Z3 version 4.8.9 - 64 bit
```

## Build FLEA5

### C Tptp Parsing library

```
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

