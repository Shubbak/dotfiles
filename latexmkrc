$pdf_mode = 4;
$pdflatex = 'lualatex -shell-escape -interaction=nonstopmode -halt-on-error -synctex=1 %O %S';
$pdf_previewer = 'zathura %O %S';
$bibtex_use = 1.5;
$out_dir = "technical/build";
$silent = 1;
$clean_ext = "bbl run.xml auxlock";
$show_time = 1;

