#!/usr/bin/perl

system("cal -m -3");
$a=<>;
if (lc($a) eq "y\n") {
    system("clear");
    system("cal -y");
    <>;
}
