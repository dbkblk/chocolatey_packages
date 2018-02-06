#!/bin/bash
git clone --depth=10 --branch=master https://github.com/chocolatey/choco.git
cd choco
chmod +x build.sh
./build.sh