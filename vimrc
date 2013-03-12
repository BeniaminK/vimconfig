" ===================================================================================
" GENERAL SETTINGS
" ===================================================================================
" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible
"-------------------------------------------------------------------------------
" Enable file type detection. Use the default filetype settings.
" Also load indent files, to automatically do language-dependent indenting.
"-------------------------------------------------------------------------------
filetype  plugin on
filetype  indent on

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis | wincmd p | diffthis
endif
"
"-------------------------------------------------------------------------------
" Switch syntax highlighting on.
"-------------------------------------------------------------------------------
syntax    on            
set dictionary=$HOME/.vim/wordlists/polish.list
"-------------------------------------------------------------------------------
" Various settings
"-------------------------------------------------------------------------------
set autoindent                  " copy indent from current line
set autoread                    " read open files again when changed outside Vim
set autowrite                   " write a modified buffer on each :next , ...
set backspace=indent,eol,start  " backspacing over everything in insert mode
set backup                      " keep a backup file
set browsedir=current           " which directory to use for the file browser
set complete+=k                 " scan the files given with the 'dictionary' option
set display+=lastline           "
set expandtab                   " use spaces to insert a <Tab>
set history=50                  " keep 50 lines of command line history
set hlsearch                    " highlight the last used search pattern
set incsearch                   " do incremental searching
set laststatus=2                "
set listchars=tab:>.,eol:\$     " strings to use in 'list' mode
set mouse=a                     " enable the use of the mouse
set nowrap                      " do not wrap lines
set nobackup		                " do not keep a backup file, use versions instead
set nrformats-=octal            " 
set number                      " precede each line with its line number
set popt=left:8pc,right:3pc     " print options
set ruler                       " show the cursor position all the time
set shiftwidth=2                " number of spaces to use for each step of indent
set showcmd                     " display incomplete commands
set smartindent                 " smart autoindenting when starting a new line
set tabstop=2                   " number of spaces that a <Tab> counts for
set visualbell                  " visual bell instead of beeping
set wildignore=*.bak,*.o,*.e,*~ " wildmenu: ignore these extensions
set wildmenu                    " command-line completion in an enhanced mode
set scrolloff=1                 "
set shiftround                  " 
set showmatch                   " when a bracket is inserted, jump to the matching one
set sidescrolloff=5             "
set smarttab                    " 
set ttimeout                    " 
set ttimeoutlen=50              " 

"===================================================================================
" BUFFERS, WINDOWS
"===================================================================================
"
"-------------------------------------------------------------------------------
" Fast switching between buffers
" The current buffer will be saved before switching to the next one.
" Choose :bprevious or :bnext
"-------------------------------------------------------------------------------
"
 map  <silent> <s-tab>  <Esc>:if &modifiable && !&readonly && 
     \                  &modified <CR> :write<CR> :endif<CR>:bprevious<CR>
imap  <silent> <s-tab>  <Esc>:if &modifiable && !&readonly && 
     \                  &modified <CR> :write<CR> :endif<CR>:bprevious<CR>
 noremap  <silent> <s-tab>       :if &modifiable && !&readonly && 
     \                      &modified <CR> :write<CR> :endif<CR>:bprevious<CR>
inoremap  <silent> <s-tab>  <C-C>:if &modifiable && !&readonly && 
     \                      &modified <CR> :write<CR> :endif<CR>:bprevious<CR>
"
"-------------------------------------------------------------------------------
" When editing a file, always jump to the last known cursor position.
" Don't do it when the position is invalid or when inside an event handler
" (happens when dropping a file on gvim).
"-------------------------------------------------------------------------------
if has("autocmd")
  autocmd BufReadPost *
        \ if line("'\"") > 0 && line("'\"") <= line("$") |
        \   exe "normal! g`\"" |
        \ endif 
" Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!
        
