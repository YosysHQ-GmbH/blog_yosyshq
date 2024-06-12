---
title: "Community Spotlight - MIRMIS"
date: 2024-06-12T16:00:00+01:00
image: /static-2024/spotlight/mirmis/esa-hero.bmp
tags: ["community spotlight"]
---

# MIRMIS

The Modular Infrared Molecules and Ices Sensor (<abbr>MIRMIS</abbr>) is a
hyperspectral infrared imaging instrument set to launch on ESA's
[Comet Interceptor] mission in 2029. Its development is led by the University
of Oxford's [Professor Neil Bowles] (Instrument Lead Scientist) and it has
three sensors&mdash;<abbr title="Thermal Infrared Imager">TIRI</abbr>
(University of Oxford), <abbr title="Mid-Infrared">MIR</abbr>, and
<abbr title="Near-Infrared">NIR</abbr> (VTT Finland)&mdash;that will image a
pristine comet to measure its structure, chemical composition, and temperature,
allowing researchers to gain insight into the formation of the Solar system.

> ![MIRMIS STM mounted for vibration testing](/static-2024/spotlight/mirmis/vibe.png)
>
> The MIRMIS structural&ndash;thermal model (STM) mounted for vibration testing
> at 35g in the Space Instrumentation group's vibration test facility.

The [Space Instrumentation group] at the University of Oxford is building the
common structures and mechanisms for MIRMIS, building and calibrating the TIRI
sensor, integrating the MIR/NIR sensors, and building MIRMIS' command and
data-handling unit (<abbr>CDHU</abbr>). The CDHU is the interface to the
spacecraft and is based around a radiation-hard microcontroller and
radiation-tolerant FPGA that together process commands from Earth, control
pointing mirrors to track the target comet, operate the imaging sensors, and
carry out housekeeping over the instrument's multi-year trip through deep space.

YosysHQ support FPGA development on MIRMIS by providing formal verification
tools, including SymbiYosys for [safety and liveness property] checking and
reachability checking.


