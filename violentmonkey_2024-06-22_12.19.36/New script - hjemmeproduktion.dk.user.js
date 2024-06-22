// ==UserScript==
// @name        New script - hjemmeproduktion.dk
// @namespace   Violentmonkey Scripts
// @match       https://hjemmeproduktion.dk/*
// @grant       none
// @version     1.0
// @author      -
// @description 1/17/2021, 3:03:54 AM
// ==/UserScript==

document.getElementsByClassName("header")[0].remove()
window.alert = function (x) {
  console.log(x);
}