" настройка php-cs-fixer, стандарт при применении форматирование
let g:php_cs_fixer_rules = "@PSR2"

nnoremap <silent><leader>phpfg :call PhpCsFixerFixDirectory()<CR>
nnoremap <silent><leader>phpf :call PhpCsFixerFixFile()<CR>
