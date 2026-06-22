// colors
#let blue = rgb("#007D9C")
#let lightblue = rgb("#E2EBFF")
#let darkblue = rgb("#005D7D")
#let navy = rgb("#002345")
#let darkgray = rgb("#404040")

#let colors = (
  blue: blue, 
  lightblue: lightblue,
  darkblue: darkblue, 
  navy: navy, 
  darkgray: darkgray
)

#let styling(citestyle: none, bibstyle: none, doc) = {
  if bibstyle == none {
    bibstyle = "ieee"
  }
  if citestyle == none {
    citestyle = "bib/modified-ieee.csl"  
  }

  // default citation style
  set cite(style: citestyle)
  set bibliography(style: bibstyle)

  // citation / reference / code fragment / figure caption styling (link styling at bottom of conf.typ)
  show cite: c => text(fill: blue, c)
  show ref: r => box(text(fill: blue, r))
  show raw: r => text(font: "Jetbrains Mono", size: 1.2em, r)
 
  show math.equation: m => text(font:"New Computer Modern Math", m) 

  show raw.where(block: true): code => {
    show raw.line: it => {
      text(fill: gray)[#it.number]
      h(1em)
      it.body
    } 
    code
  }

  show bibliography: b => [  #set par(leading: 0.5em); #b ]

  // footnote magic: settings the font size of the character
  set footnote(numbering: (t) =>
    box(height: 0pt, width: 3pt, inset: (top: -9pt, left: -1pt), 
      text(fill: blue, size: 28pt, str(t))
    )
  ) // some weird thing with the UT fonts I guess.
  set footnote.entry(clearance: 0.2em, separator: box(inset: (bottom: 2pt), line(length: 35% + 0pt, stroke: 0.03em+navy)))

  //region: FONTS
  show title: t => text(
    font: "UniversNW02-720CdHeavy", 
    fill: white, 
    t
  )

  show heading.where(level: 1): t => text(
    font: "UniversNW02-720CdHeavy",
    block(below: .5em, upper(t))
  )
  show heading: t => text(
    font: "UniversNW02-320CdLt",
    t
  )
  show text: t => text(
    font: "UniversNextW02",
    t
  )
  //endregion

  //region: TABLES
  // fix line spacing in table newlines
  show table: t => {
    set par(leading: 0.35em)
    t
  }

  show table.cell.where(y: 0): c => { 
    set block(fill: rgb("#252525"))
    set text(fill: white)
    c
  }
  //endregion

  doc
}
