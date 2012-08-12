#!/usr/bin/perl

#$browser = "firefox --new-window";
$browser = "chromium --new-window";

@pages = ("en.wikipedia.org",
          "da.wikipedia.org",
          "reddit.com/r/programming",
          "google.com",
          "en.wikibooks.org/wiki/LaTeX",
          "reddit.com",
          "reddit.com/r/emacs",
          "reddit.com/r/python",
          "pol.dk");

$pages = join("\n",@pages);
$result = `echo "$pages" | dmenu -i`;
if ($result){
    exec("$browser $result");
}

