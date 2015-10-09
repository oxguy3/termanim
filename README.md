# termanim

A really simple tool for running text-based animations in a command line.

## Usage
To use term anim, run `termanim /path/to/dir`, where your directory has the
appropriate files for a termanim animation.

## Creating an animation
To create an animation, you'll first need to create a directory for your
animation files to go into.
A termanim directory should contain .frame files and optionally an anim.conf
file.

The .frame files should contain the raw text of each frame of the
animation. The frames will be displayed in alphabetical order, so naming them
with numbers is highly recommended.

The anim.conf value can be used to alter termanim's timing and looping
settings.

For more information about creating animations, see the sample animation in
the `dance/` directory.
