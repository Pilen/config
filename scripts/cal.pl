#!/usr/bin/perl

system("cal -w -m -3");
$a=<>;
if (lc($a) eq "y\n") {
    system("clear");
    system("cal -wmy");
    <>;
}
