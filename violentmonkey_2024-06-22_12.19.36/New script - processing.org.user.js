// ==UserScript==
// @name        New script - processing.org
// @namespace   Violentmonkey Scripts
// @match       https://processing.org/reference/*
// @grant       none
// @version     1.0
// @author      -
// @description 2/14/2022, 4:53:59 PM
// ==/UserScript==

function setup() {
  let title = new RegExp("^https://processing.org/reference/(.+)_.html").exec(document.URL)[1];
  if (document.title != title) {
    document.title = title;
    setTimeout(setup, 1000);
  }
}
setup()