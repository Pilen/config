
(defun insert-unicode-symbol ()
  (interactive)
  (let ((selected (ido-completing-read "symbol: " useful-unicode-symbols nil)))
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
       "½ 1/2 one half"))