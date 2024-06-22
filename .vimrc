" ============================================================
" Basic Settings
" ============================================================
" Ensure Vim is not in compatibility mode with vi
set nocompatible              
" Keep a large history of commands for easy recall
set history=500               
" Show the cursor's current position
set ruler                     
" Set the height of the command bar for better visibility
set cmdheight=2               
" Enable case-insensitive searching for convenience
set ignorecase                
" Use smart case searching for more refined results
set smartcase                 
" Highlight search results to make them stand out
set hlsearch                  
" Incremental search improves search interaction
set incsearch                 
" Enable magic mode for powerful regular expressions
set magic                     
" Highlight matching brackets for easier code navigation
set showmatch                 
" Set the blink time for matching brackets
set mat=2                     
" Avoid annoying error sounds
set noerrorbells              
" Disable visual bells as well
set novisualbell              
set t_vb=                     
" Set time to wait for a mapped sequence
set tm=500                    
" Optimize performance by not redrawing during macros
set lazyredraw                
" Enhance backspace functionality
set backspace=eol,start,indent 
" Allow cursor to move past screen edge
set whichwrap+=<,>,h,l        
" Use UTF-8 encoding for universal compatibility
set encoding=utf8             
" Support multiple file formats
set ffs=unix,dos,mac          
" Set scroll offset for better context visibility
set so=7
" Use TAB for command line expansion
set wildchar=<TAB>            
" Ignore case in command line expansion for usability
set wildignorecase
" Exclude certain files and directories from command line expansion
set wildignore+=*.o,*~,*.pyc,*.swp,*.zip,*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store,*/node_modules/*,*/bower_components/*

" ============================================================
" UI Configurations
" ============================================================
" Enable enhanced command line completion
set wildmenu                  
" Exclude more file types and directories in wildmenu
set wildignore+=*.o,*~,*.pyc,*.swp,*.zip 
set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store 
set wildignore+=*/node_modules/*,*/bower_components/* 
" Set wildmenu completion behavior
set wildmode=list:longest,full 
" Show line numbers for reference
set number                    
" Show relative line numbers for easier navigation
set relativenumber            
" Highlight the current line for focus
set cursorline                
" Always display the status line for information
set laststatus=2              
" Configure the folding column for code organization
set foldcolumn=1              

" ============================================================
" Filetype Indentation and Syntax Highlighting
" ============================================================
" Enable filetype detection and plugins
filetype plugin on            
" Enable filetype-based indentation
filetype indent on            
" Turn on syntax highlighting for readability
syntax enable                 

" Configure indentation for specific file types
autocmd FileType python setlocal expandtab shiftwidth=4 softtabstop=4
autocmd FileType javascript setlocal expandtab shiftwidth=2 softtabstop=2
autocmd FileType bash setlocal expandtab shiftwidth=4 softtabstop=4
autocmd FileType yaml setlocal expandtab shiftwidth=2 softtabstop=2
autocmd FileType typescript setlocal expandtab shiftwidth=2 softtabstop=2

" ============================================================
" Leader Key and Mappings
" ============================================================
" Define the leader key for custom shortcuts
let mapleader = ","           
" Create a shortcut for quick saving
nmap <leader>w :w!<CR>        
" Toggle spell checking
nmap <leader>ss :setlocal spell!<CR> 
" Clear search highlighting quickly
nmap <silent> <leader><cr> :noh<CR> 

" ============================================================
" Backup, Undo, and File Reading
" ============================================================
" Enable backup files
set backup                    
" Specify backup file directory
set backupdir=~/.vim/backups  
" Exclude certain files from backups
set backupskip=/tmp/*,*.tmp  
" Specify undo file directory for persistent undo
set undodir=~/.vim_runtime/temp_dirs/undodir 
" Enable persistent undo
set undofile                  

" ============================================================
" Performance Optimization
" ============================================================
" Configure plugin lazy loading for performance (specific configurations depend on the plugins used)

" ============================================================
" Plugin Configuration (Vim-Plug)
" ============================================================
" Install Vim-Plug if it's not already present
if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
       \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

" Begin plugin configurations
call plug#begin('~/.vim/plugged')
" Plugin declarations go here

" Language support for YAML, JSON, Python, TypeScript, Bash, JavaScript
Plug 'sheerun/vim-polyglot'
Plug 'leafgarland/typescript-vim'
Plug 'pangloss/vim-javascript'
Plug 'peitalin/vim-jsx-typescript'
Plug 'HerringtonDarkholme/yats.vim'

" Visualize indent across languages
Plug 'Yggdroot/indentLine'

" Git integration
Plug 'tpope/vim-fugitive'

" Interactive Debugger
Plug 'puremourning/vimspector'

" Linting automatically
Plug 'dense-analysis/ale'

call plug#end()

" ============================================================
" Terminal and Color Support
" ============================================================
" Enable 256 color support for certain terminals
if $COLORTERM == 'gnome-terminal' || $TERM_PROGRAM == 'iTerm.app'
    set t_Co=256
endif

" ============================================================
" Additional Custom Functions
" ============================================================
" Custom functions and key mappings for enhanced functionality

" Speed up mode transitions
if ! has('gui_running')
  set ttimeoutlen=10
  augroup FastEscape
    autocmd!
    au InsertEnter * set timeoutlen=200
    au InsertLeave * set timeoutlen=1000
  augroup END
endif

" Autoclose brackets with line breaks, useful for JSON
inoremap {<CR> {<CR>}<Esc>O

" Abbreviations for faster typing
iab xdate <C-r>=strftime("%d/%m/%y %H:%M:%S")<cr>

" Bindings for efficient JSON editing
inoremap aa <ESC>la
inoremap <leader>i <ESC>o

" Key mappings to move between window splits
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" ============================================================
" Auto-commands and Fine Tuning
" ============================================================
" Additional auto-commands and tweaks based on personal preferences

" ============================================================
" Language-Specific Settings
" ============================================================
" Additional settings for specific programming languages

" ============================================================
" End of .vimrc
" ============================================================

