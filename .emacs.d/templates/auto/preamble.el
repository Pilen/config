(TeX-add-style-hook
 "preamble"
 (lambda ()
   (TeX-add-to-alist 'LaTeX-provided-class-options
                     '(("article" "10pt" "a4paper" "danish")))
   (TeX-add-to-alist 'LaTeX-provided-package-options
                     '(("babel" "danish") ("inputenc" "utf8") ("fontenc" "T1") ("hyperref" "hidelinks") ("dot2texi" "dot" "autosize" "outputdir=\"dotgraphs/\"")))
   (TeX-run-style-hooks
    "latex2e"
    "article"
    "art10"
    "babel"
    "inputenc"
    "fontenc"
    "lmodern"
    "amsmath"
    "amssymb"
    "listings"
    "fancyhdr"
    "hyperref"
    "booktabs"
    "graphicx"
    "xfrac"
    "dot2texi"
    "tikz"
    "ulem")))

