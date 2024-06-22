// ==UserScript==
// @name        New script lospec.com
// @namespace   Violentmonkey Scripts
// @match       https://lospec.com/palette-list/*
// @grant       none
// @version     1.0
// @author      -
// @description 5/20/2024, 5:33:22 PM
// ==/UserScript==

let COLORS = null;

function makeColors() {
    if (!COLORS) {
        COLORS = []
        //let row = [];
        //COLORS.push(row);
        //for (el of document.querySelectorAll("div.palette>.color")) {
        //    row.push(el.innerText);
        //    if (row.length == 8) {
        //        row = [];
        //        COLORS.push(row);
        //    }
        //}
        //if (row.length == 0) {
        //    COLORS.pop();
        //}

        let row = [];
        for (el of document.querySelectorAll("div.palette>.color")) {
            row.push(el.innerText);
        }
        COLORS.push(row);

    }



    let existing = document.querySelector("body > .my-better-table")
    if (existing) {
        existing.remove()
    }
    let table = document.createElement("table")
    table.classList.add("my-better-table");
    table.style = "position: absolute; border-collapse: collapse; background: #27232a;";
    for (let r = 0; r < COLORS.length; r++) {
        let row = document.createElement("tr");
        table.append(row);
        for (let c = 0; c < COLORS[r].length; c++) {
            let color = COLORS[r][c];
            let td = document.createElement("td");
            td.style = "width: 20px; height: 20px; background-color: " + color;
            td.onclick = () => {
                if (c == 0) {
                    COLORS[r-1]
                    while (COLORS[r].length > 0) {
                        COLORS[r-1].push(COLORS[r].shift());
                    }
                } else {
                    let old_row = COLORS[r];
                    COLORS[r] = old_row.slice(0, c);
                    COLORS.splice(r+1, 0, old_row.slice(c));
                }
                COLORS = COLORS.filter((row) => row.length > 0);
                makeColors();
            }
            row.append(td)
        }
        document.body.append(table);

    }
}
makeColors()
