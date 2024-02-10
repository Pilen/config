// ==UserScript==
// @name        Gitlab - Inflow Board
// @namespace   Violentmonkey Scripts
// @match       https://gitlab.isynet.net/groups/isynet/inflow/-/boards
// @grant       none
// @version     1.0
// @author      -
// @description 6/10/2021, 6:47:00 PM
// ==/UserScript==

function simplify() {
  document.querySelectorAll(".board-issue-path").forEach(el => {
    el.innerText = el.innerText.replace(/^isynet\/inflow\//, "");
  })
  // console.log("simplify");
}

simplify();
window.setTimeout(simplify, 10);
window.setTimeout(simplify, 100);
window.setTimeout(simplify, 500);
window.setTimeout(simplify, 1000);
window.setTimeout(function() {
  window.setInterval(simplify, 5000);
});