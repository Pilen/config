// ==UserScript==
// @name        friluftsland.dk Menu
// @namespace   Violentmonkey Scripts
// @match       https://www.friluftsland.dk/*
// @grant       none
// @version     1.0
// @author      -
// @description 4/20/2021, 11:13:12 PM
// ==/UserScript==

function simplify() {
  let el = document.querySelector(".header-container");
  if (el) {
    el.style.position = "static";
  }
  console.log("simplify");
}
simplify()
window.setTimeout(simplify, 1000 * 1);
window.setTimeout(simplify, 1000 * 2);
window.setTimeout(simplify, 1000 * 3);
window.setTimeout(simplify, 1000 * 4);
window.setTimeout(simplify, 1000 * 5);
window.setTimeout(simplify, 1000 * 6);
window.setTimeout(simplify, 1000 * 7);
window.setTimeout(simplify, 1000 * 8);
window.setTimeout(simplify, 1000 * 9);
window.setTimeout(simplify, 1000 * 10);
window.setTimeout(simplify, 1000 * 20);
window.setTimeout(simplify, 1000 * 30);
window.setTimeout(simplify, 1000 * 60);
window.setTimeout(simplify, 1000 * 120);