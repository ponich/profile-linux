" настройка цветовой схемы
let g:enable_bold_font = 1
let g:enable_italic_font = 1
set background=dark

try
    colorscheme gruvbox
    let g:gruvbox_italic=0
    let g:gruvbox_termcolors=256
    let g:gruvbox_contrast_dark='hard'
catch /^Vim\%((\a\+)\)\=:E185/
    "
endtry