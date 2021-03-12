# *FLEA* – First Order Prover with Equality - Installation

Author: Alexander Maringele

_in development_

## Installation Overview

*FLEA* is written with Apple Swift, 
uses two third party sat solver libraries
and a parser library implemented by the author.

### Prerequesites

The following tools and libraries are used to build _FLEA_.

- [Git](https://git-scm.com) 2.24
- [Clang](http://clang.llvm.org)
- [Swift](https://swift.org) 5.3 (Compiler etc.)
- [Yices2](https://yices.csl.sri.com) 2.6.2 (SAT and SMT Solver)
- [Z3](https://github.com/Z3Prover/z3) 4.8.10 (SAT and SMT Solver)
- [pkc-config](https://www.freedesktop.org/wiki/Software/pkg-config/) 0.29.2 
  
See Readme-macOS.md and Readme-Ubuntu.md for installation hints.
Check if they are installed correctly.

```zsh
% git --version             # Git 2.24 or newer
% clang --version           # Clang 12.0 or newer
% swift --version           # Swift 5.3 or newer, clang 12 or newer
% yices --verison           # 2.6.2 or newer
% z3 --version              # 4.8.10 or newer
% pkg-config --version      # 0.92 or newer
% flex --version
% bison --version
```

### Thousand Problems for Theorem Provers

We use this collection of first order problems for testing and experimenting with *FLEA*.

- [The TPTP Library for Automated Theorem Proving](http://www.tptp.org) 

Download and unpack TPTP-v7.4.0.tz or newer.
Rename the unpacked folder into your home directory.

```zsh
% curl http://www.tptp.org/TPTP/Distribution/TPTP-v7.4.0.tgz --output TPTP-v7.4.0.tgz
% tar -xf TPTP-v7.4.0.tgz
% mv TPTP-v7.4.0 ~/TPTP
% rm TPTP-v7.4.0.tgz
% ls ~/TPTP/
Axioms          Documents       Generators      Problems        Scripts         TPTP2X
```

By default *FLEA* will search for files in the following order

- `~/TPTP/Axioms` `~/Downloads/TPTP/Axioms` (`*.ax` axiom files)
- `~/TPTP/Problems` `~/Downloads/TPTP/Problems` (`*.p` problem files)

### Installation of a basic tptp parsing Library

The simple [tptp parsing library](https://github.com/AleGit/CTptpParsing) 
-- written in C with Bison and Flex and provided by the author of *FLEA* -- 
can be installed easily on macOS or Ubuntu.

```zsh
% git clone https://github.com/AleGit/CTptpParsing.git
% cd CTptpParsing
% sudo make install
```

This will instal header and library files of the tptp parsing library.
Additionally these three pkg-config files `Yices.pc`, `Z3Api.py`, and `TptpParsing.pc` 
are copied into

```zsh
/usr/local/lib/pkgconfig    # macOS 11 (arm64,x86_64)
/usr/lib/pkgconfig          # Ubuntu Linux
```

such that pkg-config should find these config files.


### Check libraries 


* Check configuration

```zsh
% pkg-config Yices Z3Api TptpParsing --cflags --libs
# macOS arm64
-I/opt/homebrew/include -I/usr/local/include -L/opt/homebrew/lib -L/usr/local/lib 
# macOS 11 x86_64, Ubuntu Linux
-I/usr/local/include -L/usr/local/lib
```

* Expected configuration files

```zsh
# macOS arm64 + x86_64
/usr/local/lib/pkgconfig/Yices.pc
/usr/local/lib/pkgconfig/Z3API.pc 
/usr/local/lib/pkgconfig/TptpParsing.pc 

# Ubuntu Linux
/usr/lib/pkgconfig/Yices.pc 
/usr/lib/pkgconfig/Z3API.pc
/usr/lib/pkgconfig/TptpParsing.pc
```

The pkg-config must yield correct paths to header and library directories 
of Yices2, Z3, and tptp parsing. 

### Required header files

```zsh
# Yices
yices.h             
yices_limits.h      
yices_types.h       
yices_exit_codes.h 

# Z3API
z3_rcf.h
z3_macros.h
z3_polynomial.h
z3++.h
z3_algebraic.h
z3_fpa.h
z3_optimization.h
z3.h
z3_ast_containers.h
z3_v1.h
z3_api.h
z3_version.h
z3_fixedpoint.h
z3_spacer.h

# TptpParsing
PrlcMacros.h     
PrlcData.h
PrlcCore.h
PrlcParser.h
```

* Required library files

```zsh
# Yices 2
libyices.a                 # macOS 11 
libyices.dylib             # macOS 11
libyices.2.dylib           # macOS 11
libyices.so                # Ubunto Linux

# Z3
libz3.a                # macOS (static)
libz3.dylib           # macOS only

# TptpParsing
libTptpParsing.dylib           # macOS 12 (arm64 and x86_64)
libTptpParsing.a               # TODO: Ubuntu Linux
```

### Download, run and test *FLEA*.

```zsh
% git clone https://github.com/AleGit/FLEA5.git
Cloning into FLEA5 ...
% cd FLEA5
% git checkout develop
% swift run
FLEA - First order Logic with Equality Attester (FLEA)
...
% swift test
...
Executed ... tests, with 0 failures (0 unexpected) in ... (...) seconds.
```

