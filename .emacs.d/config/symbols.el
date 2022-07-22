
(defun insert-unicode-symbol ()
  (interactive)
  (let ((selected (ido-completing-read "symbol: " useful-unicode-symbols nil)))
    (setq useful-unicode-symbols (cons selected (delete selected useful-unicode-symbols)))
    (insert (substring selected 0 1))))

(setq useful-unicode-symbols
      (list
       "α alpha"
       "β beta"
       "γ gamma"
       "δ delta"
       "ε epsilon"
       "ζ zeta"
       "η eta"
       "θ theta"
       "ι iota"
       "κ kappa"
       "λ lambda"
       "μ mu"
       "ν nu"
       "ξ xi"
       "ο omicron"
       "π pi"
       "ρ rho"
       "ς sigma"
       "τ tau"
       "υ upsilon"
       "φ phi"
       "χ chi"
       "ψ psi"
       "ω omega"

       "σ sigma alternative"

       "Α Alpha big"
       "Β Beta big"
       "Γ Gamma big"
       "Δ Delta big"
       "Ε Epsilon big"
       "Ζ Zeta big"
       "Η Eta big"
       "Θ Theta big"
       "Ι Iota big"
       "Κ Kappa big"
       "Λ Lambda big"
       "Μ Mu big"
       "Ν Nu big"
       "Ξ Xi big"
       "Ο Omicron big"
       "Π Pi big"
       "Ρ Rho big"
       "Σ Sigma big"
       "Τ Tau big"
       "Υ Upsilon big"
       "Φ Phi big"
       "Χ Chi big"
       "Ψ Psi big"
       "Ω Omega big"
       "Ω Ohm" ;; Alias

       "ℕ natural"
       "ℤ integer"
       "ℚ rational"
       "ℝ real"
       "ℂ complex"
       "∞ infinity"
       "× multiplication"
       "÷ division"
       "⊕ circled plus"
       "⊖ circled minus"
       "⊗ circled times"
       "⊘ circled division slash"
       "⊙ circled dot"
       "⊚ circled ring"
       "⊛ circled asterix/star"
       "⊜ circled equals"
       "⊝ circled dash"
       "∅ empty set"
       "ℵ aleph"
       "∈ in / element of"
       "∋ contains"
       "∉ not in"
       "∌ not contains"
       "⊂ subset"
       "⊃ superset"
       "⊆ subset or equal"
       "⊇ superset or equal"
       "⊄ not subset"
       "⊅ not superset"
       "∪ union"
       "∩ intersection"
       "≡ identical"
       "≢ not identical"
       "≈ approx"
       "≤ less than or equal (smaller)"
       "≥ greater than or equal (larger, more)"
       "¬ lnot"
       "⊨ true"
       "⊭ not true"
       "∀ forall"
       "∃ exists"
       "∄ not exists"
       "∧ land"
       "∨ lor"
       "∑ summation sigma"
       "∘ circle (compose)"
       "° degree"
       "½ 1/2 one half"
       "§ paragraf"
       "¹ superscript one"
       "² superscript two squared"
       "³ superscript three cubed"
       "€ euro"
       "£ pound"



       "➝ right arrow"
       "➞ heavy right arrow"
       "➜ heavy round right arrow"
       ))
