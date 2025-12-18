#let conf(
  date: (),
  doctyp: [],
  authors: (),
  supervisors: (),
  faculty: (),
  doc,
) = {
  // Headings
  set heading(numbering: "1.")

  show cite: s => [#text(fill: blue, [#s]) ]
  show ref: r => [#text(fill: blue, [#r]) ]

  // footnote magic: settings the font size of the character
  set footnote(numbering: (t) => [ #box(height: 8pt, inset: (top: -6pt), [ #text(size: 28pt, [#t]) ]) ]) // some weird thing with the UT fonts

  //region: FONTS
  show title: t => text(
    font: "UniversNW02-720CdHeavy", 
    fill: white, 
    size: 30pt, 
    [#t]
  )

  show heading.where(level: 1): t => text(
    font: "UniversNW02-720CdHeavy",
    size: 18pt,
    block(below: 1em)[#upper[#t]]
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

  // page layout
  let firstpage-margin-x = 4em
  let firstpage-margin-y = 4em

  page(margin: 0em, columns: 1, fill: rgb(1,158,196),
    [
     #place(bottom, dy: -10%, [
           #image("oo.png")
          ])


    // page margins
     #place(dx: firstpage-margin-x, dy: firstpage-margin-y, [
        #box(/*fill: red,*/ height: 100%-(2*firstpage-margin-y), width: 100%-(2*firstpage-margin-x),
        [
          //doc type (essay,thesis,..)
          #text(
            fill: white,
            [#upper[#doctyp]]
          )

          #place(top+right, [
            #text(fill: white, if date.len() > 1 { date } else { datetime.today().display() })
          ])

          //title
          #box(width: 100%, inset: (y: 15pt), [
              #upper[#title()]
          ])
          // author(s)
          #box(width: 100%, inset: (top: 15pt), [
            #grid(columns: (1fr,) * calc.min(authors.len(), 3), row-gutter: 18pt,
              ..authors.map(a => [
                #box(inset: (y: -.5em),
                  text(
                  weight: 600,
                  size: 16pt, fill: white, [
                    #a.name
                  ])
                )

                #text(size: 12pt, fill: white, [
                  #link("mailto:"+a.email)
                ])
              ])
            )
          ])

        // supervisors
        #box(width: 100%, inset: (top: 25pt), [
            #grid(columns: (1fr,) * calc.min(supervisors.len(), 3), row-gutter: 18pt,
              ..supervisors.map(s => [
                #box(width: 100%, inset: (y: 0pt), [
                  #text(
                    font: "UniversNW02-720CdHeavy", 
                    fill: white,
                    weight: 900,
                    size: 12pt,
                    "Supervisor" + if s.at("institution", default: "") != "" [ #text("@ " + s.institution) ] else []
                )])


                #box(inset: (y: -.5em),
                  text(size: 16pt, fill: white, [
                    #s.name
                  ])
                )

                #text(size: 12pt, fill: white, [
                  #link("mailto:"+s.email)
                ])
              ])
            )
          ])

          #place(bottom+left, [
            #box(width: 40%, [
              #text(fill: white, faculty)
            ])
          ])

          // UT logo
          #place(bottom+right, dx: 1.4em, dy: 1.4em, [
            #image("UT_Logo_White_RGB_EN.pdf", width:50%)
          ])
        ])
      ])
    ]
  )
  counter(page).update(1) // reset page counter to 1 for the actual content

  // link styling
  show link: it => {
    text(fill: rgb("#0074d9"), [
      #underline(it)
    ])
  }

  doc
}

#let abstr(content: "") = [
  #align(center, heading(level: 1, "Abstract", numbering: n => []))
    #counter(heading).update(n => 0) // make Abstract the 0th heading, so the actual numbered headings count from 1 onwards :)
   
    #text(content)
]

