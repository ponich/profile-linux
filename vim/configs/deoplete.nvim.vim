" настройка движка автокомплита deoplete
let g:deoplete#enable_at_startup = 1
let g:deoplete#ignore_sources = get(g:, 'deoplete#ignore_sources', {})

" настройка автокомплита для php
au User lsp_setup call lsp#register_server({
    \ 'name': 'php',
    \ 'cmd': {server_info->['php', expand('~/.vim/plugged/php-language-server/bin/php-language-server.php')]},
    \ 'whitelist': ['php'],
\ })

let g:deoplete#ignore_sources.php = ['omni']

" настройка автокомплита css, sass, scss
" npm install -g vscode-css-languageserver-bin
if executable('css-languageserver')
    au User lsp_setup call lsp#register_server({
        \ 'name': 'css-languageserver',
        \ 'cmd': {server_info->[&shell, &shellcmdflag, 'css-languageserver --stdio']},
        \ 'whitelist': ['css', 'less', 'sass'],
    \ })
endif