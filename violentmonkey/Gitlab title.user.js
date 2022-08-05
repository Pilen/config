// ==UserScript==
// @name        Gitlab title
// @namespace   Violentmonkey Scripts
// @match       https://gitlab.isynet.net/*
// @grant       none
// @version     1.0
// @author      -
// @description 10/20/2020, 4:44:42 PM
// ==/UserScript==

document.title = document.title.split(" · ").map(ss => ss.split(" / ").reverse().join(" / ")).join(" · ")