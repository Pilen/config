// ==UserScript==
// @name        New script - elfadistrelec.dk
// @namespace   Violentmonkey Scripts
// @match       https://www.elfadistrelec.dk/search
// @grant       none
// @version     1.0
// @author      -
// @description 8/16/2022, 9:40:24 PM
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
    ".plp-filter-products__product__info__compact__product-info__image-wrapper { width: 200px !important; height: 100px !important;}",
  )
}
setup()