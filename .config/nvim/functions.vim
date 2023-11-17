" https://gist.github.com/fgarcia/9704429#file-long_lines-vim
" https://stackoverflow.com/q/395114
function! LongLineHighlightOn(length)
    if exists("w:llh")
        call matchdelete(w:llh)
    endif
    highlight OverLength ctermbg=LightBlue ctermfg=black guibg=LightBlue guifg=black
    let w:llh = matchadd("OverLength", '\%' . (a:length + 1) . 'v')
endfunction

function! ToggleBackground()
    if &background =~? 'dark'
        echo "Changing to light theme"
        set background=light  " for the light version of the theme
        colorscheme base16-gruvbox-light-hard
        let g:lightline.colorscheme = 'Tomorrow'
        " colorscheme one
        " let g:lightline.colorscheme = 'one'
        " colorscheme base16-catppuccin-latte
        " let g:lightline.colorscheme = 'Tomorrow'
        " colorscheme base16-tomorrow
        " let g:lightline.colorscheme = 'Tomorrow'
        " colorscheme base16-da-one-paper
        " let g:lightline.colorscheme = 'Tomorrow'
    else
        echo "Changing to dark theme"
        set background=dark   " for the dark version of the theme
        colorscheme dracula
        let g:lightline.colorscheme = 'dracula'
    endif

    if &ft ==? 'css' || &ft ==? 'scss'
        call LongLineHighlightOn(90)
    elseif &ft != 'floaterm' && &ft != 'fzf'
        call LongLineHighlightOn(120)
    endif

    try
        call lightline#init()
        call lightline#colorscheme()
        call lightline#update()
    catch
    endtry

endfunction
