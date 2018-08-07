" настройка панели с структурой кода, tagbar
let g:tagbar_sort = 0
let g:tagbar_iconchars = ['+', '-']
let g:tagbar_type_php = {
	\'ctagstype': 'php',
	\'kinds': [
		\'i:interfaces',
		\'c:classes',
		\'d:constants',
		\'f:functions'
	\]
\}

nmap <A-3> :TagbarToggle<CR>
