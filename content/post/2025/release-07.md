---
title: "Tabby CAD Suite version 20250709 released!"
date: 2025-07-09
description : ""
image: /static-2023/YOS_horiz.png
tags: ["release notes"]
draft: false
---

The July release of Tabby CAD Suite is now available for download. Notable changes in this version include:

* SBY: The handling of assertions in cover mode was changed; now by default it will not consider assertions at all, and in particular it will no longer fail the cover task if any assertions were violated during the cover traces. You can restore the original behavior by adding the option `cover_assert on` to the `[options]` section.

In other YosysHQ news:

* Matt and Nico will be attending ORConf in Valencia, September 12 to 14th. It would be great to see you there, and even better if you wanted to do a presentation on how you use open source tools for chip development. [https://fossi-foundation.org/orconf/2025](https://fossi-foundation.org/orconf/2025) 

Happy July,

The YosysHQ Team
