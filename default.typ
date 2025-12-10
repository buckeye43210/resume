#import "@preview/rustycure:0.2.0": qr-code
#import "@preview/diagraph:0.3.6"#let horizontalrule = line(start: (25%,0%), end: (75%,0%))


#set text(font: "teX Gyre Pagella", size: 9.75pt)
#set heading(numbering: none)
#set par(leading: 0.3em, justify: true)
#set list(marker: [⋄], indent: 0.4em)
// Variables from YAML

#set document(
  date:     auto,
)

#set page(
  paper: "us-letter",
  margin: (top: 0.5in, bottom: 0.25in, left: 0.4in, right: 0.5in),
  numbering: none,
  background: if border [
    #place(
      top + left,
      dx: 0.50em,      // shift right
      dy: 0.25em,      // shift down
    )[
      #image("images/border01.pdf", width: 100%, height: 100%)
    ]
  ]
)


$if(smart)$
$else$
#set smartquote(enabled: false)

$endif$
$for(header-includes)$
$header-includes$

$endfor$
#show: doc => conf(
$if(title)$
  title: [$title$],
$endif$
$if(subtitle)$
  subtitle: [$subtitle$],
$endif$
$if(author)$
  authors: (
$for(author)$
$if(author.name)$
    ( name: [$author.name$],
      affiliation: [$author.affiliation$],
      email: [$author.email$] ),
$else$
    ( name: [$author$],
      affiliation: "",
      email: "" ),
$endif$
$endfor$
    ),
$endif$
$if(keywords)$
  keywords: ($for(keywords)$$keyword$$sep$,$endfor$),
$endif$
$if(date)$
  date: [$date$],
$endif$
$if(lang)$
  lang: "$lang$",
$endif$
$if(region)$
  region: "$region$",
$endif$
$if(abstract-title)$
  abstract-title: [$abstract-title$],
$endif$
$if(abstract)$
  abstract: [$abstract$],
$endif$
$if(thanks)$
  thanks: [$thanks$],
$endif$
$if(margin)$
  margin: ($for(margin/pairs)$$margin.key$: $margin.value$,$endfor$),
$endif$
$if(papersize)$
  paper: "$papersize$",
$endif$
$if(mainfont)$
  font: ("$mainfont$",),
$endif$
$if(fontsize)$
  fontsize: $fontsize$,
$endif$
$if(mathfont)$
  mathfont: ($for(mathfont)$"$mathfont$",$endfor$),
$endif$
$if(codefont)$
  codefont: ($for(codefont)$"$codefont$",$endfor$),
$endif$
$if(linestretch)$
  linestretch: $linestretch$,
$endif$
$if(section-numbering)$
  sectionnumbering: "$section-numbering$",
$endif$
  pagenumbering: $if(page-numbering)$"$page-numbering$"$else$none$endif$,
$if(linkcolor)$
  linkcolor: [$linkcolor$],
$endif$
$if(citecolor)$
  citecolor: [$citecolor$],
$endif$
$if(filecolor)$
  filecolor: [$filecolor$],
$endif$
)

$body$

  #h(0.25em)
  #if qrcode [
    #place(
      bottom + right,
      dx: +0.5cm,   // distance from right edge
      dy: -0.5cm,   // distance from bottom edge
    )[
    #qr-code(
       "MECARD:N:Holbert,Richard L.;
		TEL:+1-614-582-7891;
		EMAIL:rholbert@gmail.com;
		URL:github.com/buckeye43210;
		ADR:1254 Bensbrooke Dr, Wesley Chapel, FL 33543;",
   width: 3cm,
   dark-color: navy,
   light-color: white,
   fit: "contain"
  )]
 ]
 