" PLUGINS
" COC (language server) bindings
source $HOME/.config/nvim/coc_bindings.vim

" coc-snippets bindings
imap <C-k> <Plug>(coc-snippets-expand-jump)
vmap <C-j> <Plug>(coc-snippets-select)
"   Use <leader>x for convert visual selected code to snippet
xmap <leader>x  <Plug>(coc-convert-snippet)

" ultisnips bindings
let g:UltiSnipsExpandTrigger="<C-tab>"

" ALE bindings (Asynchronous Lint Engine)
nmap <silent> [a <Plug>(ale_previous_wrap)
nmap <silent> ]a <Plug>(ale_next_wrap)
noremap <M-a> :call AleAutofixToggle()<CR>
let g:ale_fix_on_save = 0

function! AleAutofixToggle()
    if g:ale_fix_on_save
        echo "g:ale_fix_on_save = 0"
        let g:ale_fix_on_save = 0
    else
        echo "g:ale_fix_on_save = 1"
        let g:ale_fix_on_save = 1
    endif
endfunction

" vim-gitgutter bindings
"   Stage the hunk with <Leader>hs
"   Undo the hunk with <Leader>hu
"   Preview the hunk with <Leader>hp
nmap [h <Plug>(GitGutterPrevHunk)
nmap ]h <Plug>(GitGutterNextHunk)

" fzf find bindings
"   Select multiple things with Shift + TAB
"   Open entries in split panes with TAB
"   Open entries in different tabs with Ctrl + T
nmap <leader>ff :Files<cr>
nmap <leader>ft :BTags<cr>
nmap <leader>fT :Tags<cr>
nmap <leader>fl :BLines<cr>
nmap <leader>fL :Lines<cr>
nmap <leader>fg :GFiles?<cr>
nmap <leader>fb :Buffers<cr>
nmap <leader>fc :BCommits<cr>
nmap <leader>fC :Commits<cr>

"   Change default bindings
let g:fzf_action = {
    \ 'ctrl-t': 'tab split',
    \ 'ctrl-s': 'split',
    \ 'ctrl-v': 'vsplit'
    \ }

" fzf-checkout bindings
"   ctrl + d to delete the branch under cursor
"   alt + enter to track a remote branch locally
nnoremap <leader>gc :GBranches<CR>

" vim-livedown
nmap <leader>tm :LivedownToggle<CR>

" bracey.vim
nmap <leader>tb :Bracey<CR>

" nvim-colorizer
nnoremap <leader>tc :ColorizerToggle<CR>

" emmet-vim
"   All commands and bindings:  https://raw.githubusercontent.com/mattn/emmet-vim/master/TUTORIAL
"   Trigger key ,,      you can also use autocomplete to select abbreviation
"   Example: Write one of the keywords listed below, go to normal mod and
"            press ,,
"   remove a tag                : <C-y>k
"   update image's size         : <C-y>i
"   make anchor from a URL      : <C-y>a
"   make quoted text from a URL : <C-y>A
"
"   tag expansion               : div
"   nested tag expansion        : div>div1>div2>div3
"   creating lists              : div#mylist>li*10>{List Item} (list with 10
"                                                               items)
"   creating lists with indices : div#mylist>li*10>{List Item $}
"   creating sibling tags       : div+h1+h2
"   shortcuts                   : bq, btn, hdr, ftr
"   ID expansion                : tag_name#id_name
"   class expansion             : tag_name.class_name
"   default class expansion     : .class_name (div is assumed as tag)
"   multi class expansion       : .class1.class2
"   ID & class expansion        : #myid.myclass
let g:user_emmet_leader_key=','

" vim-dadbod config
"   Setup:
"       let b:db = "postgresql://[username[:password]@][host][:port][/dbname]"
"   In visual mode:
"       select the query and press <leader>db to execute the query
"   In normal mode:
"       press <leader>dbb to execute query on the line
"       press <leader>db + text-object to run the queries by specifying text
"        object
xnoremap <expr> <Plug>(DBExe)     db#op_exec()
nnoremap <expr> <Plug>(DBExe)     db#op_exec()
nnoremap <expr> <Plug>(DBExeLine) db#op_exec() . '_'

xmap <leader>db  <Plug>(DBExe)
nmap <leader>db  <Plug>(DBExe)
omap <leader>db  <Plug>(DBExe)
nmap <leader>dbb <Plug>(DBExeLine)

" neorg config
nnoremap <silent> <localleader>nm :Neorg inject-metadata<CR>
nnoremap <silent> <localleader>t :Neorg toc left <CR> :vertical resize 50<CR>
nnoremap <silent> <localleader>a i
"   insert anchor
nnoremap <silent> <localleader>a i<C-v>{<C-v>}<Esc>h"+p
"   autoindent file
" nnoremap <silent> <localleader>i :normal! gg <CR> :%normal! i<Esc><C-o>
nnoremap <silent> <localleader>i gg=G<C-o>

" nvim-tree config
nnoremap <silent> <C-c> :NvimTreeToggle<CR>
nnoremap <silent> <leader>pv :NvimTreeFindFile!<CR>

" debugprint.nvim config
lua << EOF
vim.keymap.set("n", "<Leader>dpp", function()
    return require('debugprint').debugprint()
end, {
    expr = true,
})
vim.keymap.set("n", "<Leader>dpP", function()
    return require('debugprint').debugprint({ above = true })
end, {
    expr = true,
})
vim.keymap.set({"n", "v"}, "<Leader>dpv", function()
    return require('debugprint').debugprint({ variable = true })
end, {
    expr = true,
})
vim.keymap.set({"n", "v"}, "<Leader>dpV", function()
    return require('debugprint').debugprint({ above = true, variable = true })
end, {
    expr = true,
})
vim.keymap.set("n", "<Leader>dpo", function()
    return require('debugprint').debugprint({ motion = true })
end, {
    expr = true,
})
vim.keymap.set("n", "<Leader>dpO", function()
    return require('debugprint').debugprint({ above = true, motion = true })
end, {
    expr = true,
})
EOF

" refactoring.nvim config
lua << EOF
-- prompt for a refactor to apply when the remap is triggered
vim.keymap.set(
    {"n", "x"},
    "<leader>rr",
    function() require('refactoring').select_refactor() end
)
-- Note that not all refactor support both normal and visual mode
EOF
