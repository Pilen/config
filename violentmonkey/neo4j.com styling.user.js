// ==UserScript==
// @name        neo4j.com styling
// @namespace   Violentmonkey Scripts
// @match       https://neo4j.com/*
// @grant       none
// @version     1.0
// @author      -
// @description 12/3/2020, 11:10:51 AM
// ==/UserScript==
document.querySelectorAll("p").forEach(x => {x.style.color = "#000"; x.style.fontWeight = "400"});
