// ==UserScript==
// @name        New script - oracle.com
// @namespace   Violentmonkey Scripts
// @match       https://docs.oracle.com/en/java/javase/17/docs/api/java.base/java/util/HashMap.html
// @grant       none
// @version     1.0
// @author      -
// @description 12/19/2021, 2:29:30 AM
// ==/UserScript==

function setup() {
  let el = document.querySelector("section#class-description");
  if (el) {
    el.style.width = "800px";
  }
  el = document.querySelector("section.details");
  if (el) {
    el.style.width = "800px";
  }
}

setup()