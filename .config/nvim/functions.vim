" change theme according to the system variable SYSTEM_THEME_COLOR
function! ChangeBackground()
  if system("awk '/background/ {print $2}' FS=: /mnt/c/Users/arensonz/.system_theme_color") =~ 'light'
    set background=light  " for the light version of the theme
    colorscheme gruvbox
    let g:lightline.colorscheme = 'gruvbox'
  else
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
