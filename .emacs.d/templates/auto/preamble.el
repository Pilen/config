(TeX-add-style-hook "preamble"
 (lambda ()
    (TeX-run-style-hooks
     "tikz"
     "dot2texi"
     "dot"
     "autosize"
     "xfrac"
     "graphicx"
     "booktabs"
     "hyperref"
     "fancyhdr"
     "amssymb"
     "amsmath"
     "inputenc"
     "utf8"
     "babel"
     "latex2e"
     "art10"
     "article"
     "10pt"
     "a4paper"
     "danish")))

