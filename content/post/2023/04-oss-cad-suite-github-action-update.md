---
title: "OSS CAD Suite Github Action Update"
date: 2023-02-20T11:48:40+01:00
image: /static-2023/githubaction.png
---

The OSS CAD suite setup GitHub action [just had an update](https://github.com/YosysHQ/setup-oss-cad-suite#use-github_token-to-prevent-api-rate-limiting), fixing an issue where sometimes the install would fail due to rate limiting.

The [OSS CAD suite](https://github.com/YosysHQ/oss-cad-suite-build) makes it simple to install a whole set of tools at once, and the GitHub action makes it just as simple to get the tools available for a CI job.

Tools are included for:

* Synthesis
* Formal verification
* FPGA place and route 
* FPGA board programming
* Simulation and testing
