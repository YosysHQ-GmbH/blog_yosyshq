---
title: "Community Spotlight - Surfer"
date: 2023-11-27T13:26:31+01:00
image: /static-2023/spotlight/surfer/surfer.png
tags: ["community spotlight"]
---

# Surfer

Welcome to another [community spotlight](/tags/community-spotlight/) article where we shine a light on open source EDA projects. If you want to [submit a project, please do so here](https://docs.google.com/forms/d/e/1FAIpQLSdIEgu6FJZam0-V3PMTjw-eDebJdg_JuIlN4MkLNDr4vs-a5A/viewform?usp=sf_link).

Surfer is a new waveform viewer with a focus on extensibility and a snappy
(optionally keyboard driven) UI. It runs both natively and in web-assembly, so
you can try it out right here in the browser at
[https://app.surfer-project.org](https://app.surfer-project.org/?load_url=https://app.surfer-project.org/picorv32.vcd&startup_commands=show_quick_start;module_add%20testbench.top).
The project is written in rust and while it is still in its early stages, it is
usable as a day-to-day wave viewer.

# Frans Skarman's Bio

I am a 5th year PhD student at the department of electrical engineering at
Linköping university in Sweden. I'm originally a software person, who started
off in game development and then descending lower and lower in the tech stack
until I reached this wonderful world of hardware. The whole time, i've
been most interested in writing tools; initially game engines instead of games,
and now compilers instead of actual hardware design. My main project these days is
<https://spade-lang.org/> a hardware description language inspired by modern
software languages.

Outside of programming I enjoy some 3d printing, playing flight simulators, as
well as sailing or skiing when the weather permits.

![Frans Skarman](/static-2023/spotlight/surfer/frans.jpg)

I also need to give credit to Lucas who was featured in the [last community
spotlight](/p/community-spotlight-wal/), and my PhD advisor Oscar who have
contributed a ton of features and fixes to the project.


# What motivated you to make Surfer?

When building my HDL, Spade, I ran into a problem. With a powerful type system,
the bit representation of a signal is often hard to understand, so you need a
way to automatically translate the values back into their human-readable
representation to effectively debug your designs. While `gtkwave` has support
for custom translation via external programs, it turned out to be quite hard to
get right and wasn't as powerful as I wanted. For example, I found no way to
translate a value into a list of expandable sub-fields to, for example, expand
individual fields of a struct. I was also bothered by small things like how
zooming and scrolling works in gtkwave.

Eventually, the question of "how hard can it be" made me start this project.
Luckily, it turns out that with the right libraries, the answer to that
question was that it is easier than I thought it would be.

# What makes you excited about Surfer?

Overall, I'm very excited about having a mostly solid waveform viewer where I
and others can try out new things, both in terms of translations and interface.
I do have some favorite features I can touch more on though:

## Web assembly

Perhaps my favorite thing about Surfer right now is that it works almost
flawlessly in web assembly. You can see a demo of that at
[https://app.surfer-project.org](https://app.surfer-project.org). If you
have a VCD file to analyse, you can just append that to the URL along with some commands to run when the waveform is loaded, for example
<https://app.surfer-project.org/?load_url=https://app.surfer-project.org/picorv32.vcd&startup_commands=module_add%20testbench;divider_add%20.;divider_add%20top;module_add%20testbench.top;show_quick_start>.

Apart from being a cool tech demo, this also enables some cool workflow in
CI/CD. For example, we can augment the [tinytapeout](https://tinytapeout.com/)
test action to link to surfer with the
resulting waveform. No longer will you have to re-run your tests locally, or
manually download a VCD file to view it in a desktop viewer.

I'm also very happy that going from idea to implementation of the web version
took less than a day thanks to the rich rust ecosystem around web assembly.

## Signal translation

As I mentioned earlier, a big motivator for building surfer was being able to
get richer translation of Spade types. Even though I had a hacky system for
doing that in `gtkwave`, the Surfer version where you can expand or collapse
`struct`s, view individual `enum` variants and translate sub-fields as you please
is a game changer.

Below is an image and a quick demo video showing it off
![Picture showing surfer translating Spade structs opcodes](/static-2023/spotlight/surfer/surfer.png)

{{< youtube 58AW1LpNaDM >}}

Another really cool translator is the RISC-V opcode translator shown below

![Picture showing surfer translating RISC-V opcodes](/static-2023/spotlight/surfer/riscv_opcode_translation.png)

I have also done my best to build this translation system to be decoupled from
Spade, meaning that anyone could add translation for their own HDLs constructs,
or perhaps something completely different, like a translator that splits a stereo audio signal into left and right channels. All that
is needed for that is to implement a [few methods in a
trait](https://gitlab.com/surfer-project/surfer/-/blob/main/src/translation/mod.rs?ref_type=heads#L290)

## Keyboard and mouse gesture based UI

As a vim user, I hate reaching for my mouse, so we've put quite a bit of effort
into making surfer usable with just the keyboard. There are some keybindings
for normal navigation of course, but most of the happens via a fuzzy matching
based command palette, similar to ctrl-p in Visual Studio Code. For tasks where
the mouse is more appropriate, like navigating the waveform there is also a mouse gesture based UI. You can see both in action in the video below.

{{< youtube gASWElSl32k  >}}


# Why do you make open source tools?

Every time I have to use non-open source software I get frustrated, sometimes
because dealing with licenses but often just because the software is missing
features or customization options that I want, or because features I rely on get removed in a new version. These frustrations happen less with open source software in my experience. Since I probably wouldn't use a closed
source tool myself, I'm certainly not going to build one.

For surfer in particular, one of the big advantages of open source is that
everyone can add their favorite features, whether it is a translator for a new
signal format, a new way to render waves or some new way to interact with the
program, things that a closed source developer might not have the interest nor resources to implement.
After a while, this makes an open source tool feel very complete, because all
the small features and fixes have been added.


# What are some challenges?

The biggest challenge in my mind is in UI design. I'm not a UI designer, I only
took a single course on it during my bachelor, so most of the time I'm just winging
it. For features I use myself, I at least have some idea of what I want, for
feature requests by others I might even have that.

There have also been some technical hurdles, primarily because we offload the
parsing of wave files to external libraries. For now we only support VCD, but
we are working on both decoupling surfer from the VCD library, as well as
adding support for other formats, in particular FST.

# What could the community do to support you?

First, give surfer a try. Let us know what you find nice and what could use
improvements. Especially as a non-UX person it is invaluable to get feedback
from users!

If you want to do more, consider contributing the features you think are
missing. In particular, small features like a translator for a new bit format, a
fix for a small bug you find or perhaps some additional way to zoom or navigate the waveforms.
As I said earlier, people contributing these small things are what gives open source software that
warm feeling that someone has thought of your particular use case.

Of course, we're also very happy to accept bigger contributions, like
support for loading files from other wave formats or big translators for
translating to the native format from some alt-HDL like Amaranth, Chisel or
Clash.



# What is the best link to give for the project?

If you want to learn more, see the [git repo](https://gitlab.com/surfer-project/surfer). You can also try Surfer right in your browser at <https://app.surfer-project.org>

# What is the best way for people to contact you?

* Email: [frans.skarman@liu.se](mailto:frans.skarman@liu.se)
* Mastodon: [TheZoq2@mastodon.social](https://mastodon.social/@thezoq2)
* The Spade discord (with a surfer channel): <https://discord.gg/hdyGSn8ejw>
