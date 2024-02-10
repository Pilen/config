// ==UserScript==
// @name        Gitlab menu
// @namespace   Violentmonkey Scripts
// @match       https://gitlab.isynet.net/*
// @grant       none
// @version     1.0
// @author      -
// @description 3/24/2021, 6:52:59 PM
// ==/UserScript==


function setup() {
  let menu = document.querySelector("header .header-content .title-container");
  let submenu = document.createElement("ul");
  submenu.classList.add("nav");
  submenu.classList.add("navbar-nav");
  menu.append(submenu);
  function f(text, url) {
    let li = document.createElement("li");
    //let div = document.createElement("span")
    let a = document.createElement("a");
    a.href = url;
    //a.style = "margin: 4px 0; padding: 6px 8px; height: 32px; color: #d1d1f0";
    a.append(document.createTextNode(text));
    li.append(a)
    //div.append(a);
    submenu.append(li);
    console.log(text);
  }
  f("Global board", "/groups/isynet/-/boards?scope=all&utf8=✓&assignee_username=spi");
  f("Inflow", "/isynet/inflow");
  f("Inflow board", "/groups/isynet/inflow/-/boards?scope=all&utf8=✓&not[label_name][]=Timetracking");
  console.log(menu);  
  
  
  let new_issue = document.querySelector("a[data-qa-selector=new_issue_link]")
  if (new_issue) {
    let menu = document.querySelector("div .navbar-collapse > ul");
    let li = document.createElement("li");
    let a = document.createElement("a");
    a.href = new_issue.href;
    a.append(document.createTextNode("New issue"));
    li.append(a);
    menu.prepend(li);
  }
}
setup()