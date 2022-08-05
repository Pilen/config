// ==UserScript==
// @name        vaticle.com - TypeDB Documentation scrolling
// @namespace   Violentmonkey Scripts
// @match       https://docs.vaticle.com/docs/*
// @grant       none
// @version     1.0
// @author      -
// @description 2/9/2022, 11:31:37 AM
// ==/UserScript==


function addStylesheetRules(...rules) {
  let styleEl = document.createElement("style");
  document.head.appendChild(styleEl);
  let styleSheet = styleEl.sheet;
  for (let rule of rules) {
    styleSheet.insertRule(rule, styleSheet.cssRules.length);
  }
}

function setup() {
  addStylesheetRules(
    "html, body { overflow: initial !important; }",
    ".o-scrollable-body { overflow: unset; position: unset; }",
    //"body {color: black !important;}",
    "p {color: black !important; font-size: 16px;}"
  )
}
setup()