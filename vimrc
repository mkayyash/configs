"""""""""""""""""""""""""""
" => Plugins
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
" My preferred grep tool (git, ag, ack)
" NOTE: must install git, ag and ack
call minpac#add('mhinz/vim-grepper')
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
" Nice ctag explorer for each file
" NOTE: Must install universal-ctags on system
" brew install --HEAD universal-ctags/universal-ctags/universal-ctags
call minpac#add('preservim/tagbar')
" Phrase related utils. Mainly the advanced :S/Pattern/NewPattern/g
call minpac#add('tpope/vim-abolish')
" Command line git wrapper. :Git <command>
call minpac#add('tpope/vim-fugitive')
" Allows commenting/uncommenting code blocks with gc
call minpac#add('tpope/vim-commentary')
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
call minpac#add('neoclide/coc.nvim')
" NOTE: To install, we need first a dev icon installed:
" brew tap homebrew/cask-fonts && brew install --cask font-hack-nerd-font
" Edit iTerm2 to make the 'Hack' font the Non-ASCII font. OR import the
" iTerm.json profile from ~/src/configs
call minpac#add('ryanoasis/vim-devicons')
" Fixes language specific formatting for most languages. Also auto adjusts
" the indentation according to current file layout.
call minpac#add('sheerun/vim-polyglot')
" My favorite two vim colorschemes
call minpac#add('tomasiser/vim-code-dark')
call minpac#add('mkayyash/gruvbox-material')

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Helper Functions
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Delete trailing white space on save.
func! DeleteTrailingWS()
  exe "normal mz"
  %s/\s\+$//ge
  exe "normal `z"
endfunc

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

" Shows lines selected in visual mode (and more).
set showcmd

" Remove trailing whitespaces"
nnoremap <Leader>rtw :%s/\s\+$//e<CR>

" Treat all numbers as decimals.
set nrformats=

" Remap VIM 0 to first non-blank character
map 0 ^

" Toggle paste mode on and off
map <leader>pp :setlocal paste!<cr>

" Remap jj to escape in insert mode.
inoremap jj <Esc>

" Count search instances
map <Leader>o :%s///n<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => User Interface
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

""""""""""""""""""""""""""""""
" => Visual Mode
""""""""""""""""""""""""""""""
" Visual mode pressing * or # searches for the current selection
" Super useful! From an idea by Michael Naumann
vnoremap <silent> * :call VisualSelection('f')<CR>
vnoremap <silent> # :call VisualSelection('b')<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Command Line Mode 
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
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
" => Navigation, Tabs, Windows and Buffers
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Disable highlight when <leader><cr> is pressed
map <silent> <leader><cr> :noh<cr>

" Smart way to move between windows
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" Close the current buffer
map <leader>bd :Bclose<cr>

" Close all the buffers
map <leader>ba :%bd!<cr>

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

" Return to last edit position when opening files
autocmd BufReadPost *
     \ if line("'\"") > 0 && line("'\"") <= line("$") |
     \   exe "normal! g`\"" |
     \ endif
" Remember info about open buffers on close
set viminfo^=%

" TODO: Make this work when there are no more levels to jump to.
" in that case we should just do a [=
nnoremap <silent> [[ :norm [-<CR>
nnoremap <silent> ]] :norm ]-<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Spell Checking
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Pressing ,ss will toggle and untoggle spell checking
map <leader>ss :setlocal spell!<cr>

" Shortcuts using <leader>
map <leader>sn ]s
map <leader>sp [s
map <leader>sa zg

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Language Specific
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
autocmd BufWrite *.py :call DeleteTrailingWS()

" Change default tab settings based on file extension
augroup FileTypeTabRules
    autocmd!
    autocmd BufRead,BufNewFile *.pug,*.jade setlocal tabstop=2 shiftwidth=2
augroup END

" Red highlight >80 character lines
augroup FileTypeLengthRules
    autocmd BufWinEnter *.ts,*.cpp,*.c,*.cc,*.js,*.pug,*.jade let w:m1=matchadd('ErrorMsg', '\%>80v.\+', -1)

augroup HighlightWhitespace
    " Ignore whitespace on those files
    autocmd BufWinEnter vimrc,*.md,*.pug let b:md_file=1
    " Apply whitespace on everything else
    autocmd BufWinEnter * if ! exists('b:md_file') | let w:m1=matchadd('ErrorMsg', '\s\+$', -1) | endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Grep and Vim Grepper
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" When you press <leader>r you can search and replace the selected text
vmap <leader>r "hy:%s/\<<C-r>h\>//g<left><left>

nnoremap <leader>g :Grepper -tool git<cr>
nnoremap <leader>G :Grepper -tool ag<cr>

nmap gs <plug>(GrepperOperator)
xmap gs <plug>(GrepperOperator)

" Optional. The default behaviour should work for most users.
let g:grepper               = {}
let g:grepper.tools         = ['git', 'ag', 'rg']
let g:grepper.jump          = 1
let g:grepper.next_tool     = '<leader>g'
let g:grepper.simple_prompt = 1
let g:grepper.quickfix      = 1

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Vim-Airline Status Line
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Always show the status line
set laststatus=2

" Format the status line
set statusline=\ %{HasPaste()}%F%m%r%h\ %w\ %r%{getcwd()}%h\ %w\ \(%l,%c\)

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => COC Autocomplete
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Max dimensions of autocomplete box.
set pumheight=24
set pumwidth=80 " doesn't work well

" Set utf8 as standard encoding and en_US as the standard language
set encoding=utf8

" Use Unix as the standard file type
set ffs=unix,dos,mac
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
  \ 'coc-sh',
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

" [DISABLED] Highlight the symbol and its references when holding the cursor.
" autocmd CursorHold * silent call CocActionAsync('highlight')

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
" Recursively lookup for a ctags tag file.
set tags=tags;

nmap <silent> <Leader>f :FZF<CR>
nmap <silent> <Leader>tt :BTags<CR>
nmap <silent> <Leader>u :Tags<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Tagbar Related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Control toggling the tagbar
nmap <silent> <leader>T :TagbarToggle<CR>
let g:tagbar_autofocus = 1
let g:tagbar_sort = 0

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => ListToggle Related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:lt_location_list_toggle_map = '<leader>ll'
let g:lt_quickfix_list_toggle_map = '<leader>cc'
"let g:lt_height = 10

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Theme/ColorScheme Related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Use 24-bit (true-color) mode in Vim/Neovim even in tmux.
" Assumes tmux version 2.2 or later.
" (see < http://sunaku.github.io/tmux-24bit-color.html#usage > for more info)
if (has("nvim"))
  let $NVIM_TUI_ENABLE_TRUE_COLOR=1
endif
if (has("termguicolors"))
  set termguicolors
endif

syntax on
let g:gruvbox_material_foreground = "original"
let g:gruvbox_material_background = "hard"
let g:gruvbox_material_disable_italic_comment = 1
let g:gruvbox_material_enable_bold = 0
let g:gruvbox_material_enable_italic = 0
let g:gruvbox_material_sign_column_background = 'grey'
let g:gruvbox_material_ui_contrast = 'high'
let g:gruvbox_material_current_word = 'grey background'
let g:gruvbox_material_lightline_disable_bold = 1
let g:gruvbox_material_show_eob = 0
let g:gruvbox_material_colors_override = {
  \ 'bg0': ['#0f141a', '234'],
  \}
"DISABLED GRUVBOX THEME
"autocmd vimenter * ++nested colorscheme gruvbox-material

let g:codedark_transparent=1
let g:codedark_conservative=1
let g:airline_theme='codedark'
colorscheme codedark
