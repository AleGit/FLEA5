# FLEA5
Simple First Order Prover with Equality

_in development_

## Prerequesites

- [Yices](http://yices.csl.sri.com)

```Bash
$ brew install SRI-CSL/sri-csl/yices2
$ yices --version
Yices 2.6.1
Copyright SRI International.
Linked with GMP 6.1.2
Copyright Free Software Foundation, Inc.
Build date: 2019-09-01
Platform: x86_64-apple-darwin18.7.0 (release)

$ find /usr/local -name "yices*h"
/usr/local/include/yices.h             # Linux and macOS
/usr/local/include/yices_limits.h      # Linux and macOS
/usr/local/include/yices_types.h       # Linux and macOS
/usr/local/include/yices_exit_codes.h  # Linux and macOS

$ find /usr/local -name "liyices*"
/usr/local/lib/libyices.so             # Linux only
/usr/local/lib/libyices.dylib          # macOS only
/usr/local/lib/libyices.2.dylib        # macOS only
```

- [Z3](https://github.com/Z3Prover/z3)

```
$ git clone https://github.com/Z3Prover/z3.git
$ cd z3
$ CXX=clang++ CC=clang python scripts/mk_make.py
$ cd build
$ make
$ sudo make install
$ Z3 --version
Z3 version 4.8.6 - 64 bit

$ find /usr/local -name "z3*h"
/usr/local/include/z3_rcf.h
/usr/local/include/z3_macros.h
/usr/local/include/z3_polynomial.h
/usr/local/include/z3++.h
/usr/local/include/z3_algebraic.h
/usr/local/include/z3_fpa.h
/usr/local/include/z3_optimization.h
/usr/local/include/z3.h
/usr/local/include/z3_ast_containers.h
/usr/local/include/z3_v1.h
/usr/local/include/z3_api.h
/usr/local/include/z3_version.h
/usr/local/include/z3_fixedpoint.h
/usr/local/include/z3_spacer.h

$ find /usr/local -name "libz3*"
/usr/local/lib/libz3.dylib      # macOS only
```

- [Swift](https://swift.org/)
```
$ swift --version
Apple Swift version 5.0.1 (swiftlang-1001.0.82.4 clang-1001.0.46.5)
Target: x86_64-apple-darwin18.7.0
```

- [CTptpParsing](/https://github.com/AleGit/CTptpParsing)

    The tptp parsing library can easily be build and installed.
```Bash
$ git clone https://github.com/AleGit/CTptpParsing.git
$ cd CTptpParsing
$ sudo make install

$ find /usr/local -name "Prlc*h"
/usr/local/include/PrlcCore.h           # linux, macOS
/usr/local/include/PrlcData.h           # linux, macOS
/usr/local/include/PrlcMacros.h         # linux, macOS
/usr/local/include/PrlcPaser.h          # linux, macOS

$ find /usr/local -name "libTptpParsing*"
/usr/lib/lib/libTtptpParsing.so         # linux
/usr/local/lib/libTptpParinsg.dylib     # macOS
```
