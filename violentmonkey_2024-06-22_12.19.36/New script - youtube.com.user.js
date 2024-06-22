// ==UserScript==
// @name        New script - youtube.com
// @namespace   Violentmonkey Scripts
// @match       https://www.youtube.com/
// @grant       none
// @version     1.0
// @author      -
// @description 3/27/2021, 11:28:30 PM
// ==/UserScript==

function fix() {
  el = document.getElementById("chips-wrapper")
  el.style.position = "static";

  el = document.getElementById("right-arrow");
  el.style.height = "auto";
  
  el = document.getElementById("masthead-container")
  el.style.position = "static";
  
  console.log("fix")
}

fix()
window.setTimeout(fix, 1000);
window.setTimeout(fix, 5000);
window.setTimeout(fix, 10000);
window.setTimeout(fix, 60000);