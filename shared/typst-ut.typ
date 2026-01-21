// colors
#let blue = rgb("#007D9C")
#let darkblue = rgb("#005D7D")
#let navy = rgb("#002345")
#let darkgray = rgb("#404040")

#let colors = (
  blue: blue, 
  darkblue: darkblue, 
  navy: navy, 
  darkgray: darkgray
)

#let styling(doc) = {

  // default citation style
  set cite(style: "bib/modified-ieee.csl")

  // citation / reference / code fragment / figure caption styling (link styling at bottom of conf.typ)
  show cite: c => text(fill: blue, c)
  show ref: r => box(text(fill: blue, r))
  show figure.caption: c => box(inset: (left: 1pt, right: 1pt), text(fill: darkgray, size: 8pt, c))
  show raw: r => text(font: "JetBrains Mono", r)

  // footnote magic: settings the font size of the character
  set footnote(numbering: (t) =>
    box(height: 8pt, width: 4pt, inset: (top: -6pt, left: 1pt), 
      text(fill: blue, size: 28pt, [#t])
    )
  ) // some weird thing with the UT fonts I guess.

  //region: FONTS
  show title: t => text(
    font: "UniversNW02-720CdHeavy", 
    fill: white, 
    size: 30pt, 
    t
  )

  show heading.where(level: 1): t => text(
    font: "UniversNW02-720CdHeavy",
    size: 18pt,
    block(below: 1em, upper(t))
  )
  show heading: t => text(
    font: "UniversNW02-320CdLt",
    t
  )
  show text: t => text(
    font: "UniversNextW02",
    t
  )

  // fix line spacing in table newlines
  show table: t => {
    set par(leading: 0.35em)
    t
  }

  //endregion

  doc
}
