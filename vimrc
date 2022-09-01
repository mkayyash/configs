"""""""""""""""""""""""""""
" => Plugin Manager Related
"""""""""""""""""""""""""""
packadd minpac
call minpac#init()
command! PackUpdate call minpac#update()
command! PackClean call minpac#clean()

" The main vim package manager
call minpac#add('k-takata/minpac')
" Start screen
call minpac#add('mhinz/vim-startify')
"For toggling the display of the quickfix list and the location-list
call minpac#add('Valloric/ListToggle')
" Running ack grep search
" NOTE: must install ack in system.
call minpac#add('mileszs/ack.vim')
" Filesystem navigation (Fuzzy finding).
" NOTE: Must install on command line first in homebrew:
" brew install fzf
" $(brew --prefix)/opt/fzf/install
call minpac#add('junegunn/fzf')
call minpac#add('junegunn/fzf.vim')
" Nice vim footer
call minpac#add('vim-airline/vim-airline')
" Advanced directory explorer
call minpac#add('scrooloose/nerdtree')
" Universal Ctags (good support for js ES6)
call minpac#add('universal-ctags/ctags')
" Syntax checking in vim
call minpac#add('vim-syntastic/syntastic')
" Nice ctag explorer for each file
" NOTE: Must install universal-ctags on system
" brew install --HEAD universal-ctags/universal-ctags/universal-ctags
call minpac#add('preservim/tagbar')
" Phrase related utils. Maily the advanced :S/Pattern/NewPattern/g
call minpac#add('tpope/vim-abolish')
" Command line git wrapper
call minpac#add('tpope/vim-fugitive')
" Allows commenting/uncommenting lines with gc
call minpac#add('tpope/vim-commentary')
" Run :A to jump to a file's alternate
call minpac#add('tpope/vim-projectionist')
" Allows jumping around in a file based on indentation using [= for example
call minpac#add('jeetsukumaran/vim-indentwise')
" Activates buffer navigation with [b also similarly [a, [q, [l and [t for
" argument, quickfix, location and tag lists.
call minpac#add('tpope/vim-unimpaired')
" Code completion.
" NOTE: Need to run a few commands afterwards:
" npm install -g neovim
" cd ~/.vim/pack/minpac/start/coc.nvim/
" yarn install && yarn build
" NOTE: On ubuntu it may be yarnpkg and not yarn
" Then we ln copy the backed up coc-settings.
" cd ~/.config/nvim/ && ln -s ~/src/configs/coc-settings.json .
" We also copy the clangd/config.yaml file which is the global configs for
" clangd projects.
" ln -s ~/src/configs/clangd_config.yaml ~/.config/clangd/config.yaml
" TODO: Make script to initialize nvim in both ubuntu and mac.
call minpac#add('neoclide/coc.nvim')
" NOTE: To install, we need first a dev icon installed:
" brew tap homebrew/cask-fonts && brew install --cask font-hack-nerd-font
" Edit iTerm2 to make the 'Hack' font the Non-ASCII font. OR import the
" iTerm.json profile from ~/src/configs
call minpac#add('ryanoasis/vim-devicons')
" vim buffet TODO(describe).
" call minpac#add('bagrat/vim-buffet')
" fixes language specific formatting for code. TODO(describe).
call minpac#add('sheerun/vim-polyglot')
call minpac#add('joshdick/onedark.vim')
call minpac#add('srcery-colors/srcery-vim')
call minpac#add('ayu-theme/ayu-vim')
call minpac#add('morhetz/gruvbox')
call minpac#add('ghifarit53/tokyonight-vim')
call minpac#add('tomasiser/vim-code-dark')
call minpac#add('lucasprag/simpleblack')
call minpac#add('nanotech/jellybeans.vim')
call minpac#add('ackyshake/Spacegray.vim')
call minpac#add('sainnhe/gruvbox-material')
call minpac#add('tomasiser/vim-code-dark')

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
" => Text, tab and indent related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

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
" => Ack grep searching and cope displaying
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" When you press gv you vimgrep after the selected text
vnoremap <silent> gv :call VisualSelection('gv')<CR>

" Open vimgrep and put the cursor in the right position
map <leader>g :Ack 

" Vimgreps in the current file
" map <leader><space> :vimgrep // <C-R>%<C-A><right><right><right><right><right><right><right><right><right>


" When you press <leader>r you can search and replace the selected text
" NOTE(mkayyash): For some reason VisualSelection is no longer working.
" vnoremap <silent> <leader>r :call VisualSelection('replace')<CR>
vmap <leader>r "hy:%s/\<<C-r>h\>//g<left><left>
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
" => COC Autocomplete
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Check the :CocConfig file for custom changes.
let g:coc_global_extensions = [
  \ 'coc-snippets',
  \ 'coc-tsserver',
  \ 'coc-json',
  \ 'coc-css',
  \ 'coc-eslint',
  \ 'coc-prettier',
  \ 'coc-clangd',
  \ 'coc-solidity',
  \ 'coc-highlight',
  \ ]

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1):
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice.
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call ShowDocumentation()<CR>

