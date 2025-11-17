---
title: "Tabby CAD Suite version 20250121 released!"
date: 2025-01-21
description : ""
image: /static-2023/YOS_horiz.png
tags: ["release notes"]
draft: false
---

The January release of Tabby CAD Suite is now available for download. Notable changes in this version include:

* The interface for generating hashes for objects stored in `pool` and `dict` containers has been rewritten to allow for greater abstraction and simpler use. For plugin authors that have implemented types with a `hash()` method, please check [this documentation page](https://yosyshq.readthedocs.io/projects/yosys/en/latest/yosys_internals/hashing.html#porting-plugins-from-the-legacy-interface) for how to update your code.

In other YosysHQ news:

* We have a new social media account over on [Bluesky](https://bsky.app/profile/yosyshq.com).
* At our last [YUG](https://blog.yosyshq.com/p/yosys-users-group/), Krystine explained how `synth_ice40` works. You can watch the [recording here](https://www.youtube.com/watch?v=s7KLNb8G_sI)!

Happy new year!

The YosysHQ Team
