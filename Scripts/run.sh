#!/bin/bash

swift build -Xlinker -L/usr/local/lib

./.build/x86_64-apple-macosx/debug/Flea "$@"