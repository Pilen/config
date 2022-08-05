// ==UserScript==
// @name        Gitlab - Expand CI/CD table
// @namespace   Violentmonkey Scripts
// @match       https://gitlab.isynet.net/*
// @grant       none
// @version     1.0
// @author      -
// @description 3/11/2022, 10:56:59 AM
// ==/UserScript==

function setup() {
  let el = document.querySelector(".ci-variable-table");
  if (!el) {
    window.setTimeout(setup, 1);
    return;
  }
  el.style.width = "1500px";
  el.appendChild(el.children[0]);
}
window.setTimeout(setup, 1)
