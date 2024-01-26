#!/bin/bash

if [[ "$OSTYPE" == "darwin"* ]]; then
    # macOS
    path="$( cd "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"
    python3 "$path/__main__.py" "$@"
elif [[ "$OSTYPE" == "linux-gnu" ]]; then
    # Linux
    path="$( cd "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"
    python3 "$path/__main__.py" "$@"
elif [[ "$OSTYPE" == "msys" || "$OSTYPE" == "win32" ]]; then
    # Windows (MSYS or Cygwin)
    cd /d "$(dirname "$0")"
    python __main__.py %*
else
    echo "Unsupported operating system"
    exit 1
fi
