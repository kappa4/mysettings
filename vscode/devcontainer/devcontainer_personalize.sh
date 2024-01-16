#!/bin/bash

cd .devcontainer

/bin/bash ./personalize1.sh
if [ $? -ne 0 ]; then
    echo "personalize1.sh failed: $?"
    exit 1
fi

/usr/bin/zsh ./personalize2.sh
if [ $? -ne 0 ]; then
    echo "personalize2.sh failed: $?"
    exit 1
fi
