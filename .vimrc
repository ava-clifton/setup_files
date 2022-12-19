" Notes on commands
" GIT note, not sure where else to put this
" git rm -r *.c       # untracks
" gf opens file at curser
" K opens python documentation under cursor
" cn cp for previous and next error in :make - or in results from grep use:
"       :grep TERM *.p
" ctrl-o is jump back (in time) , ctrl-i is jump for ward in jumplist
"
" background\033[48;5;###m
" background\033[48;5;###m

set nocompatible
set hidden


"nnoremap o ox<BS>
"nnoremap O Ox<BS>
"inoremap <CR> <CR>x<BS>


function! s:insert_iterator(property)
    let l:text = [
        \ 'for (auto it=<TMPL>.begin(); it!=<TMPL>.end(); it++) {',
        \ '}'
    \ ]
    execute "normal! o" . substitute(join(l:text, "\n"), '\C<TMPL>', a:property, 'g') . "\<Esc>"
    normal ko A
    normal x
    startinsert
endfunction

command! -nargs=1 Iter :call <SID>insert_iterator(<q-args>)

nnoremap <expr> n 'Nn'[v:searchforward]
nnoremap <expr> N 'nN'[v:searchforward]

function! Insert_Iterator(container)
    normal ofor(auto it=a:container.begin(); it!=x.end(); it++) {
    " <CR>}<ESC>ko
    set cursorline " cursorcolumn
    redraw
    exec 'sleep ' . float2nr(1) . 'm'
    sleep 1m
    set nocursorline " nocursorcolumn
    startinsert
endfunction


command! -nargs=+ GR :grep -R <args> .
" command! -nargs=1 Iter :call Insert_Iterator("<args>")

" :command -nargs=1 Inshtml :normal i You entered <args>^V<ESC>
" :command -nargs=1 Inshtml :normal i You entered <args><ESC>oo :startinsert<ESC>:insert



:source ~/.vim/plugins/ipmotion.vim
call plug#begin('~/.vim/plugged')









Plug 'prabirshrestha/vim-lsp'

if executable('pyls')
    au User lsp_setup call lsp#register_server({
        \ 'name': 'pyls',
        \ 'cmd': {server_info->['pyls']},
        \ 'allowlist': ['python'],
        \ 'whitelist': ['py'],
        \ })
endif

if executable('clangd-10')
    au User lsp_setup call lsp#register_server({
        \ 'name': 'clangd-10',
        \ 'cmd': {server_info->['clangd-10', '-background-index']},
        \ 'whitelist': ['c', 'cc', 'cpp', 'objc', 'objcpp'],
        \ })
endif
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <cr>    pumvisible() ? asyncomplete#close_popup() : "\<cr>"
noremap ? :LspWorkspaceSymbolSearch<CR>



















"autocmd VimEnter * TagbarOpen .
let g:tagbar_sort = 0
set updatetime=100
"let g:tagbar_show_tag_count = 1

" runs gutentags when in a directory with this as root - not sure of details,
" a bit worried about what happens when you have nested tags files, if you are
" in a subdirectory will it just go to the nested one ignoring the wider one?
" let g:rainbow_active = 1

let g:gutentags_project_root = ['makefile', 'Makefile']
let g:gutentags_ctags_exclude = ["*.tex", "tex", ".tex"] " For a specific bug with very long tags

au! BufRead,BufWrite,BufWritePost,BufNewFile *.org 
au BufEnter *.org            call org#SetOrgFileType()

call plug#end()

command! -nargs=+ GR :grep -R <args> .

noremap H :bprevious<CR>
noremap L :bnext<CR>
source ~/.vim/colors/molokai.vim
set clipboard+=unnamed

