" change theme according to the system variable SYSTEM_THEME_COLOR
function! ChangeBackground()
    if system("cat /tmp/system_theme_color") =~ 'light'
        echo "light"
        set background=light  " for the light version of the theme
        " autocmd vimenter * ++nested colorscheme solarized8_high
        colorscheme solarized8_high
        let g:lightline.colorscheme = 'solarized'
    else
        echo "dark"
        set background=dark   " for the dark version of the theme
        colorscheme dracula
        let g:lightline.colorscheme = 'dracula'
    endif

    try
        call lightline#init()
        call lightline#colorscheme()
        call lightline#update()
    catch
    endtry

endfunction