function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>do  :norm 0<leader>aj<CR>

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
" TODO(mkayyash): These 2 doesn't work right.
" nmap <leader>qf  <Plug>(coc-fix-current)
" Run the Code Lens action on the current line.
" nmap <leader>cl  <Plug>(coc-codelens-action)

" Remap <C-f> and <C-b> for scroll float windows/popups.
if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of language server.
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocActionAsync('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocActionAsync('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings for CoCList
" Show all diagnostics.
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Resume latest coc list.
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>

" Use <C-j> for jump to next placeholder, it's default of coc.nvim
let g:coc_snippet_next = '<c-j>'

" Use <C-k> for jump to previous placeholder, it's default of coc.nvim
let g:coc_snippet_prev = '<c-k>'

" Maybe fixes the cursos from changing randomly.
let g:coc_disable_transparent_cursor = 1

" NOTE: To update the config.yaml globally or per-project do:
" :CocCommand clangd.userConfig
" :CocCommand clangd.projectConfig

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => NERDTree Related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nmap <silent> <Leader>F :NERDTreeToggle<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => FZF and File Lookup Related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nmap <silent> <Leader>f :FZF<CR>
nmap <silent> <Leader>tt :BTags<CR>
nmap <silent> <Leader>u :Tags<CR>

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
nmap <silent> <leader>T :TagbarToggle<CR>
let g:tagbar_autofocus = 1
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

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => C++ related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
map <leader>c :! g++ -std=c++11 % -o out && ./out<cr>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Theme/ColorScheme related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Use 24-bit (true-color) mode in Vim/Neovim even in tmux.
" Assumes tmux version 2.2 or later.
" (see < http://sunaku.github.io/tmux-24bit-color.html#usage > for more information.)
if (has("nvim"))
  "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
  let $NVIM_TUI_ENABLE_TRUE_COLOR=1
endif
"For Neovim > 0.1.5 and Vim > patch 7.4.1799 < https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162 >
"Based on Vim patch 7.4.1770 (`guicolors` option) < https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd >
" < https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >
if (has("termguicolors"))
  set termguicolors
endif

syntax on
"let g:airline_theme='onedark'
 let g:onedark_color_overrides = {
 \ "background": {"gui": "#000000", "cterm": "black", "cterm16": "0" }
 \}

" " To customize the comment color change this.
" " \ "comment_grey": {"gui": "#555e5d", "cterm": "30", "cterm16": "0" },

"colorscheme onedark
let ayucolor="dark"   " for dark version of theme
"colorscheme ayu
let g:gruvbox_contrast_dark = "hard"
let g:gruvbox_material_foreground = "original"
let g:gruvbox_material_background = "hard"
let g:gruvbox_material_disable_italic_comment = 1
let g:gruvbox_material_enable_bold = 0
let g:gruvbox_material_enable_italic = 0
"let g:gruvbox_material_sign_column_background = 'grey'
let g:gruvbox_material_ui_contrast = 'high'
let g:gruvbox_material_current_word = 'grey background'
let g:gruvbox_material_lightline_disable_bold = 1
let g:gruvbox_material_colors_override = {'bg0': ['#101010', '234']}
"autocmd vimenter * ++nested colorscheme gruvbox
"autocmd vimenter * ++nested colorscheme gruvbox-material
"colorscheme spacegray
let g:tokyonight_style = 'night' " available: night, storm
let g:tokyonight_enable_italic = 0

"colorscheme tokyonight

let g:codedark_transparent=1
let g:codedark_conservative=1
let g:airline_theme='codedark'
colorscheme codedark

"setlocal back='#1E1E1E'
"highlight! Normal guibg=back

"colorscheme simpleblack
"colorscheme jellybeans

"highlight! link CocPumMenu Pmenu
"highlight! link CocMenuSel PmenuSel
"highlight! link CocPumVirtualText Grey

" Autocomplete box colors.
"hi! Pmenu guifg=#0c6370 ctermbg=235
"hi! PmenuSel guifg=#000000 ctermbg=black
"hi! PmenuSbar guifg=#000000 ctermbg=black

" Max dimensions of autocomplete box.
set pumheight=24
set pumwidth=80 " doesn't work well

" Set utf8 as standard encoding and en_US as the standard language
set encoding=utf8

" Use Unix as the standard file type
set ffs=unix,dos,mac