nnoremap p p`]<Esc>
"nnoremap <silent> e :<C-u>call append(line("."),   repeat([""], v:count1))<CR>
nnoremap <silent> e :call append(line('.'), '')<CR>
nnoremap <silent> E :call append(line('.')-1, '')<CR>
"nnoremap <silent> e o<ESC>
"nnoremap <silent> E O<ESC>j
nnoremap Q @@
inoremap <C-d> <Del>
"noremap m :VimuxRunLastCommand<CR>
"noremap M :VimuxPromptCommand<CR>
noremap <C-m> <C-o>

syntax enable
filetype plugin on
filetype plugin indent on
noremap ; :
noremap : ;
set path+=**
set clipboard=unnamedplus
"set clipboard=unnamed
au BufRead,BufNewFile *.pddl set filetype=lisp

set noruler
set laststatus=2
set statusline="%f%m%r%h%w [%Y] [0x%02.2B]%< %F%=%4v,%4l %3p%% of %L"

" allow the . to execute once for each line of a visual selection
vnoremap . :normal .<CR>

inoremap jk <ESC>
inoremap kj <ESC>
inoremap enld endl

function! Flash()
    set cursorline " cursorcolumn
    redraw
    exec 'sleep ' . float2nr(1) . 'm'
    sleep 1m
    set nocursorline " nocursorcolumn
endfunction

"highlight ExtraWhitespace ctermbg=red guibg=red
":match ExtraWhitespace /\s\+$/
":autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red

set wildmenu
set errorformat^=%-G%f:%l:\ warning:%m
" cn cp for previous and next error in :make
" command! MakeTags !ctags -R .
" turn absolute line numbers on
:set number
:set nu

" :set number relativenumber
" :set nu rnu
:highlight LineNr ctermfg=grey
"highlight LineNr term=bold cterm=NONE ctermfg=DarkGrey ctermbg=NONE gui=NONE guifg=DarkGrey guibg=NONE
set autoindent
set smartindent
set expandtab
set cindent
set tabstop=4
set shiftwidth=4

":set paste

:set hlsearch

" git signs
let g:gitgutter_enabled = 1
let g:gitgutter_highlight_lines = 1

let g:incsearch#auto_nohlsearch = 1
:set ignorecase

map n  <Plug>(incsearch-nohl-n)
map N  <Plug>(incsearch-nohl-N)
map *  <Plug>(incsearch-nohl-*)
map #  <Plug>(incsearch-nohl-#)
map g* <Plug>(incsearch-nohl-g*)
map g# <Plug>(incsearch-nohl-g#)

map /  <Plug>(incsearch-forward)
map ?  <Plug>(incsearch-backward)
map g/ <Plug>(incsearch-stay)
let g:incsearch_cli_key_mappings = {   "\<C-j>": "\<CR>", } " as mentioned in the docs for this

" copied from
" https://stackoverflow.com/questions/9065941/how-can-i-change-vim-status-line-color
function! InsertStatuslineColor(mode)
        if a:mode == 'i'
                hi statusline guibg=#333333 ctermfg=0  guifg=#A6E22E ctermbg=0
        elseif a:mode == 'r'
                hi statusline guibg=Purple ctermfg=5 guifg=Black ctermbg=0
        else
                hi statusline guibg=DarkRed ctermfg=1 guifg=Black ctermbg=0
        endif
endfunction

au InsertEnter * call InsertStatuslineColor(v:insertmode)
au InsertLeave * hi StatusLine      guifg=#455354 guibg=fg

" Formats the statusline
set statusline=%f                           " file name
"set statusline+=[%{strlen(&fenc)?&fenc:'none'}, "file encoding
"set statusline+=%{&ff}] "file format
"set statusline+=%y      "filetype
"set statusline+=%h      "help file flag
set statusline+=%m      "modified flag
set statusline+=%r      "read only flag
"set statusline+= %{taghelper#curtag()}
set statusline+=\ %=                        " align left
set statusline+=%l/%L[%p%%]            " line X of Y [percent of file]
set statusline+=\ Col:%c                    " current column
"set statusline+=\ Buf:%n                    " Buffer number
"set statusline+=\ [%b][0x%B]\               " ASCII and byte code under cursor
set statusline=%<%f\ %h%m%r\ %1*%{taghelper#curtag()}%*%=%-14.(%l,%c%V%)\ %P

let g:bufferline_echo = 0
autocmd VimEnter *
                        \ let &statusline=' %{bufferline#refresh_status()}'
                        \ .bufferline#get_status_string()
"\ '%<%f\ %h%m%r\ %1*%{taghelper#curtag()}%*%=%-14.(%l,%c%V%)\ %P'

autocmd VimEnter * set statusline+=%<%1*%{taghelper#curtag()}%*%=%-14.(%l,%c%V%)\ %P
"autocmd VimEnter * set statusline+=%<\ %h%m%r\ %1*%{taghelper#curtag()}%*%=%-14.(%l,%c%V%)\ %P

" Search for selected text, forwards or backwards.
vnoremap <silent> * :<C-U>
                        \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
                        \gvy/<C-R>=&ic?'\c':'\C'<CR><C-R><C-R>=substitute(
                        \escape(@", '/\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
                        \gVzv:call setreg('"', old_reg, old_regtype)<CR>
vnoremap <silent> # :<C-U>
                        \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
                        \gvy?<C-R>=&ic?'\c':'\C'<CR><C-R><C-R>=substitute(
                        \escape(@", '?\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
                        \gVzv:call setreg('"', old_reg, old_regtype)<CR>


:set termguicolors
" Enable true color
if exists('+termguicolors')
        let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
        let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
        set termguicolors
endif

" For the buffer switching, turning off the args stops it asking if you have
" edited all of them
au VimEnter * args %
let g:bufferline_active_buffer_left = ''
let g:bufferline_active_buffer_right = ''

" background is: #1F1F1F
highlight GitGutterAddLine ctermbg=22 guibg=#103010
highlight GitGutterChangeLine ctermbg=94
highlight GitGutterDeleteLine ctermbg=52
highlight GitGutterChangeDeleteLine ctermbg=57

highlight SignColumn guibg=#1f1f1f ctermbg=0
highlight GitGutterAdd    guifg=#1F8F1F ctermfg=2
highlight GitGutterChange guifg=#ffbd08 ctermfg=3
highlight GitGutterDelete guifg=#8F1f1f ctermfg=1

" if !exists("current_compiler")
  " compiler python
" endif

" originally, off
" https://vi.stackexchange.com/questions/2365/how-can-i-get-n-to-go-forward-even-if-i-started-searching-with-or
" nnoremap <silent><expr> n (v:searchforward ? 'n' : 'N') . ":SearchIndex<CR>"
" nnoremap <silent><expr> N (v:searchforward ? 'N' : 'n') . ":SearchIndex<CR>"

map <C-j> <CR>
noremap <C-j> <CR>
" Problematic, ok for now
":set cursorline<CR>:sleep 1m<CR>:set nocursorline<CR>

:set spell
"nnoremap ] ]s
nnoremap [ z=
nnoremap <C-k> 15k
nnoremap <C-j> 15j
" at some point was W B
nnoremap <C-l> 20l
nnoremap <C-H> 20h
nnoremap - $
vnoremap <C-k> 15k
vnoremap <C-j> 15j
vnoremap <C-l> 20l
vnoremap <C-H> 20h
vnoremap - $
"nnoremap df d$
"nnoremap yf y$
"nnoremap f $
"vnoremap f $
"nnoremap ds d0
"nnoremap ys y0
"nnoremap s 0
"vnoremap s 0



set showcmd
autocmd Filetype cpp setlocal expandtab tabstop=2 shiftwidth=2 softtabstop=2
"autocmd Filetype cpp setlocal expandtab tabstop=4 shiftwidth=4 softtabstop=4

" for org mode C-k to work, need to go into the plugin files and edit the
" bindings





"set completefunc=LanguageClient#complete
"set formatexpr=LanguageClient#textDocument_rangeFormatting_sync()
"let g:LanguageClient_completionPreferTextEdit = 1
" *g:LanguageClient_setOmnifunc*

"inoremap <F5> <C-o>:call LanguageClient#textDocument_completion()<CR>

let g:tex_comment_nospell=1
