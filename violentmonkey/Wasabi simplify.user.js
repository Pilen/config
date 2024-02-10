// ==UserScript==
// @name        Wasabi simplify
// @namespace   Violentmonkey Scripts
// @match       http://wasabi.isynet.net/dwh/d/*
// @grant       none
// @version     1.0
// @author      -
// @description 3/30/2021, 12:12:58 PM
// ==/UserScript==

function setup() {
  console.log("in setup");
  let entry = document.createElement("div");
  entry.classList.add("menu-icon");
  entry.innerText = "S";
  entry.onclick = simplify;
  entry.title = "Simplify Layout";
  document.querySelector(".headline .right").append(entry)
}

function simplify() {
  document.querySelector("#links")?.remove();
  document.querySelector(".headline")?.remove();
  document.querySelector("#frm-search")?.remove();
  document.querySelector("#keywords-found")?.remove();
  document.querySelector(".folding-box-arrow")?.remove();
  document.querySelector(".menu-table")?.remove();
  document.querySelector(".dataTables_filter")?.remove();
  document.querySelector(".datatables-expander")?.remove();
  document.querySelector(".paging_two_button")?.remove();

  document.querySelector(".folding-box").style.border = "0";
  document.querySelector(".folding-box>div").style.padding = "0";
  document.querySelector(".folding-box>div").style.margin = "0";
  document.querySelector(".outputtable").style.width = "";
  document.body.style.backgroundColor = "white";
  document.body.parentNode.style.backgroundColor = "white";
  document.body.parentNode.style.overflowY = "hidden";
  document.body.style.margin = "4px";
  
  document.querySelectorAll("table.outputtable th").forEach(x => {x.style.minWidth = "0"});
  document.querySelector("table").style.width = "600px";
}
setup();