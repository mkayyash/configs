" Modified from https://github.com/amix/vimrc
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Plugin Manager Related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
packadd minpac
call minpac#init()
command! PackUpdate call minpac#update()
command! PackClean call minpac#clean()
" Pathogen init
"execute pathogen#infect()
"syntax on
"filetype plugin indent on

" The main vim package manager
call minpac#add('k-takata/minpac')
"For toggling the display of the quickfix list and the location-list
call minpac#add('Valloric/ListToggle')
" Running ack grep search
call minpac#add('mileszs/ack.vim')
" Filesystem navigation
" Must install ruby on system and must compile and make ruby package of bundle
" Follow :h command-t for installation instructions
call minpac#add('wincent/command-t')
" Nice vim footer
call minpac#add('bling/vim-airline')
" Advanced directory explorer
call minpac#add('scrooloose/nerdtree')
" Universal Ctags (good support for js ES6)
call minpac#add('universal-ctags/ctags')
" Syntax checking in vim
call minpac#add('vim-syntastic/syntastic')
" Nice ctag explorer for each file
" Must install universal-ctags on system
" brew install --HEAD universal-ctags/universal-ctags/universal-ctags
call minpac#add('majutsushi/tagbar')
" Phrase related utils. Maily the advanced :S/Pattern/NewPattern/g
call minpac#add('tpope/vim-abolish')
" Command line git wrapper
call minpac#add('tpope/vim-fugitive')
" Allows commenting/uncommenting lines by \\<motion>
call minpac#add('tpope/vim-commentary')
" I use it for Alternate files (code & test)
" e.g. .projections.json:
"{
"   \"app/models/*.js": {
"       \"type": \"model",
"       \"alternate": \"tests/unit/models/{}-test.js"
"   },
"   \"tests/unit/models/*-test.js": {
"       \"type": \"modelTest",
"       \"alternate": \"app/models/{}.js"
"   },
"}
" Run :A to jump to a file's alternate
call minpac#add('tpope/vim-projectionist')
" Allows jumping around in a file based on indentation using [= for example
call minpac#add('jeetsukumaran/vim-indentwise')
" TODO: Need YCM or something similar to make those two work
call minpac#add('SirVer/ultisnips')
call minpac#add('honza/vim-snippets')
call minpac#add('Shougo/deoplete.nvim')
" call minpac#add('ternjs/tern_for_vim')
" call minpac#add('carlitux/deoplete-ternjs')
call minpac#add('leafgarland/typescript-vim')
call minpac#add('peitalin/vim-jsx-typescript')
" Activates buffer navigation with [b also similarly [a, [q, [l and [t for
" argument, quickfix, location and tag lists.
call minpac#add('tpope/vim-unimpaired')

let g:deoplete#enable_at_startup = 1
autocmd FileType python nnoremap <leader>y :0,$!yapf<Cr>
autocmd CompleteDone * pclose " To close preview window of deoplete automagically

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Sets how many lines of history VIM has to remember
set history=1000

" Enable filetype plugins
filetype plugin on
filetype indent on

" Set to auto read when a file is changed from the outside
set autoread

" With a map leader it's possible to do extra key combinations
" like <leader>w saves the current file
let mapleader = ","
let g:mapleader = ","

" Preserve reverse character search with \
noremap \ ,

" Fast saving
nmap <leader>w :w!<cr>

" Close window
nmap <leader>q :q<cr>

" Enable syntax highlight.
syntax on

" Recursively lookup for a ctags tag file.
set tags=tags;

" Shows lines selected in visual mode (and more).
set showcmd

" Remove trailing whitespaces"
nnoremap <Leader>rtw :%s/\s\+$//e<CR>

" Treat all numbers as decimals.
set nrformats=

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => VIM user interface
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Turn on the WiLd menu
set wildmenu
set wildmode=list:longest,full

" Ignore compiled files
set wildignore=*.o,*.so,*~,*.pyc,*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store

"Always show current position
set ruler

" Height of the command bar
set cmdheight=1

" A buffer becomes hidden when it is abandoned
set hid

" Configure backspace so it acts as it should act
set backspace=eol,start,indent
set whichwrap+=<,>,h,l

" Ignoring case by default
set ignorecase

" Better search.
set smartcase

" Highlight search results
set hlsearch

" Makes search act like search in modern browsers
set incsearch

" Don't redraw while executing macros (good performance config)
set lazyredraw

" For regular expressions turn magic on
set magic

" Show matching brackets when text indicator is over them
set showmatch
" How many tenths of a second to blink when matching brackets
set mat=2

" No annoying sound on errors
set noerrorbells
set novisualbell
set t_vb=
set tm=500


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Colors and Fonts
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Enable syntax highlighting
syntax enable

colorscheme elflord
set background=dark

" Set extra options when running in GUI mode
if has("gui_running")
    set guioptions-=T
    set guioptions+=e
    set t_Co=256
    set guitablabel=%M\ %t
endif

" Set utf8 as standard encoding and en_US as the standard language
set encoding=utf8

" Use Unix as the standard file type
set ffs=unix,dos,mac


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Text, tab and indent related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Use spaces instead of tabs
set expandtab

" Be smart when using tabs ;)
set smarttab

" 1 tab == 4 spaces
set shiftwidth=4
set tabstop=4

set ai "Auto indent
set si "Smart indent
set wrap "Wrap lines

" Change default tab settings based on file extension
augroup FileTypeTabRules
    autocmd!
    autocmd BufRead,BufNewFile *.pug,*.jade setlocal tabstop=2 shiftwidth=2
augroup END

" Red highlight >80 character lines
augroup FileTypeLengthRules
    autocmd BufWinEnter *.js,*.pug,*.jade let w:m1=matchadd('ErrorMsg', '\%>80v.\+', -1)

" Highlight trailing whitespaces.
"match ErrorMsg '\s\+$'

augroup HighlightWhitespace
    " Ignore whitespace on those files
    autocmd BufWinEnter *.md,*.pug let b:md_file=1
    " Apply whitespace on everything else
    autocmd BufWinEnter * if ! exists('b:md_file') | let w:m1=matchadd('ErrorMsg', '\s\+$', -1) | endif

""""""""""""""""""""""""""""""
" => Visual mode related
""""""""""""""""""""""""""""""
" Visual mode pressing * or # searches for the current selection
" Super useful! From an idea by Michael Naumann
vnoremap <silent> * :call VisualSelection('f')<CR>
vnoremap <silent> # :call VisualSelection('b')<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Moving around, tabs, windows and buffers
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Disable highlight when <leader><cr> is pressed
map <silent> <leader><cr> :noh<cr>

" Smart way to move between windows
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" Close the current buffer
" map <leader>bd :Bclose<cr>

" Close all the buffers
" map <leader>ba :1,1000 bd!<cr>

" Useful mappings for managing tabs
map <leader>tn :tabnew<cr>
map <leader>to :tabonly<cr>
map <leader>tc :tabclose<cr>

" Opens a new tab with the current buffer's path
" Super useful when editing files in the same directory
map <leader>te :tabedit <c-r>=expand("%:p:h")<cr>/

" Switch CWD to the directory of the open buffer
map <leader>cd :cd %:p:h<cr>:pwd<cr>

" Specify the behavior when switching between buffers
try
  set switchbuf=useopen,usetab,newtab
  set stal=2
catch
endtry

" Return to last edit position when opening files (You want this!)
autocmd BufReadPost *
     \ if line("'\"") > 0 && line("'\"") <= line("$") |
     \   exe "normal! g`\"" |
     \ endif
" Remember info about open buffers on close
set viminfo^=%

""""""""""""""""""""""""""""""
" => Status line
""""""""""""""""""""""""""""""
" Always show the status line
set laststatus=2

" Format the status line
set statusline=\ %{HasPaste()}%F%m%r%h\ %w\ %r%{getcwd()}%h\ %w\ \(%l,%c\)

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Editing mappings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Remap VIM 0 to first non-blank character
map 0 ^

" Move a line of text using CTRL+[jk] in visual mode
"vmap <C-j> :m'>+<cr>`<my`>mzgv`yo`z
"vmap <C-k> :m'<-2<cr>`>my`<mzgv`yo`z

" Delete trailing white space on save, useful for Python and CoffeeScript
func! DeleteTrailingWS()
  exe "normal mz"
  %s/\s\+$//ge
  exe "normal `z"
endfunc
autocmd BufWrite *.py :call DeleteTrailingWS()
autocmd BufWrite *.coffee :call DeleteTrailingWS()


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => vimgrep searching and cope displaying
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" When you press gv you vimgrep after the selected text
vnoremap <silent> gv :call VisualSelection('gv')<CR>

" Open vimgrep and put the cursor in the right position
map <leader>g :vimgrep // **/*<left><left><left><left><left>

" Vimgreps in the current file
map <leader><space> :vimgrep // <C-R>%<C-A><right><right><right><right><right><right><right><right><right>

" When you press <leader>r you can search and replace the selected text
vnoremap <silent> <leader>r :call VisualSelection('replace')<CR>
vnoremap <silent> <leader>R :call VisualSelection('replaceSubvert')<CR>

" Do :help cope if you are unsure what cope is. It's super useful!
"
" When you search with vimgrep, display your results in cope by doing:
"   <leader>cc
"
" To go to the next search result do:
"   <leader>n
"
" To go to the previous search results do:
"   <leader>p
"
"OBSOLETED with ListToggle Plugin
"map <leader>cc :call ToggleQuickFixWindow()<cr>
map <leader>co ggVGy:tabnew<cr>:set syntax=qf<cr>pgg
map <leader>n :cn<cr>
map <leader>p :cp<cr>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Spell checking
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Pressing ,ss will toggle and untoggle spell checking
map <leader>ss :setlocal spell!<cr>

" Shortcuts using <leader>
map <leader>sn ]s
map <leader>sp [s
map <leader>sa zg

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Misc
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Remove the Windows ^M - when the encodings gets messed up
"noremap <Leader>m mmHmt:%s/<C-V><cr>//ge<cr>'tzt'm

" Toggle paste mode on and off
map <leader>pp :setlocal paste!<cr>

" Remap jj to escape in insert mode.
inoremap jj <Esc>

" Count search instances
map <Leader>o :%s///n<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Helper functions
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! QuickFixWindowOpened()
    for nr in range(1, winnr('$'))
        let bnum = winbufnr(nr)
        if getbufvar(bnum, '&buftype') == 'quickfix'
            " found a quickfix
            return 1
        endif
    endfor
    return 0
endfunction

function! PreviewWindowOpened()
    for nr in range(1, winnr('$'))
        if getwinvar(nr, "&pvw") == 1
            " found a preview
            return 1
        endif
    endfor
    return 0
endfunction

function! ToggleQuickFixWindow()
    if QuickFixWindowOpened()
        execute ":ccl"
    else
        execute ":botright copen"
    endif
endfunction

function! TogglePreviewWindow()
    if PreviewWindowOpened()
        execute ":pclose"
    else
        execute ":YcmCompleter GetDoc"
    endif
endfunction

" Enables/Disables Syntastic highlights by checking for signs in buffer
function! ToggleSyntastic()
   let l:currentBufNum = bufnr("%")

   let l:res = execute(":sign place buffer=".l:currentBufNum)
   if l:res =~"Signs for"
       execute ":SyntasticReset"
   else
       execute ":SyntasticCheck"
   endif
endfunction

function! CmdLine(str)
    exe "menu Foo.Bar :" . a:str
    emenu Foo.Bar
    unmenu Foo
endfunction

function! VisualSelection(direction) range
    let l:saved_reg = @"
    execute "normal! vgvy"

    let l:pattern = escape(@", '\\/.*$^~[]')
    let l:pattern = substitute(l:pattern, "\n$", "", "")

    if a:direction == 'b'
        execute "normal ?" . l:pattern . "^M"
    elseif a:direction == 'gv'
        call CmdLine("vimgrep " . '/'. l:pattern . '/' . ' **/*')
    elseif a:direction == 'replace'
        call CmdLine("%s" . '/'. l:pattern . '/')
    elseif a:direction == 'replaceSubvert'
        call CmdLine("%S" . '/'. l:pattern . '/')
    elseif a:direction == 'f'
        execute "normal /" . l:pattern . "^M"
    endif

    let @/ = l:pattern
    let @" = l:saved_reg
endfunction


" Returns true if paste mode is enabled
function! HasPaste()
    if &paste
        return 'PASTE MODE  '
    en
    return ''
endfunction

" Don't close window, when deleting a buffer
command! Bclose call <SID>BufcloseCloseIt()
function! <SID>BufcloseCloseIt()
   let l:currentBufNum = bufnr("%")
   let l:alternateBufNum = bufnr("#")

   if buflisted(l:alternateBufNum)
     buffer #
   else
     bnext
   endif

   if bufnr("%") == l:currentBufNum
     new
   endif

   if buflisted(l:currentBufNum)
     execute("bdelete! ".l:currentBufNum)
   endif
endfunction

command! -nargs=0 -bar Qargs execute 'args' QuickfixFilenames()
function! QuickfixFilenames()
    let buffer_numbers = {}
    for quickfix_item in getqflist()
        let buffer_numbers[quickfix_item['bufnr']] = bufname(quickfix_item['bufnr'])
    endfor
    return join(map(values(buffer_numbers), 'fnameescape(v:val)'))
endfunction

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Autocomplete and YCM Plugin Related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Keys for Definition and Reference identifier lookup
nnoremap <C-]> :YcmCompleter GoTo<CR>
nnoremap <C-\> :YcmCompleter GoToReferences<CR>
nnoremap <silent> <leader>d :call TogglePreviewWindow()<CR>

"let g:ycm_python_binary_path = '/usr/local/bin/python3'
let g:ycm_auto_trigger = 1
set completeopt-=preview
"let g:ycm_add_preview_to_completeopt = 1
"let g:ycm_autoclose_preview_window_after_insertion = 1
"let g:ycm_extra_conf_globlist = ['~/src/*','!~/*']
"set splitbelow
"set splitright

set pumheight=15

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => NERDTree Related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nmap <silent> <Leader>ee :NERDTreeToggle<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Command-T and File Lookup Related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nmap <silent> <Leader>f <Plug>(CommandT)

augroup CommandTExtension
    autocmd!
    autocmd FocusGained * CommandTFlush
    autocmd BufWritePost * CommandTFlush
augroup END

" Use %% in command line mode to get current directory
cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h').'/' : '%%'

" Command line mode naviation similar to terminal
" Refer to :h cmdline-editing for defaults
" Type: sed -n l in command line to test keys
" ^A   ^E      ^[b    ^[f
cnoremap <C-A> <Home>
cnoremap <C-E> <End>
" TODO: For some reason since <option-left> maps to <Esc>b on mac but not here.
" Same with <option>right.
cnoremap <Esc>b <S-Left>
cnoremap <Esc>f <S-Right>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Tagbar related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Control toggling the tagbar
nmap <silent> <leader>tt :TagbarToggle<CR>
let g:tagbar_sort = 0

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Snippets Related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:UltiSnipsExpandTrigger="<c-j>"
let g:UltiSnipsJumpForwardTrigger="<c-j>"
let g:UltiSnipsJumpBackwardTrigger="<c-k>"
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => ListToggle Related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:lt_location_list_toggle_map = '<leader>ll'
let g:lt_quickfix_list_toggle_map = '<leader>cc'
"let g:lt_height = 10

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Syntastic Related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Common settings
"let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" JS specific settings
let g:syntastic_javascript_checkers=['eslint']

" Set make to call "npm run lintall" for js projects only
augroup LintAllForNodeJs
    autocmd FileType javascript setlocal errorformat=%f:\ line\ %l\\,\ col\ %c\\,\ %trror\ -\ %m,\%f:\ line\ %l\\,\ col\ %c\\,\ %tarning\ -\ %m,\%-G%.%#
    autocmd FileType javascript setlocal makeprg=npm\ run\ lintall\ -s\

autocmd VimEnter * silent! SyntasticToggleMode
map <silent> <leader>mm :call ToggleSyntastic()<CR>
"map <leader>m :SyntasticCheck<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Navigation Related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" TODO: Make this work when there are no more levels to jump to.
" in that case we should just do a [=
nnoremap <silent> [[ :norm [-<CR>
nnoremap <silent> ]] :norm ]-<CR>
