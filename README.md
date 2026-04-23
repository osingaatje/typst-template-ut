# typst-template-ut: An unofficial University of Twente Typst template
Made by Douwe Osinga, inspired by previous work of Eli Saado.

# Fonts
Local development with Typst and fonts is... interesting. How I got my fonts to work was:
1. Copy the fonts from `shared/fonts` to your fonts directory (on Linux: `usr/share/fonts`, MacOS: no clue, sorry) or install them (Windows)
2. On Linux: make sure to reload your fonts (on Arch: `fc-cache`).

# Compiling Typst
Compile with `typst compile` or your favourite editor integration and enjoy!

**NOTE**: With some PDF viewers, it is also possible to 'watch' the typst file and have the PDF update with every file change. This is done using `typst watch`, see the Typst docs for more info.

# Using the Template
I recommend the following file structure:

```txt 
 |-typst-template-ut
 |  |- shared
 |  |- ...
 |  |- example-beamer.typ
 |  |- example-paper.typ
 |  |- ...
 |
 |-your-document.typ
 |-...
```

We recommend copying `example-paper.typ` or `example-beamer.typ` to a file outside the `typst-template-ut` folder as seen in the example above, where it is named `your-document.typ`.

The example documents show some ideas of what can be done and can be a helpful start of your project!

# Contributors
- Douwe (main contributor, maker of functions and fixer of bugs)
- Eli Saado (for the idea of using Typst and the first paper template draft)
- Femke Weijsenfeld (for making the examples and helping with improvements to the templates and README)

