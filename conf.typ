#let conf(
  doctyp: [],
  authors: (),
  abstract: [],
  doc,
) = {
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
        #box(/*debug: fill: red,*/ height: 100%-(2*firstpage-margin-y), width: 100%-(2*firstpage-margin-x),
        [
          //doc type (essay,thesis,..)
          #box(width: 100%, [
            #text(
              fill: white,
              [#upper[#doctyp]]
            )
          ])
          
          //title
          #box(width: 100%, height: 20%, inset: (y: 2em), [
            #place(top+left,
            [
              #upper[#title()]
            ])
          ])
          // author(s)
          #box(width: 100%, [
            #grid(columns: (1fr,) * calc.min(authors.len(), 3), row-gutter: 18pt,
              ..authors.map(a => [
                #text(size: 16pt, fill: white, [
                    #a.name
                ]) \
                #text(size: 12pt, fill: white, [
                  #link("mailto:"+a.email)
                ])
              ])
            )
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

  doc
}

