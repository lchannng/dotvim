" File  : style.vim
" Author: Lch <fn.stanc@gmail.com>
" Date  : 2018/12/01 16:09:46

"----------------------------------------------------------------------
" 显示设置
"----------------------------------------------------------------------

" 总是显示状态栏
set laststatus=2

" 总是显示行号
set number

" 总是显示侧边栏（用于显示 mark/gitdiff/诊断信息）
" set signcolumn=yes

" 总是显示标签栏
set showtabline=2

" 设置显示制表符等隐藏字符
" set list

" 右下角显示命令
set showcmd

" 插入模式在状态栏下面显示 -- INSERT --，
" 先注释掉，默认已经为真了，如果这里再设置一遍会影响 echodoc 插件
" set showmode

" 水平切割窗口时，默认在右边显示新窗口
set splitright

" 突出显示当前行
set cursorline

" 状态栏
function! HasPaste()
    if &paste
        return '[PASTE MODE]'
    en
    return ''
endfunction

function! GetFileType()
    if &filetype == ''
        return 'Undefined'
    else
        return &filetype
    fi
endfunction
set statusline=%{HasPaste()}\ file:%f%m%r%h%w\ \ fmt:%{&fenc}[%{&ff}]\ \ type:%{GetFileType()}\ \ line=%l,%v[%p%%]


"----------------------------------------------------------------------
" 颜色主题：色彩文件位于 colors 目录中
"----------------------------------------------------------------------

" 设置黑色背景
set background=dark

" 允许 256 色
set t_Co=256

if has("termguicolors")
    " enable true color
    set termguicolors
endif

let g:airline_theme = 'codedark'
colorscheme codedark

if has("gui_running")
    set guioptions-=T
    set guioptions+=e
    set guitablabel=%M\ %t
    set lines=36 columns=108    " 设定窗口大小
    if has("win32")
        set guifont=Dejavu_Sans_Mono:h10     " 字体 && 字号
    else
        set guifont=Dejavu\ Sans\ Mono\ 11     " 字体 && 字号
    endif
endif

"----------------------------------------------------------------------
" 更改样式
"----------------------------------------------------------------------

" 更清晰的错误标注：默认一片红色背景，语法高亮都被搞没了
" 只显示红色或者蓝色下划线或者波浪线
hi! clear SpellBad
hi! clear SpellCap
hi! clear SpellRare
hi! clear SpellLocal
if has('gui_running')
    hi! SpellBad gui=undercurl guisp=red
    hi! SpellCap gui=undercurl guisp=blue
    hi! SpellRare gui=undercurl guisp=magenta
    hi! SpellRare gui=undercurl guisp=cyan
else
    hi! SpellBad term=standout ctermfg=1 term=underline cterm=underline
    hi! SpellCap term=underline cterm=underline
    hi! SpellRare term=underline cterm=underline
    hi! SpellLocal term=underline cterm=underline
endif

" 修正补全目录的色彩：默认太难看
" hi! Pmenu guibg=gray guifg=black ctermbg=gray ctermfg=black
" hi! PmenuSel guibg=gray guifg=brown ctermbg=brown ctermfg=gray


" quickfix 设置，隐藏行号
"----------------------------------------------------------------------
augroup VimInitStyle
    au!
    au FileType qf setlocal nonumber
augroup END