endif " has("autocmd")
"
"-------------------------------------------------------------------------------
"  some additional hot keys
"-------------------------------------------------------------------------------
"    F2   -  write file without confirmation
"    F3   -  call file explorer Ex
"    F4   -  show tag under curser in the preview window (tagfile must exist!)
"    F5   -  open quickfix error window
"    F6   -  close quickfix error window
"    F7   -  display previous error
"    F8   -  display next error   
"-------------------------------------------------------------------------------
"
map   <silent> <F2>        :write<CR>
map   <silent> <F3>        :Explore<CR>
nmap  <silent> <F4>        :exe ":ptag ".expand("<cword>")<CR>
map   <silent> <F5>        :copen<CR>
map   <silent> <F6>        :cclose<CR>
map   <silent> <F7>        :cp<CR>
map   <silent> <F8>        :cn<CR>
"
imap  <silent> <F2>   <Esc>:write<CR>
imap  <silent> <F3>   <Esc>:Explore<CR>
imap  <silent> <F4>   <Esc>:exe ":ptag ".expand("<cword>")<CR>
imap  <silent> <F5>   <Esc>:copen<CR>
imap  <silent> <F6>   <Esc>:cclose<CR>
imap  <silent> <F7>   <Esc>:cp<CR>
imap  <silent> <F8>   <Esc>:cn<CR>
"
"-------------------------------------------------------------------------------
" Leave the editor with Ctrl-q : Write all changed buffers and exit Vim
"-------------------------------------------------------------------------------
nmap  <C-q>    :wqa<CR>
"
"-------------------------------------------------------------------------------
" comma always followed by a space
"-------------------------------------------------------------------------------
inoremap  ,  ,<Space>

"-------------------------------------------------------------------------------
" Change the working directory to the directory containing the current file
"-------------------------------------------------------------------------------
autocmd BufEnter * :lchdir %:p:h
"
"===================================================================================
" VARIOUS PLUGIN CONFIGURATIONS
"===================================================================================
 noremap <silent> <F9>  <Esc><Esc>:Tlist<CR>
inoremap <silent> <F9>  <Esc><Esc>:Tlist<CR>

let Tlist_GainFocus_On_ToggleOpen = 1
let Tlist_Close_On_Select 				= 1
" Don't use Ex mode, use Q for formatting
map Q gq
"
let tlist_make_settings  = 'make;m:makros;t:targets'
" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" Dla scons.vim
au BufNewFile, BufRead SCons* set filetype=scons 
" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
  set mouse=v
endif

" Beniamin Kalinowski - added support for bash-support
let g:BASH_AuthorName   = 'Beniamin Kalinowski'
let g:BASH_Email        = 'beniamin(dot)kalinowski(at)gmail(dot)com'
let g:BASH_Company      = 'OpenSource private'

" Pathogen - options:
call pathogen#infect()
:Helptags

" Thesaurus
let g:thesaurus_file = '/usr/share/myspell/dicts/th_en_US_v2'

" Use <C-L> to clear the highlighting of :set hlsearch.
if maparg('<C-L>', 'n') ==# ''
  nnoremap <silent> <C-L> :nohlsearch<CR><C-L>
endif


if &listchars ==# 'eol:$'
  set listchars=tab:>\ ,trail:-,extends:>,precedes:<,nbsp:+
  if &termencoding ==# 'utf-8' || &encoding ==# 'utf-8'
    let &listchars = "tab:\u21e5 ,trail:\u2423,extends:\u21c9,precedes:\u21c7,nbsp:\u26ad"
  endif
endif


" Allow color schemes to do bright colors without forcing bold.
if &t_Co == 8 && $TERM !~# '^linux'
  set t_Co=16
endif

if !exists('g:netrw_list_hide')
  let g:netrw_list_hide = '^\.,\~$,^tags$'
endif

" Load matchit.vim, but only if the user hasn't installed a newer version.
if !exists('g:loaded_matchit') && findfile('plugin/matchit.vim', &rtp) ==# ''
  runtime! macros/matchit.vim
endif

""""""""""""""""""" bash-support
nnoremap Y y$

""""""""""""""""""" PROTO
augroup filetype
  au! BufRead,BufNewFile *.proto setfiletype proto
augroup end
