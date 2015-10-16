# termanim

**NOTE:** This is a readme for how termanim _is going_ to work, not how it currently works.

A really simple tool for running text-based animations in a command line.

## Usage
To use termanim, run `./termanim.sh /path/to/dir`, where your directory has the appropriate files for a termanim animation.

## Creating an animation
To create an animation, you'll first need to create a directory for your animation files to go into. The structure of your directory will look something like this:

```
myanim/
  anim.conf
  sc_001 - Intro/
    f_000.conf
    f_000.backdrop
    f_000.overlay
    f_000
    f_001
    f_002
    f_003
    ...
  sc_002/
    f_000.backdrop
    f_000.overlay
    f_000
    f_001
    ...
```

## Scenes
Scenes are directories within the root directory of your animation. They contain all the frames and other time-based info/image files. A directory name must begin with `sc_` to be recognized as a scene. Scenes will be played in alphabetical order, so it's advisable to number them so that the order is easy to follow. However, you are free to name them however you please.

You are free to use as many or as few scenes as you wish. The only technical purpose they serve is allowing you to change which anim.conf file is used.

## anim.conf
This file is used to set overarching configuration options for your entire animation. You can have an anim.conf file in the root of your entire project, or in the directories of any of your scenes.

You are not required to set every option in your anim.conf files, or to even include anim.conf files at all. If an option is omitted from a scene's anim.conf, the value from the root directory's anim.conf is used. If a value is missing from the root anim.conf, the application's default is used.

Here are all the options, what they do, and their default values:

* FRAME_TIME: How long (in seconds) should each frame be shown? Default: 0.2
* LOOP_COUNT: How many times should the animation be looped? For infinite looping, set to -1 (you'll have to stop the animation manually with Ctrl+C). _Default: -1_
* LOOP_TIME: How long (in seconds) should the animation be paused before the loop repeats? Note that the FRAME_TIME already applies, and this will be added to that time. _Default: 0_
* LAYER_COUNT: How many layers should there be? _Default: 5_
* DEFAULT_LAYER: If a frame file's name doesn't include a layer option, which layer should it be placed on? This value can be an integer or the special value "auto", which evaluates to the middle layer (calculated by `ceil(LAYER_COUNT / 2)`). _Default: auto_
* DEBUG: If set to 1, additional info about the animation will be printed while it plays. _Default: 0_

## Frame files
Frames are the actual still images that make up the animation. A frame file is just a text file containing the raw text that makes up all or part of your raw image.

Frame files must be placed within a scene directory, and their name must begin with `f_`. Much like scenes, frames play in alphabetical order, so it is again recommended that you number them.

A frame file only makes up part of a frame. All files that begin with `f_sometext.` are considered part of the same frame. After that period, you can begin including special options.

### Colors
You can customize the foreground and background of each frame file. This is done with a special option in the filename. Add an option `.fg-COLOR` to change the foreground, or `.bg-COLOR` to change the background.

#### Examples
* `f_001.fg-dkred`: This frame would have red text on the terminal's default background color.
* `f_001.bg-ltblu`: This frame would have text in the terminal's default foreground color on a light blue background.
* `f_001.fg-dkyel.bg-dkgry`: This frame would have yellow text on a dark gray background.

#### List of colors
Here are all the color names termanim allows, their approximate RGB values (colors will vary depending on which terminal program you use -- these are the values in xterm). The terms in brackets are aliases -- you can use whichever you prefer:

* **black**: black (0, 0, 0) [dkblk, dkblack, blk]
* **white**: white (255, 255, 255) [ltwht, ltwhite, wht]
* **dkgray**: dark gray (127, 127, 127) [dkgry, ltblk, ltblack, gray]
* **ltgray**: light gray (229, 229, 229) [ltgry, dkwht, dkwhite]
* **red**: dark red (205, 0, 0) [dkred]
* **green**: dark green (0, 205, 0) [dkgrn, dkgreen, grn]
* **yellow**: dark yellow/brown (205, 205, 0) [dkyel, dkyellow, yel, brown]
* **blue**: dark blue (0, 0, 238) [dkblu, dkblue, blu]
* **magenta**: dark magenta (205, 0, 205) [dkmag, dkmagenta, mag]
* **cyan**: dark cyan (0, 205, 205) [dkcyn, dkcyan, cyn]
* **ltred**: light red (255, 0, 0)
* **ltgreen**: light green (0, 255, 0) [ltgrn]
* **ltyellow**: light yellow (255, 255, 0) [ltyel]
* **ltblue**: light blue (92, 92, 255) [ltblu]
* **ltmagenta**: light magenta (255, 0, 255) [ltmag]
* **ltcyan**: light cyan (0, 255, 255) [ltcyn]

### Layers
If you have an element that will appear in multiple frames without changing, you might not want to have to include it in each individual frame file. Instead, you can use layers.

Layers allow you to stack multiple images each time a frame is drawn. By default, there are 5 layers (modify LAYER_COUNT in anim.conf to change this). If a frame file doesn't include a layer number, it will go to the middle layer by default (modify DEFAULT_LAYER to change this); if you have 5 layers, this will be the third layer. You can select a different layer to use with a special option (see "Selecting a layer" below).

Layers persist between frames, meaning that if you have a frame file that modifies a certain layer, that frame file's image will stay in that layer until another frame has a file that affects the same layer. This is ideal for creating backdrops or

#### Selecting a layer

There are several ways to specify which layer you want. The recommended method is to select layers relative to the default layer. If you want the Nth layer above the default layer, use `.layer+N`; likewise, for the Nth layer below the default layer, use `.layer-N`.

There are To select a layer relative to the lowest layer, use `.layer_N`, (`.layer_0` is the very bottom layer). To select a layer relative to the highest layer, use `.layer~N`, (`.layer~0` is the very top layer). To select a layer by its absolute number (not recommended), use `.layerN` (this is essentially the same as selecting relative to the lowest layer, except it starts at 1 instead of 0, i.e. `.layer_0` = `.layer1`).
