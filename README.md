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

..with `your-file.typ` (or whatever name you choose) containing the following use of the template (example is for the paper format):
```typ
#import "typst-template-ut/conf.typ" : conf

#set document(title: "Your title")

#show: conf.with(
  doctyp: "Type of document",
  //date: "some date or nothing for today",
  authors: (
    (
      name: "Name Name",
      email: "email@email.com",
    ),
  ),
  supervisors: (
    (
      name: "Super Visor"
      email: "sv@mail.com",
    // institution: "some institution",
    ),
  ),
  faculty: "Faculty of ... (or nothing for no text",
  abstract: lorem(80),
)
#set page("a4", margin: 2cm, numbering: "1") // or some other formatting of the document

Your Content Goes Here

```

Similar instructions apply for the beamer format :) 


