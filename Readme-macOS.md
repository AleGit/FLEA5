# FLEA5 – First Order Prover with Equality

_sitll in development_



1.1.2 macOS 11, BigSur on Intel

```zsh
% swift --version
% git --version
```

1.1.3 Chcek on Ubuntu

```zsh
% swift --version
% git --version
```

1.2 Tptp Parsing Library

The tptp parsing library can easily be build and installed.

```zsh
# Ubuntu Linux and macOS
% git clone https://github.com/AleGit/CTptpParsing.git
% cd CTptpParsing
% sudo make install

% find /usr -name "Prlc*h"          # TODO: Ubuntu Linux
% find /usr/local -name "Prlc*h"    # macOS 11 on Intel or ARM
/path/to/include/PrlcMacros.h     
/path/to/include/PrlcData.h
/path/to/include/PrlcCore.h
/path/to/include/PrlcParser.h

% find /usr -name "*TptpParsing*"           # TODO: Ubuntu Linux
% find /usr/local -name "*TptpParsing*"     # macOS 11 on Intel or ARM
/path/to/lib/pkgconfig/TptpParsing.pc       # macOS 12 (ARM and Intel)
/path/to/lib/libTptpParsing.dylib           # macOS 12 (ARM and Intel)
/path/to/lib/libTptpParsing.a               # TODO: Ubuntu Linux
```

After installation 8`sudo make install`) the pkg-config command should yield the following paths for the parsing library.

```zsh
% pkg-config tptpparsing --cflags --libs
-I/usr/local/include -L/usr/local/lib   # macOS 11 (ARM or Intel)
-I/usr/include -L/usr/lib               # Ubuntu (TODO: CHECK)
```


1.3 SMT Solver Libraries

Exectuting the following commands

```zsh
% pkg-config yices --libs --cflags
% pkg-config z3api --libs --cflags
```

must yield equal or distinct
`-I/path/to/include -L/path/to/lib`
such that header files and libraries are found.

1.1.1 Install [Yices](http://yices.csl.sri.com) on macOS 11

See [Homebrew](https://brew.sh) for the missing package manager for macOS.

```zsh
$ brew install SRI-CSL/sri-csl/yices2 
$ yices --version
Yices 2.6.1
Copyright SRI International.
Linked with GMP 6.1.2
Copyright Free Software Foundation, Inc.
Build date: 2019-09-01
Platform: x86_64-apple-darwin18.7.0 (release)
```

1.1.3 Install [Yices](http://yices.csl.sri.com) on Ubuntu Linux

```zsh
% sudo add-apt-repository ppa:sri-csl/formal-methods
% sudo apt-get update
% sudo apt-get install yices2
% yices --version # TODO
```

1.1.4 List Yices files

```zsh
% find /usr/ -name "yices*h"            # TODO: Ubuntu Linux
% find /usr/local -name "yices*h"       # macOS 11 on Intel
% find /opt/homebrew -name "yices*h"    # macOS 11 on ARM
/path/to/include/yices.h             
/path/to/include/yices_limits.h      
/path/to/include/yices_types.h       
/path/to/include/yices_exit_codes.h  

% find /usr/ -name "liyices*"
% find /usr/local -name "liyices*"
% find /opt/homebrew -name "libyices*"
/path/to/lib/libyices.so                # TODO: Ubunto Linux
/path/to/lib/libyices.a                 # macOS 11 on Intel or ARM
/path/to/lib/libyices.dylib             # macOS 11 on Intel or ARM
/path/to/lib/libyices.2.dylib           # macOS 11 on Intel or ARM
```

1.1.4 Install [Z3](https://github.com/Z3Prover/z3) on macOS 11

```zsh
$ brew install z3
$ Z3 --version
Z3 version 4.8.9 - 64 bit
```

1.1.5 Install [Z3](https://github.com/Z3Prover/z3) on Linux

TODO: check installation

1.1.6 Check Z3 Files

```bash
$ find /usr/ -name "z3*h"           # TODO: Ubuntu Linux
% finf /usr/local -name "z3*h"      # macOS 11 on Intel
$ find /opt/homebrew -name "z3*h"   # macOS 11 on ARM
/path/to/include/z3_rcf.h
/path/to/include/z3_macros.h
/path/to/include/z3_polynomial.h
/path/to/include/z3++.h
/path/to/include/z3_algebraic.h
/path/to/include/z3_fpa.h
/path/to/include/z3_optimization.h
/path/to/include/z3.h
/path/to/include/z3_ast_containers.h
/path/to/include/z3_v1.h
/path/to/include/z3_api.h
/path/to/include/z3_version.h
/path/to/include/z3_fixedpoint.h
/path/to/include/z3_spacer.h

% find /usr/ -name "libz3*"         # Ubuntu Linux, TODO: check base location
% find /usr/local -name "libz3*"    # macOS 11 on Intel
% find /opt/homebrew -name "libz3*" # macOS 11 on ARM
/path/to/lib/libz3.a                # Linux, macOS
/path/to/lib//libz3.dylib           # macOS only
```

- [Swift](https://swift.org/)
```
$ swift --version
Apple Swift version 5.0.1 (swiftlang-1001.0.82.4 clang-1001.0.46.5)
Target: x86_64-apple-darwin18.7.0
```

1.1.3 [CTptpParsing](/https://github.com/AleGit/CTptpParsing)



- [TPTPLibary](http://www.tptp.org)

Download and unpack TPTP-v7.m.n.tgz.
Create a symbolic link to the unpacked folder into your home directory.
```
$ ln -s /path/to/TPTP-v7.m.n ~/TPTP
$ ls ~/TPTP/
Axioms          Documents       Generators      Problems        Scripts         TPTP2X
```

FLEA will search for Axioms and Problems in `~/TPTP/Axioms` and `~/TPTP/Problems`.

