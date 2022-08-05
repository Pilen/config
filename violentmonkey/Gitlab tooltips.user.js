// ==UserScript==
// @name        Gitlab tooltips
// @namespace   Violentmonkey Scripts
// @match       https://gitlab.isynet.net/*
// @grant       none
// @version     1.0
// @author      -
// @description 3/24/2021, 6:52:59 PM
// ==/UserScript==


function setup() {
  let styleEl = document.createElement("style");
  document.head.appendChild(styleEl);
  let styleSheet = styleEl.sheet;
  let CSS = ".tooltip.b-tooltip.gl-tooltip { display: none !important; }";
  styleSheet.insertRule(CSS, styleSheet.cssRules.length);
}
setup()