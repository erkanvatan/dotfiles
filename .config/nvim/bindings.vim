let mapleader = "\<Space>"

" <CR> means carriage return, another saying of <Enter>
map qq :q!<CR>
map qw :wq<Enter>

map <C-c> :NERDTreeTabsToggle<CR>

" Change vim window focus
map <C-h> <C-w>h
map <C-Left> <C-w>h
map <C-l> <C-w>l
map <C-Right> <C-w>l
map <C-j> <C-w>j
map <C-Down> <C-w>j
map <C-k> <C-w>k
map <C-Up> <C-w>k

map <C-s><up> :tabr<cr>
map <C-s><down> :tabl<cr>
map <C-s><left> :tabp<cr>
map <C-s><right> :tabn<cr>

" Resize vim windows
nnoremap <silent> <C-M-j> :resize -2<CR>
nnoremap <silent> <C-M-k> :resize +2<CR>
nnoremap <silent> <C-M-h> :vertical resize -2<CR>
nnoremap <silent> <C-M-l> :vertical resize +2<CR>

imap <C-k> <Plug>(coc-snippets-expand-jump)
vmap <C-j> <Plug>(coc-snippets-select)

nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Floating nvim terminal
let g:floaterm_keymap_toggle = '<F7>'
let g:floaterm_keymap_next   = '<F9>'
let g:floaterm_keymap_prev   = '<F8>'
let g:floaterm_keymap_new    = '<F12>'

" fzf find bindings
nmap ff :Files<cr>
nmap ft :BTags<cr>
nmap fT :Tags<cr>
nmap fl :BLines<cr>
nmap fL :Lines<cr>
nmap fg :GFiles?<cr>
nmap fb :Buffers<cr>
nmap fc :BCommits<cr>
nmap fC :Commits<cr>

" :term puts you in terminal-job mode, pressing <ESC> will put you in Terminal-Normal mode with this keybind
" my terminal already has vim modes so i don't need this

"tnoremap <Esc> <C-\><C-n>
