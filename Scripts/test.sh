#!/bin/bash

swift package clean
swift test -Xlinker -L/usr/local/lib "$@"