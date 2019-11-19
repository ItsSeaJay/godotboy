# Godotboy
A monochromatic posterisation shader with a customisable palette.

![Demo](demo.png)

## About
A while back I was participating in the yearly GBJAM, which requires entrants to
make a game either for or with the same limitations as the Nintendo Game Boy:

- A virtual resolution of 160x144
- A palette of 4 distinct colours

While it would be simple enough to just draw the graphics using 4 colours and
call it a day, I wanted more flexibility. So I started work on a shader solution.

## Usage
The repo contains a demo project that indicates how the shader ought to be used.
This demo project also makes a great start for any GBJam submissions written
using the Godot engine, since all of the project and import options have been
preconfigured.

In general, the shader should be applied as a material to a `ColorRect` node
placed above all objects in the scene, which can be achieved by making it the
child of a `CanvasLayer`. Then a palette texture needs to be set, which can be
done through the editor.

If you want to change the default palette at runtime, you can do so by accessing
the shader params of the node that has the associated shader material through
a suitable script.

For best results, all art assets should be in greyscale with evenly spaced red,
green and blue values. This will ensure a more accurate conversion to the chosen
palette.

This shader is intended for 2D games using low resolution pixel art graphics,
but is helpful in making 3D games also.

## Features
- Support for up to 256 distinct colours
- Full posterisation step to allow for conversion of non-pixel-art textures
- Automatic greyscale conversion using the luminosity method

## License
See `LICENSE` for more details.