// ==UserScript==
// @name        youtube.com title
// @namespace   Violentmonkey Scripts
// @match       https://www.youtube.com/*
// @grant       none
// @version     1.0
// @author      -
// @description 3/28/2021, 9:25:04 PM
// ==/UserScript==

function simplify() {
  document.title = document.title.replace(/^\([0-9]+\) /, "");
  console.log("Simplify")
}
simplify();
window.setTimeout(simplify, 1000 * 1);
window.setTimeout(simplify, 1000 * 2);
window.setTimeout(simplify, 1000 * 3);
window.setTimeout(simplify, 1000 * 4);
window.setTimeout(simplify, 1000 * 5);
window.setInterval(simplify, 5000);

