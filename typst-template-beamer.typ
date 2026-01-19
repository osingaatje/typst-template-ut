// Original author: Flavio Barisi (@preview/minimal-presentation:0.7.0)
// secondary author: Femke Weijsenfeld
// fine-tuning and refactoring by Douwe Osinga

#import "shared/typst-ut.typ": *

#let state_sectionpage = state("section-page", false)
#let main-color-state = state("main-color-state", none) // is set in the "project" function


#let set-main-color(main-color) = {
  main-color-state.update(x =>
    main-color
  )
}

// example usage: #columns-content [col1 content] [col2 content] [...etc.]
#let columns-content(align: horizon, ..args) = {
  let argdict = args.named() // "horizon": <value>, "col-widths": <value>, ...
  let bodies = args.pos() // [col1 content] [col2 content] [...etc]
  
  let column-sizes = argdict.at("column-sizes", default: (1fr,) * bodies.len() )
  if column-sizes.len() != bodies.len() {
    panic("Please provide column sizes for all column bodies!")
  }

  grid(
    columns: column-sizes,
    gutter: argdict.at("gutter", default: 1cm),
    align: align,
    ..bodies
  )
}

#let project(
  title: [Title],
  sub-title: [Subtitle],
  author: none,
  date: none,
  cover-image-path: "shared/pics/oo.png",
  aspect-ratio: "16-9",
  main-color: blue,
  body
) = {
  show: styling // show shared font styling etc.

  set document(title: title, author: author)
  main-color-state.update(x =>
    main-color
  )
  set underline(offset: 3pt)
  set page(
    margin: 0pt,
    paper: "presentation-" + aspect-ratio,
    footer: context if (counter(page).get() != 0) {
      place(bottom+right, dx: 2em, dy: -1em,
      numbering(
        "1 / 1",
        ..counter(page).get(),
        ..counter(page).final(),
      )
    ) } else { }
  )
  // set par(justify: true) // hyphenation of long text

  set list(
      tight:true, indent: 0.27cm, body-indent: 0.7cm, 
      marker: (
        context place(top+center, dy: -0.25em,
          text(size: 1.5em, fill: main-color-state.at(here()), "▶")), 

        context place(top+center, dy: -0.25em,
          text(size: 1.25em, fill: main-color-state.at(here()), "■"))
      ))

  set enum(numbering: (..args) => context{text(fill:main-color-state.at(here()), numbering("1.", ..args))})

  set figure(gap: 20pt)

  show bibliography: set heading(level: 2)

  let slide-polygon() = {
    place(top+left, context polygon(
      fill: main-color-state.at(here()),
        (0cm, 0cm),
        (0cm, 3cm),
        (0.4cm, 3cm),
        (0.4cm, 0cm),
    ))
  }

  // Display the title page.
  page(footer: [] /* no page numbering etc.*/, [
    #counter(page).update(0)

    #if (cover-image-path != none) {
      place(image(width: 100%, height: 100%, cover-image-path))
    }

    #place(block(fill: rgb("000000AA"), width: 100%, height: 100% + 1pt))
    #place(
      polygon(
    fill: main-color,
      (100%, 0%),
      (55%, 0%),
      (80%, 100%),
      (100%,  100%),
    ))
    
    #pad(left: 1.5cm, right: 10cm, y: 1.5cm)[
      #v(1fr)
      #block(width: 15cm, upper(title))
      
      #v(0.5cm)      
      #v(1fr)
      #if author != none {
         author
      } --
      #if date != none {
          date
      }
    ]
  ])

  set page(
    background: context{
      if state_sectionpage.at(here()) {
      rect(width: 100%, height: 100%, fill: main-color-state.at(here()))
        place(horizon,
          polygon(
          fill: white,
          (90%, 10%),
          (90% - 1.2cm, 10%),
          (90% - 1.2cm, 90%),
          (90% - 1.2cm, 20%),
          (90% - 1.2cm, 90% - 1.2cm),
          (90% - 9cm,  90% - 1.2cm),
          (90% - 9cm,  90%),
          (90%, 90%),
        ))
    }
  }
  )

  set align(horizon)

  // Link
  show link: it => underline(
    context text(fill: main-color-state.at(here()), it)
  )

  // Slide subtitles
  show heading.where(level: 1): it => [
    #state_sectionpage.update(_ => true)
    #pagebreak(weak: true)
    #it
  ]

  show heading.where(level: 2): it => [
    #state_sectionpage.update(_ => false )
    #pagebreak()
    #it
  ]

  show heading.where(level: 3): it => [
    #pagebreak()
    #it
  ]

  // -------- FINISHING TOUCHES -------- //
  set page(margin: 4em)
  body // rest of the document
}

// Table of contents
#let table-of-contents(
  logo: none,
  index-title: "Content",
  heading-2-size: 1.9em,
) = {
    show underline: it => it.body // no underline
    show heading.where(level: 1): h => h.body // no separate title page

    heading(level: 1, [Table of Contents])
    context{
      let elements = query(selector(heading.where(level: 1)).after(here()))
      enum(tight: false, ..elements.map(elem =>
        link((page: elem.location().page() + 1, x: 0pt, y: 0pt), elem.body))
      )
    }
  } 
