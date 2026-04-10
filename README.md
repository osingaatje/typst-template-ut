# typst-template-ut: An unofficial University of Twente Typst template
Made by Douwe Osinga, inspired by previous work of Eli Saado.
Beamer template inspired by work of Femke Weijsenfeld.

# Fonts
Local development with Typst and fonts is.. interesting. How I got my fonts to work was:
1. Copy the fonts to your fonts directory (on Linux: `usr/share/fonts`, MacOS: no clue, sorry) or install them (Windows)
2. On Linux: make sure to reload your fonts (on Arch: `fc-cache`).
3. Compile with `typst compile` or your favourite editor integration and enjoy!

# Using the Template
I recommend the following file structure:

```txt 
 |-typst-template-ut
 |  |-conf.typ
 |  |-...
 |
 |-your-file.typ
 |-...
```

We recommend copying `example-paper.typ` or `example-beamer.typ` to a file outside the `typst-template-ut` folder as seen in the example above. 

The example documents show some ideas of what can be done and can be a helpful start of your project!

# Contributors
- Eli Saado (for the idea of using Typst and the first draft)
- Femke Weijsenfeld (for making the beamer template and improving it after adoption into this project)

