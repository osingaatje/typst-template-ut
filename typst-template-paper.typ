#import "shared/typst-ut.typ": styling, colors

#let conf(
  date: (),
  doctyp: [],
  authors: (),
  supervisors: (),
  faculty: (),
  margin-x: 1.5cm,
  margin-y: 1.5cm,
  doc,
) = {
  set page(numbering: "1 / 1")
  show: styling // apply the styling from typst-ut document

  // specific raw styling colour
  show raw: r => text(fill: navy, r)

  // Headings
  set heading(numbering: "1.")

  // page layout
  let firstpage-margin-x = margin-x
  let firstpage-margin-y = margin-y

  page(margin: 0em, columns: 1, fill: colors.blue,
    [
     #place(bottom, dy: -10%, image("shared/pics/oo.png"))

    // page margins
     #place(dx: firstpage-margin-x, dy: firstpage-margin-y, [
        #box(/*fill: red,*/ height: 100%-(2*firstpage-margin-y), width: 100%-(2*firstpage-margin-x),
        [
          //doc type (essay,thesis,..)
          #text(fill: white, upper(doctyp))

          #place(top+right,
            text(fill: white, if date.len() > 1 { date } else { datetime.today().display() })
          )

          //title
          #box(width: 100%, inset: (y: 15pt), upper(title()))
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

                // name and email address
                #box(inset: (y: -.5em),
                  text(size: 16pt, fill: white, s.name)
                )

                #text(size: 12pt, fill: white, link("mailto:"+s.email))
              ])
            )
          ])

          // faculty
          #place(bottom+left, [
            #box(width: 40%, [
              #text(size: 10pt, fill: white, top-edge: .5em, faculty)
            ])
          ])

          // UT logo
          #place(bottom+right,
            box(width: 70%, text(
                      font: "UniversNW02-320CdLt",
                      fill: white,
                      weight: 400,
                      size: 24pt, tracking: -1pt, stretch: 90%, kerning: true,
                "UNIVERSITY OF TWENTE.")
          ))
        ])
      ])
    ]
  )
  counter(page).update(1) // reset page counter to 1 for the actual content

  // link styling (must be after the main page to prevent email addresses from having underline
  show link: it => text(fill: colors.darkblue, underline(it))
  doc
}

#let abstr(content: "") = [
  #align(center, heading(level: 1, "Abstract", numbering: n => []))
    #counter(heading).update(n => 0) // make Abstract the 0th heading, so the actual numbered headings count from 1 onwards :)
   
    #text(content)
]



