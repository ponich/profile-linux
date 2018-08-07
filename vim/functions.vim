" подключения файла конфигурации
function! LoadSourceFile(src)
    let s:file =  a:src

    if filereadable(s:plugin_config)
        exec "source " . s:file
    endif
endfunction

"
function! PlugCond(cond, ...)
  let opts = get(a:000, 0, {})
  return a:cond ? opts : extend(opts, { 'on': [], 'for': [] })
endfunction

"
function! PlugConfigure()
    for plugin in keys(g:plugs)
        let s:plugin_config = $PROFILE_ROOT_PATH . '/vim/configs/' . plugin . '.vim'
        call LoadSourceFile(s:plugin_config)
    endfor
endfunction

" автоустановка плагинов
if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" исправления проблемы отображения цветовой схемы
if &term =~ "xterm"
    "256 color —
    let &t_Co=256
    " restore screen after quitting
    set t_ti="ESC7ESC[rESC[?47h t_te=ESC[?47lESC8"
    if has("terminfo")
        let &t_Sf="ESC[3%p1%dm"
        let &t_Sb="ESC[4%p1%dm"
    else
        let &t_Sf="ESC[3%dm"
        let &t_Sb="ESC[4%dm"
    endif
endif
