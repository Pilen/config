// ==UserScript==
// @name        Wasabi title
// @namespace   Violentmonkey Scripts
// @match       http://wasabi.isynet.net/dwh/d/*
// @grant       none
// @version     1.0
// @author      -
// @description 3/22/2021, 4:01:26 PM
// ==/UserScript==

//document.title = "Wasabi " + window.location.pathname.match("^.*::([^:]+)/$")[1];
document.title = document.querySelector(".output h1 a").text + " · Wasabi";