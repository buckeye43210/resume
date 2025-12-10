// resume_template.typ – pure Typst, no Pandoc syntax


// The main wrapper function
#let resume(body) = {

// Insert the actual résumé content
  body

  // QR code – only if --input qrcode=true (or any non-empty value)
  if sys.inputs.at("qrcode", default: none) != none {
    place(
      bottom + right,
      dx: -0.5cm,   // distance from right edge
      dy:  0.5cm,   // distance from bottom edge
    )[
      #qr-code(
        "MECARD:N:Holbert,Richard L.;TEL:+1-614-582-7891;EMAIL:rholbert@gmail.com;URL:github.com/buckeye43210;ADR:1254 Bensbrooke Dr, Wesley Chapel, FL 33543;",
        width: 3cm,
        dark-color: navy,
        light-color: white,
      )
    ]
  }
}

// Export the function so resume.typ can call it
// #resume