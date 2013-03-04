
$file = `zenity --title "Select PDF" --file-selection --file-filter="*.pdf"`;
chomp $file;

if ($file) {
    `xpdf "$file" -cont -fullscreen`;
}
