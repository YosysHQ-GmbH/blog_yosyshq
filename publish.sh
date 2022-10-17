#!/bin/bash
hugo -e production
cd public
git add -A
git commit -m 'update'
git push
