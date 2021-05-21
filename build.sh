#!/bin/bash
set -ex
if [ ! -d public ]; then
	git clone git@github.com:YosysHQ-GmbH/YosysHQ-GmbH.github.io.git public
fi
git -C public rm -r .
echo blog.yosyshq.com > public/CNAME
hugo -e production
git -C public add -A
