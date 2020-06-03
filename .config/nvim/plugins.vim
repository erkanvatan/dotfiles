call plug#begin('~/.config/nvim/plugged')

Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeTabsToggle' }
Plug 'Xuyuanp/nerdtree-git-plugin', { 'on': 'NERDTreeTabsToggle' }
Plug 'jistr/vim-nerdtree-tabs', { 'on': 'NERDTreeTabsToggle' }
Plug 'ryanoasis/vim-devicons', { 'on': 'NERDTreeTabsToggle' }

Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

"Plug 'liuchengxu/vista.vim'
"Plug 'junegunn/goyo.vim', { 'on': 'Goyo' }
Plug 'itchyny/lightline.vim'
Plug 'maximbaz/lightline-ale'

Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
Plug 'junegunn/gv.vim'

"Plug 'jiangmiao/auto-pairs'

"Plug 'yggdroot/indentline'

Plug 'tpope/vim-surround'
Plug 'scrooloose/nerdcommenter'
"Plug 'mattn/emmet-vim'

Plug 'norcalli/nvim-colorizer.lua'
Plug 'junegunn/rainbow_parentheses.vim'

"Plug 'fatih/vim-go', { 'do': ':GoInstallBinaries', 'for': 'go' }
Plug 'vim-python/python-syntax', { 'for': 'python' }
Plug 'tbastos/vim-lua', { 'for': 'lua' }
Plug 'plasticboy/vim-markdown', { 'for': ['markdown', 'md'] }
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}
Plug 'dense-analysis/ale', { 'tag': 'v2.5.0'}
"Plug 'dsawardekar/ember.vim', { 'for': ['javascript', 'handlebars.ember' ] }
"Plug 'joukevandermaas/vim-ember-hbs', { 'for': ['handlebars.ember'] }
"Plug 'sheerun/vim-polyglot'

Plug 'neoclide/coc.nvim', { 'branch': 'release' }

"Plug 'honza/vim-snippets'
Plug 'voldikss/vim-floaterm'
Plug 'alvan/vim-closetag'

Plug 'dracula/vim', { 'as': 'dracula' }

call plug#end()



let g:vim_markdown_folding_disabled = 1
let g:vim_markdown_conceal = 0
let g:vim_markdown_conceal_code_blocks = 0

