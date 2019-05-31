set visualbell
set cursorline
set autochdir

" Use a font that supports a wider range of UTF-8 characters
if has("gui_running")
  set guifont=Fira\ Code\ 12
  set guifontwide=DejaVu\ Sans\ Mono\ 12
endif

" Complete options (disable preview scratch window)
set completeopt=menu,menuone,longest

" Limit popup menu height
set pumheight=15

" Git gutter update more quickly
set updatetime=250

set wildignore+=*/target/*

" Make the colorcolumn a little less severe.
highlight ColorColumn ctermbg=238
highlight ColorColumn guibg=#444444

"colorscheme desert
colorscheme zenburn
"let g:airline_theme='zenburn'
"Make gitcommit tw play nice with gerrit
autocmd filetype svn,*commit* setlocal tw=70

" Open nerdtree when opening dir
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | exe 'cd '.argv()[0] | endif

" Real man's escape in insert mode
inoremap jj <ESC>
inoremap jk <ESC>
inoremap kj <ESC>

" C-j/C-k as :bn/:bp bindings.
nnoremap <C-j> :bn<CR>
nnoremap <C-k> :bp<CR>

" Grep for the word under the cursor (gw is *exactly* the word), don't show the
" full screen results, don't auto open in the current window, open the results,
" redraw because terminals are awful, switch back to previously selected window.
nnoremap gr :silent grep! <cword> *<CR>:copen<CR>:redraw!<CR>:winc p<CR>
nnoremap gw :silent grep! '\b<cword>\b' *<CR>:copen<CR>:redraw!<CR>:winc p<CR>

" Alias `p` to the movement `i(`
onoremap p i(

" Make [[ and friends behave with K&R
map [[ ?{<CR>w99[{
map ][ /}<CR>b99]}
map ]] j0[[%/{<CR>
map [] k$][%?}<CR>

" Code formatter keybinds/settings
"map <C-K> :pyf /usr/local/Cellar/clang-format/2018-12-18/share/clang/clang-format.py<CR>
"imap <C-K> <c-o>:pyf /usr/local/Cellar/clang-format/2018-12-18/share/clang/clang-format.py<cr>
let g:formatdef_yapf = "'yapf -l '.a:firstline.'-'.a:lastline"
let g:formatters_python = ['yapf']
map <C-K> :Autoformat<CR>


" clang_complete
" Show clang errors in the quickfix window
let g:clang_complete_copen=1
"let g:clang_periodic_quickfix=1
" Disable auto popup, use <Tab> to autocomplete
let g:clang_complete_auto=0
" Close preview window after completion
let g:clang_close_preview=1
let g:clang_library_path = '/usr/local/lib'

" SuperTab option for context aware completion
let g:SuperTabDefaultCompletionType="context"


"" Syntastic settings
"" Always update the location list on write
"let g:syntastic_always_populate_loc_list = 1
"" Open the location list
"let g:syntastic_auto_loc_list = 1
"let g:syntastic_check_on_open = 0
"let g:syntastic_check_on_wq = 0
"" Assume clang with C++11 for C++.
"let g:syntastic_cpp_compiler = 'clang++'
"let g:syntastic_cpp_compiler_options = ' -std=c++11 -stdlib=libc++'
"" Use cpplint, clang_check, and clang_tidy
""let g:syntastic_cpp_checkers = ['cpplint', 'clang_check', 'clang_tidy']
"let g:syntastic_cpp_checkers = ['cpplint']
"" Use pylint instead of pyflakes.
"let g:syntastic_python_checkers = ['pylint', 'pep8']

" Asynchronous Lint Engine settings
let g:ale_open_list = 1
let g:ale_completion_enabled = 1
let g:ale_lint_on_text_changed = 'never'
let g:ale_set_loclist = 0
let g:ale_set_quickfix = 1

" Snippet and keybindings
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-j>"
let g:UltiSnipsJumpBackwardTrigger="<c-k>"

"" Configure Language Server Protocol, LSP
"" let g:LanguageClient_autoStart = 0
"let g:LanguageClient_serverCommands = {
    "\ 'rust': ['~/.cargo/bin/rustup', 'run', 'nightly-2018-12-06', 'rls'],
    "\ 'python': ['~/.local/bin/pyls'],
    "\ }
"nnoremap <silent> R :call LanguageClient_textDocument_rename()<CR>
"nnoremap <silent> K :call LanguageClient#textDocument_hover()<CR>
"nnoremap <silent> gd :call LanguageClient#textDocument_definition()<CR>
"nnoremap <silent> <F2> :call LanguageClient#textDocument_rename()<CR>
"nnoremap <leader>lcs :LanguageClientStart<CR>
"let g:completor_racer_binary = "~/.cargo/bin/racer"

if &term =~ '^screen'
    " tmux will send xterm-style keys when its xterm-keys option is on
    execute "set <xUp>=\e[1;*A"
    execute "set <xDown>=\e[1;*B"
    execute "set <xRight>=\e[1;*C"
    execute "set <xLeft>=\e[1;*D"
endif

" Shortcuts for quick access to config.
"    :Ef - Edit the ftplugin file that matches the current file.
"    :Ev - Edit the vimrc.
"    :Sv - Source the vimrc.
function! EditFtpluginForCurrentFile()
       exec "edit ~/.vim/ftplugin/" . &ft . ".vim"
endfunction
command! Ef call EditFtpluginForCurrentFile()

function! EditVimrc()
       split $MYVIMRC
endfunction
command! Ev call EditVimrc()

function! SourceVimrc()
       source $MYVIMRC
endfunction
command! Sv call SourceVimrc()
