#import "typst-template-beamer.typ" : *

// Write code in code blocks
#import "@preview/zebraw:0.6.1": *
#show: zebraw
// Create graphs
#import "@preview/lilaq:0.5.0" as lq

#let oo_pic = "shared/pics/oo.png"

#show: project.with(
  title: [This is the title of this presentation],
  sub-title: "This is the subtitle",
  author: "Student van der Achternaam",
  date: "16/01/2025",
)


// Put table of contents anywhere you like
#table-of-contents(index-title: "Contents")
// Delete this line if you do not want the table of contents

= Start a Section

== A slide title

- You can make a list like this.
- And do a citation like this @test_citation
  - You can also cite like this #cite(<test_citation>)
  - And #cite(<test_citation>, form: "prose") told me how to do an inline citation

== Two columns (1/2)

#columns-content()[
  You can make two columns like this and even make a reference to @label1.
][
  #figure(
    image(oo_pic, width: 100%),
    caption: [Big lake with tents],
  ) <label1>
]

== Two columns (2/2)

#columns-content(align: top)[
  *My tips:*

  For text it can sometimes be nice to align at the top, as vertical alignment would sometimes be weird. Removing the `align: top` would align vertically, as that is the default setting.
][
  *My promise:*

  So how does this top alignment look to you?
]

== Three columns!

#columns-content()[
  Did you know?
][
  Three or more columns are...
][
  ... possible as well? Just open as many square brackets as you want!
]
  
#set-main-color(rgb("#e200cb"))

= My favourite colour
#block(width: 23cm)[
  #text(fill: white)[It is possible to change the colour of the presentation with the `#set-main-color` command!]
]

== Pink now!

- From now on, the theme is pink!

#figure(
  image(oo_pic, height: 9.2cm),
  caption: [The same picture, but with doubts whether the water is a lake or not],
) <label_name2>

== Programming time!

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
#set raw(syntaxes: "shared/syntax/.sublime-syntax")
You can introduce a custom syntax highlighter with `.sublime-syntax`. For example, syntax highlighting for the Hedy programming language in Dutch!

#columns-content()[
  *Syntax in level 3:*
  ```Hedy
  keuzes is steen, papier, schaar
  print Ik wil: keuzes kies willekeurig
  ```
][
  *Syntax in level 16:*
  ```Hedy
  keuzes = ['steen', 'papier', 'schaar']
  print "Ik wil: " keuzes[random]
  ```
]

#set-main-color(rgb("#2441e5"))

= New big section

== Enumeration?

#let description-size = 16pt
#columns-content()[
  1. List numbering is like one expects how to create a list with numbers.
  2. Another number
    - Or no number
      - Or no number

][
  #figure(
    image(oo_pic, height: 10cm),
    caption: [It is no lake according to #cite(<test_citation>, form: "prose")],
  ) <label3>
]

== Find the difference!

Aligning at the bottom usually looks best when you have two captions.
#columns-content(align: bottom)[
  #figure(
    image(oo_pic, width: 100%),
    caption: [lake],
  ) <image_docentenhandleiding>
][
  #figure(
    image(oo_pic, width: 100%),
    caption: [no lake],
  ) <image_digibordapplicatie>
]

#set-main-color(rgb("#e57424"))
= Tables and Data

== My tables

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
#show table.cell : set text(size: description-size)

Look in @tabellabel and @tabellabel2 for two amazing tables. Change the table styling above.
// Two tables
#columns-content(align: bottom)[
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
][
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
]
== Method

// For simplicity, this chart is created in another Typst file
#import "data/example-graph-data/method.typ" : methode-diagram
#methode-diagram

#set-main-color(rgb("#e52424"))

= Data and SubSubSub

== Wishing for more?

Did you ever dream of using three `===`? Well, you can! Because that will result in subheadings of the slide title, as shown in the next slide!

=== Look at me! I am beautiful!

*Isn't this great?*

Next up, we will import lists of numbers defined in the `data` folder to create graphs.

=== Graphs! Box Plot.
#import "data/example-graph-data/graph_data.typ" : *

#show figure: set block(spacing: 5em)
#figure(
  caption: "My beautiful figure",
  stack(
    spacing: 0.4em,

    // The diagram
    lq.diagram(
      title: "Results",
      height: 96%,
      width: 60%,
      ylabel: "Average Score",
      xaxis: (hidden: true),
      lq.boxplot((data1), mean: "x", x: (1,)),
      lq.boxplot((data2), mean: "x", x: (2,)),
    ),

    // Manual x-axis labels (sorry this is ugly, but this was the fastest fix)
    align(center,
      grid(
        columns: 2,
        gutter: 4.5em,
        row-gutter: 1em,
        [
          ~~~~~~~~~~~~~Group 1
        ],
        [
          Group 2
        ],
      )
    )
    
  )
)

=== Graphs! Line Chart.

#let xvals(data) = {
  let n = data.len()
  let xs = ()
  for i in range(n) {
    xs.push(i)
  }
  xs
}
#lq.diagram(
  height: 100%,
  width: 100%,
  title: [Precious data],
  xlabel: $x$, 
  ylabel: $y$,

  lq.plot(data1, xvals(data1), mark: "s", label: [Group 1]),
  lq.plot(data2, xvals(data2), mark: "s", label: [Group 2]),
)

=== Graphs! Scatter.

#import "@preview/suiji:0.3.0"
#let rng = suiji.gen-rng(33)
#let (rng, colors) = suiji.uniform(rng, size: data1.len())
#let (rng, sizes) = suiji.uniform(rng, size: data1.len())
#lq.diagram(
  height: 100%,
  width: 100%,
  lq.scatter(
    data1, data2,
    size: sizes.map(size => 5000 * size),
    color: colors,
    map: color.map.magma
  )
)


=== Mathematics

You can find more graphs here: #link("https://typst.app/universe/package/lilaq/")

Mathematics is possible as well:
$ A = pi r^2 $
$ "area" = pi dot "radius"^2 $
$ cal(A) :=
    { x in RR | x "is natural" } $
#let x = 5
$ #x < 17 $



#set-main-color(rgb(1,158,196))
== Conclusion
- This leads to #sym.arrow that, and further #sym.arrow this
- Many more symbols can be found when using `#sym`.
- The bibliography is automatically generated based on the cited sources.
  - Add more sources in the `bibligraphy.bib` file in the `bib` directory.

You can generate it with:
#bibliography("data/example-bib/bibliography.bib", style: "shared/bib/apa-no-ampersand.csl") // or using "shared/bib/modified-ieee.csl"
