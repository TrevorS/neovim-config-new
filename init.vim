" general settings
set number
set smartindent
set expandtab

set shiftwidth=2
set softtabstop=2
set tabstop=2

set virtualedit=onemore

set undofile
set undolevels=1000
set undoreload=10000
set undodir=$HOME/.config/nvim/undo

set wildmode=longest,list:longest
set inccommand=nosplit

set lazyredraw
set noshowmode
set cursorline

set noerrorbells visualbell t_vb=

" disable automatic commenting
autocmd FileType * setlocal formatoptions-=cro
set formatoptions-=cro

set mouse=a

" extra settings for autocomplete
set hidden

set nobackup
set nowritebackup

set cmdheight=2
set updatetime=300

set shortmess+=c
set signcolumn=yes
set completeopt=noinsert,menuone,noselect

" plugins
call plug#begin($HOME . '/config/nvim/plugged')
  " autocomplete
  Plug 'neoclide/coc.nvim', {'do': 'yarn install --frozen-lockfile'}

  " fzf
  Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
  Plug 'junegunn/fzf.vim'

  " tpope
  Plug 'tpope/vim-commentary'
  Plug 'tpope/vim-eunuch'
  Plug 'tpope/vim-fugitive'
  Plug 'tpope/vim-repeat'
  Plug 'tpope/vim-surround'
  Plug 'tpope/vim-vinegar'
  Plug 'tpope/vim-rails'

  " languages
  Plug 'ElmCast/elm-vim'
  Plug 'ekalinin/Dockerfile.vim'
  Plug 'elixir-editors/vim-elixir'
  Plug 'hashivim/vim-terraform'
  Plug 'jelera/vim-javascript-syntax'
  Plug 'martinda/Jenkinsfile-vim-syntax'
  Plug 'mxw/vim-jsx'
  Plug 'pangloss/vim-javascript'
  Plug 'rust-lang/rust.vim'
  Plug 'vim-ruby/vim-ruby'
  Plug 'vim-scripts/groovy.vim'

  Plug 'fatih/vim-go', {
    \ 'do': ':GoInstallBinaries'
    \ }

  " utilities
  Plug 'jremmen/vim-ripgrep'
  Plug 'sgur/vim-editorconfig'
  Plug 'ludovicchabant/vim-gutentags'
  Plug 'mhinz/vim-signify'
  Plug 'christoomey/vim-tmux-navigator'

  Plug 'itchyny/lightline.vim'
  Plug 'nanotech/jellybeans.vim'
call plug#end()

" configure coc extensions
call coc#add_extension(
      \ 'coc-json',
      \ 'coc-tsserver',
      \ 'coc-yaml',
      \ 'coc-solargraph',
      \ 'coc-rls',
      \ 'coc-python',
      \ 'coc-html',
      \ 'coc-css',
      \)

" theme
if (has("termguicolors"))
  set termguicolors
endif

colorscheme jellybeans

" python remote plugin
let g:python_host_prog='/usr/local/bin/python2'
let g:python3_host_prog='/usr/local/miniconda3/bin/python'

" standard keybindings
let mapleader = "\<Space>"

nnoremap <silent> <leader>ea :edit $HOME/.config/alacritty/alacritty.yml<cr>
nnoremap <silent> <leader>et :edit $HOME/.tmux.conf<cr>
nnoremap <silent> <leader>ez :edit $HOME/.zshrc<cr>
nnoremap <silent> <leader>ev :edit $MYVIMRC<cr>
nnoremap <silent> <leader>sv :source $MYVIMRC<cr>

nnoremap <silent> <leader>l :redraw!<cr>:nohl<cr><esc>
nnoremap <silent> <leader>v :vsplit<cr><c-w>l
nnoremap <silent> <leader>h :split<cr><c-w>j
nnoremap <silent> <leader>w :write<cr>
nnoremap <silent> <leader>q :quit<cr>

nnoremap <silent> <c-h> <c-w>h
nnoremap <silent> <c-j> <c-w>j
nnoremap <silent> <c-k> <c-w>k
nnoremap <silent> <c-l> <c-w>l

nnoremap <silent> Y y$

nnoremap <silent> j gj
nnoremap <silent> k gk

nnoremap <silent> n nzz
nnoremap <silent> N Nzz

nnoremap <silent> <c-d> <c-d>zz
nnoremap <silent> <c-u> <c-u>zz

" Rg the word under the cursor
nnoremap <silent> <leader>* :Rg "\b<C-R><C-W>\b"<CR>:cw<CR>

noremap <silent> <leader>sy "*y

cnoremap <c-a> <home>
cnoremap <c-e> <end>
cnoremap <c-f> <right>
cnoremap <c-b> <left>

" autocomplete keybindings
" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> for trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> for confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" Use K for show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if &filetype == 'vim'
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" gutentags
let g:gutentags_exclude_filetypes = ['gitcommit', 'vim']

" signify
let g:signify_vcs_list = ['git']

" lightline
let g:lightline = {
  \ 'colorscheme': 'jellybeans',
  \ 'active': {
  \   'left': [['mode', 'paste'],
  \            ['cocstatus', 'fugitive', 'filename', 'filetype']],
  \   'right': [['lineinfo'], ['percent'],
  \             ['linter_errors', 'linter_warnings']],
  \ },
  \ 'component_function': {
  \   'mode': 'LightLineMode',
  \   'filename': 'LightLineFilename',
  \   'fugitive': 'LightLineFugitive',
  \   'fileformat': 'LightLineFileformat',
  \   'filetype': 'LightLineFiletype',
  \   'cocstatus': 'coc#status',
  \ },
  \ 'component_expand': {
  \   'linter_warnings': 'lightline#ale#warnings',
  \   'linter_errors': 'lightline#ale#errors',
  \ },
  \ 'component_type': {
  \   'linter_warnings': 'warning',
  \   'linter_errors': 'error',
  \ },
  \ 'separator': { 'left': '', 'right': '' },
	\ 'subseparator': { 'left': '', 'right': '' },
  \ }

let g:lightline#ale#indicator_warnings = ' '
let g:lightline#ale#indicator_errors = ' '

function! LightLineMode()
  return winwidth(0) > 60 ? lightline#mode() : ''
endfunction

function! LightLineFilename()
  let filename = expand('%:t') !=# '' ? expand('%:t') : '[No Name]'
  let modified = &modified ? ' +' : ''
  return filename . modified
endfunction

function! LightLineFileformat()
  return winwidth(0) > 70 ? &fileformat : ''
endfunction

function! LightLineFiletype()
  return winwidth(0) > 70 ? (&filetype !=# '' ? &filetype : 'no ft') : ''
endfunction

function! LightLineFugitive()
  let _ = fugitive#head()
  return strlen(_) ? ' '._ : ''
endfunction

" fzf
nnoremap <silent> <leader>p :call fzf#run({ 'source': 'rg --files', 'sink': 'e', 'window': 'enew' })<cr>

" rg
nnoremap <leader>a :Rg<space>

" format json
nnoremap <leader>j :%!python -m json.tool<cr>
