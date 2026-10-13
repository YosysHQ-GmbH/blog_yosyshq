#!/bin/bash
set -e
# get any changes others have published before building on top of them
cd public
git pull --rebase
cd ..
hugo -e production
cd public
git add -A
git commit -m 'update'
git push
