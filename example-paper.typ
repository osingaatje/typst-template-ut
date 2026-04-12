// Write code in code blocks
#import "@preview/zebraw:0.6.1": *
#show: zebraw
// Create graphs
#import "@preview/lilaq:0.5.0" as lq

// Change prefix to folder name by uncommenting if you use the recommended folder structure
#let prefix = ""
// #let prefix = "typst-template-ut/"

// Paths used for imports and example data
#let template_path = prefix + "typst-template-paper.typ"
#let oo_pic = prefix + "shared/pics/oo.png"
#let hedy_syntax = prefix + "shared/syntax/hedy.sublime-syntax"
#let graph_data_path = prefix + "data/example-graph-data/graph_data.typ"
#let example_bib_path = prefix + "data/example-bib/bibliography.bib"

#import template_path : *

#set document(title: "Your title")

#show: conf.with(
  doctyp: "Type of document",
  // date: "some date or nothing for today",
  authors: (
    (
      name: "Name Name",
      email: "email@email.com",
    ),
  ),
  supervisors: (
    (
      name: "Supervisor",
      email: "sv@mail.com",
      // institution: "some institution",
    ),
  ),
  faculty: "Faculty of ... (or nothing for no text)",
  bibstyle: "../shared/bib/modified-ieee.csl", // relative to the `typst-ut` shared Typst file
  abstract: "This is the abstract (or remove for no abstract). " + lorem(80),
)
#set page("a4", margin: 2cm, numbering: "1") // or some other formatting of the document

// YOUR CONTENT GOES BELOW HERE (after some adjustments above)
= This is the first section
Your content goes here. This example document shows some of the possibilities of Typst and how to work with it below.

== This is a subsection
- You can make a list like this.
- And do a citation like this @test_citation
  - You can also cite like this #cite(<test_citation>)
  - And #cite(<test_citation>, form: "prose") told me how to do an inline citation

== List enumeration
1. List numbering is like one expects how to create a list with numbers.
2. Another number
  - Or no number
    - Or no number

== Two-column layouts!
#columns(2, [
=== Explanation
Say the magic words (`#columns(2, [content])`) and thy columns will multiply!

Here is some filler text to make the two-column layout appear nicer:

#lorem(50)

== Figure
A figure can be added like this:
#figure(
    image(oo_pic, width: 100%),
    caption: [This is part of the University of Twente],
  ) <image_oo>

And referenced like @image_oo.

= My tables

// This is the table layout, change to what is needed
#set table(
  fill: (x, y) =>
    if x == 0 or y == 0 {
      gray.lighten(40%)
    },
  align: left,
)
#show table.cell.where(y: 0): strong
#show table.cell.where(x: 0): strong

Look in @tabellabel and @tabellabel2 for two amazing tables. Change the table styling above.
// Two tables
  #figure(
    caption: "One table",
    table(
      columns: (3),
      [Letter], [Dutch Number], [\#],
      [A], [Honderdtwintig], [120],
      [B], [Tweeduizend], [2000],
      [C], [Vijf], [5],
      [D], [Twintigduizendvijfhonderdendrie], [20503],
    )
  ) <tabellabel>

  #figure(
    caption: "Another table",
    table(
      columns: (5),
      [Respondent], [@], [#sym.gender.male], [#sym.gender.female], [#sym.Alpha],
      [A], [Email], [22], [2], [Someone],
      [B], [Domain], [16], [5], [Sometwo],
      [C], [Username], [16], [4], [Somethree],
    )
  ) <tabellabel2>
])

= Programming time!

Writing code can be done without problems! 

Just open a new code block like this:

```Python
def sum(a, b):
    return (a + b)

a = int(input('Enter 1st number: '))
b = int(input('Enter 2nd number: '))

print(f'Sum of {a} and {b} is {sum(a, b)}')
```

== A new programming language?

// Introduce Hedy keywords for a custom language
#set raw(syntaxes: hedy_syntax)
You can introduce a custom syntax highlighter with `.sublime-syntax`. For example, syntax highlighting for the Hedy programming language in Dutch!

*Syntax in level 3:*
```Hedy
keuzes is steen, papier, schaar
print Ik wil: keuzes kies willekeurig
```

*Syntax in level 16:*
```Hedy
keuzes = ['steen', 'papier', 'schaar']
print "Ik wil: " keuzes[random]
```

#pagebreak() // Start on new page
= Graphs
// Import some data for the graphs
#import graph_data_path : *
You can find more about graphs here: #link("https://typst.app/universe/package/lilaq/")

== Graphs! Line Chart.

#let xvals(data) = {
  let n = data.len()
  let xs = ()
  for i in range(n) {
    xs.push(i)
  }
  xs
}
#lq.diagram(
  height: 5cm,
  width: 100%,
  title: [Precious data],
  xlabel: $x$, 
  ylabel: $y$,

  lq.plot(data1, xvals(data1), mark: "s", label: [Group 1]),
  lq.plot(data2, xvals(data2), mark: "s", label: [Group 2]),
)

== Graphs! Scatter.

#import "@preview/suiji:0.3.0"
#let rng = suiji.gen-rng(33)
#let (rng, colors) = suiji.uniform(rng, size: data1.len())
#let (rng, sizes) = suiji.uniform(rng, size: data1.len())
#lq.diagram(
  height: 5cm,
  width: 100%,
  xlabel: $x$, 
  ylabel: $y$,
  lq.scatter(
    data1, data2,
    size: sizes.map(size => 5000 * size),
    color: colors,
    map: color.map.magma
  )
)

= How to do maths
Mathematics is possible as well:
$ A = pi r^2 $
$ "area" = pi dot "radius"^2 $
$ cal(A) :=
    { x in RR | x "is natural" } $
#let x = 5
$ #x < 17 $


#bibliography(example_bib_path)
