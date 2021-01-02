# FLEA5 – First Order Prover with Equality

Author: Alexander Maringele

_sitll in development_

1 Prerequesites

- [Git](https://git-scm.com) 2.24
- [clang](http://clang.llvm.org)
- [pkc-config](https://www.freedesktop.org/wiki/Software/pkg-config/) 0.92
- [Swift](https://swift.org) 5.3 (Compiler etc.)
- [Yices2](https://yices.csl.sri.com) 2.6.2 (SAT and SMT Solver)
- [Z3](https://github.com/Z3Prover/z3) 4.8.9 (SAT and SMT Solver)


We can easily check if the necessary development tools and libraries are already installed.

```zsh
% swift --version           # Swift 5.3 or newer, clang 12 or newer
% git --version             # Git 2.24 or newer
% pkg-config --version      # 0.92 or newer
% yices --verison           # 2.6.2 or newer
% z3 --version              # 4.8.9 or newer
```

If not see Readme-macOS.md and Readme-Ubuntu.md for installation hints.


2 Download Thousand Problems for Theorem Provers (TPTP)


- [TPTPLibary](http://www.tptp.org)

Download and unpack TPTP-v7.m.n.tz 
Rename the unpacked folder into your home directory.

```zsh
% curl http://www.tptp.org/TPTP/Distribution/TPTP-v7.4.0.tgz --output TPTP-v7.4.0.tgz
% tar -xf TPTP-v7.4.0.tgz
% mv TPTP-v7.4.0 ~/TPTP
% rm TPTP-v7.4.0.tgz

$ ln -s /path/to/TPTP-v7.m.n ~/TPTP
$ ls ~/TPTP/
Axioms          Documents       Generators      Problems        Scripts         TPTP2X
```

FLEA will search for Axioms and Problems in 

- `~/TPTP/Axioms` and `~/TPTP/Problems`
- `~/Downloads/TPTP/Axioms` and `~/Downloads/TPTP/Problems`

by default.

3 Install the TPTP Parsing Library

The [tptp parsing library](https://github.com/AleGit/CTptpParsing) - written in C with Bison and Flex - is provided by the author and can easily be installed on macOS and Ubuntu.

```zsh
% # Ubuntu Linux, macOS
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

After installation (`sudo make install`) the pkg-config command should yield the following paths for the parsing library.

```zsh
% pkg-config tptpparsing --cflags --libs
-I/usr/local/include -L/usr/local/lib   # macOS 11 (ARM or Intel)
-I/usr/include -L/usr/lib               # Ubuntu (TODO: CHECK)
```

Now the pkg-config must yield correct paths to header and library files of Yices2 and Z3.

```zsh
% pkg-config yices --cflags --libs
-I/opt/homebrew/include -L/opt/homebrew/lib     # macOS 11 on ARM
-I/us#r/local/include -L/opt/homebrew/lib        # macOS 11 on Intel
-I/usr/include -L/opt/homebrew/lib              # TODO: Ubuntu Linux

% pkg-config z3api --cflags --libs
-I/opt/homebrew/include -L/opt/homebrew/lib     # macOS 11 on ARM
-I/usr/local/include -L/opt/homebrew/lib        # macOS 11 on Intel
-I/usr/include -L/opt/homebrew/lib              # TODO: buntu Linux
```

4 Download, run and test FLEA.

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