> ![Lunar Thermal Mapper](/static-2024/spotlight/mirmis/ltm.png)
>
> Lunar Thermal Mapper (launching November 2024 on NASA's Lunar Trailblazer),
> the previous-generation instrument on which MIRMIS/TIRI is based, shown
> without its protective covering.

[Comet Interceptor]: https://www.esa.int/Science_Exploration/Space_Science/Comet_Interceptor
[Professor Neil Bowles]: https://www.space.ox.ac.uk/our-people/neil-bowles
[Space Instrumentation group]: https://www.physics.ox.ac.uk/research/group/space-instrumentation
[safety and liveness property]: https://en.wikipedia.org/wiki/Safety_and_liveness_properties


# Space instruments at Oxford

Part of the University of Oxford's Atmospheric, Oceanic, and Planetary Physics
(<abbr>AOPP</abbr>) sub-department, the Space Instrumentation group and our
sister [Infrared Multilayer Laboratory] have a long history of building science
instruments. Our contributions include, among many others:

 * 2029 &mdash; [Comet Interceptor], MIRMIS, and [ARIEL telescope] (Sun&ndash;Earth L<sub>2</sub>)
 * 2024 &mdash; [PREFIRE], infrared filters (Earth)
 * 2024 &mdash; [James Webb Space Telescope], Mid-Infrared Instrument filters (Sun&ndash;Earth L<sub>2</sub>)
 * 2018 &mdash; [InSight], Short-period Seismometer (Mars)
 * 2010 &mdash; [Stratospheric Observatory for Infrared Astronomy], filters (Earth)
 * 2005 &mdash; [Mars Reconnaissance Orbiter], Mars Climate Sounder optics (Mars)
 * 2004 &mdash; [Aura], High-Resolution Dynamics Limb Sounder (Earth)
 * 1997 &mdash; [Cassini-Huygens], Composite Infrared Spectrometer cooler and optics (Saturn)
 * 1989 &mdash; [Galileo], Near-Infrared Mapping Spectrometer (Jupiter)
 * 1978 &mdash; [Pioneer 12], VORTEX (Venus)
 * 1970 &mdash; [Nimbus 4], Selective Chopper Radiometer (Earth)

In addition to the work done by the Space Instrumentation group and the
Infrared Multilayer Laboratory, the more than 100 members of AOPP research and
contribute to the study of exoplanets and planetary physics, atmospheric,
climate, and weather theory and modelling, Earth's oceans, and Earth's
cryosphere. AOPP is based out of the Clarendon Laboratory in the centre of
Oxford, where it has a range of space-related facilities including cleanrooms,
a variety of vacuum chambers, metrology, spectroscopy, optics, and
vibration-testing facilities, and electronics and mechanical workshops.

[Infrared Multilayer Laboratory]: https://www.physics.ox.ac.uk/about-us/our-facilities-and-services/infrared-multilayer-laboratory
[ARIEL telescope]: https://arielmission.space/index.php/ariel-media/
[PREFIRE]: https://science.nasa.gov/mission/prefire/
[James Webb Space Telescope]: https://webb.nasa.gov/content/about/index.html
[InSight]: https://science.nasa.gov/mission/insight/
[Stratospheric Observatory for Infrared Astronomy]: https://science.nasa.gov/mission/sofia/
[Mars Reconnaissance Orbiter]: https://science.nasa.gov/mission/mars-reconnaissance-orbiter/
[Aura]: https://aura.gsfc.nasa.gov/about.html
[Cassini-Huygens]: https://science.nasa.gov/mission/cassini/
[Galileo]: https://science.nasa.gov/mission/galileo/
[Pioneer 12]: https://en.wikipedia.org/wiki/Pioneer_Venus_Orbiter
[Nimbus 4]: https://en.wikipedia.org/wiki/Nimbus_4

> ![CIRS engineering model](/static-2024/spotlight/mirmis/cirs-em.jpg)
>
> Engineering model (EM) of the focal plane assembly for the CIRS instrument on
> Cassini-Huygens, which operated in Saturn orbit from 2004 until 2017.

[L3Harris]: https://www.l3harris.com/en-gb/united-kingdom


# Why build MIRMIS?

Comets and other interstellar objects can tell us a lot about how our Solar
system formed. As they were often ejected a long time ago, they act as a time
capsule holding the chemicals and materials that were around in the early Solar
system. This means that, if we can accurately measure their properties, we have
a direct view into the past. One challenge with this is finding a 'pristine'
object&mdash;we tend to see these objects as they pass through the inner Solar
system, where the heat and radiation from the Sun will change them. MIRMIS will
be launched as part of Comet Interceptor to the Sun&ndash;Earth L<sub>2</sub>
[Lagrange point], around 1.5 million kilometres away and where the James Webb
Space Telescope is stationed, so that it can move quickly to intercept a
pristine comet after it's detected but before it's spent too long transiting
the Solar system.

[Lagrange point]: https://en.wikipedia.org/wiki/Lagrange_point


# What makes you excited about MIRMIS?

The MIRMIS instrument is exciting both because of the science data it will
produce but also because of the engineering behind it. It continues a process
of refining and improving our equipment&mdash;its CDHU and TIRI are evolutions
of Lunar Thermal Mapper, while the infrared filters have heritage to Diviner
and further back.

The technology behind MIRMIS also has the potential to impact life on Earth
more directly. One use we've been exploring is launching a MIRMIS-like
instrument to detect wildfires on Earth. The instrument itself is compact
(around the size of a large briefcase), weighs around 9kg, and draws around
11W peak. A small constellation could launch on a single rocket and provide
multiple observations of the entire surface of the Earth per day, and with the
Space Instrumentation group's extensive background in high-resolution infrared
imaging the results could exceed current capabilities.


# What are some of the challenges you face?

## There are no debug probes in space
Verification and validation are huge parts of building a space instrument. Not
only is deep space a radiation-harsh environment but getting there on a rocket
puts a lot of forces on the relatively delicate glassware in optical systems
and, once you've launched, there's no replacing a broken part. This is part of
our reason for using Yosys and SymbiYosys in particular&mdash;formal
verification of the FPGA components gives us a lot more confidence and
functional coverage than plain unit tests and testbenches can provide.

## Space hardware lags the leading edge
It takes a lot of time to qualify a part for space, and for integrated circuits
they often need to be made with different processes from normal commercial
parts. This means that the performance tends to be significantly lower, too.
The FPGA in the MIRMIS CDHU, for example, requires more than a little effort to
close timing at 100MHz and has no niceties like DSP blocks, large block RAMs,
PLLs, high-density logic elements, or extensive IP core libraries. And that's
before having to build in triple redundancy and other safeguards against
radiation flipping a bit in a register or transiently changing the value on a
signal line.


> ![MIRMIS EFM](/static-2024/spotlight/mirmis/efm.png)
>
> Electrical functional model (EFM) of the MIRMIS command and data-handling
> unit.


# What could the community do to support you?

Keep being interested in space and in planetary science. Science is a
collaborative endeavour, and the more people we have contributing to and
advancing the field the better the results can be for all humanity. And keep
developing high-quality, open-source tools to support the science.


# What is the best link for the project?

ESA's [Comet Interceptor Red Book] is a great deep dive into the mission,
including MIRMIS as well as the other instruments.

If you're interested in postgraduate study, have a look at our
[open DPhil projects].

[Comet Interceptor Red Book]: https://www.cosmos.esa.int/web/comet-interceptor/documentation
[open DPhil projects]: https://www.physics.ox.ac.uk/study/postgraduates/dphil-atmospheric-oceanic-and-planetary-physics/planetary-and-exoplanetary


# Liam McSherry's bio

![Headshot of Liam McSherry](/static-2024/spotlight/mirmis/mcsherry.png)

I'm an engineer working across electronics, FPGA, and software disciplines. I
split my time between the Space Instrumentation group at Oxford, as Principal
Engineer currently leading FPGA development on the MIRMIS CDHU, and [L3Harris],
as a Principal Engineer architecting and helping build high-performance RF and
signal-processing systems. In my work I've had a hand in projects including
radio direction-finding systems, control systems for ion-trap quantum
computing, GNSS anti-jam/anti-spoof, and both ground and space sides of
satellite payloads, as well as delivering talks and training courses on C++,
software-defined radios, and FPGAs.

Outside of work, I like to take a relaxed approach. I read a lot, I cook and
bake, and occasionally badly play badminton. Being in Oxford, I like to take
advantage of the many green spaces, too.


# What is the best way for people to contact you?

 * Neil Bowles (Instrument Lead Scientist, MIRMIS): neil.bowles [at] physics.ox.ac.uk
 * Liam McSherry: liam.mcsherry [at] physics.ox.ac.uk
