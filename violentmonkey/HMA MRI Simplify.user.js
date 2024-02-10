// ==UserScript==
// @name        HMA MRI Simplify
// @namespace   Violentmonkey Scripts
// @match       https://mri.cts-mrp.eu/Human/Product/Details/*
// @grant       none
// @version     1.0
// @author      -
// @description 4/7/2021, 12:57:36 PM
// ==/UserScript==

function setup() {
  let entry = document.createElement("li");
  entry.onclick = simplify;
  entry.title = "Simplify Layout";
  entry.innerHTML = "<a>S</a>";
  document.querySelector("#footerMenu ul").append(entry);
}

function simplify() {
  document.querySelector("#col1")?.remove();
  document.querySelector("#undernav")?.nextElementSibling.remove();
  document.querySelector("#undernav").remove();
  document.querySelector("#footerx")?.remove();
  document.querySelector("#col3").style.borderLeftWidth = "0";
  document.querySelector("#col3").style.minWidth = "0";
  document.querySelector("#col3").style.width = "600px";
  document.querySelector("#nav_main").style.width = "600px";
  document.querySelector("#page_margins").style.margin = "0";
}
setup();
