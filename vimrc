" Based on amix's vimrc
" customed by Stan

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Maintainer:
"       Amir Salihefendic
"       http://amix.dk - amix@amix.dk
"
" Version:
"       5.0 - 29/05/12 15:43:36
"
" Blog_post:
"       http://amix.dk/blog/post/19691#The-ultimate-Vim-configuration-on-Github
"
" Awesome_version:
"       Get this config, nice color schemes and lots of plugins!
"
"       Install the awesome version from:
"
"           https://github.com/amix/vimrc
"
" Syntax_highlighted:
"       http://amix.dk/vim/vimrc.html
"
" Raw_version:
"       http://amix.dk/vim/vimrc.txt
"
" Sections:
"    -> General
"    -> VIM user interface
"    -> Colors and Fonts
"    -> Files and backups
"    -> Text, tab and indent related
"    -> Visual mode related
"    -> Moving around, tabs and buffers
"    -> Status line
"    -> Editing mappings
"    -> vimgrep searching and cope displaying
"    -> Spell checking
"    -> Misc
"    -> Helper functions
"    -> Vundle
"    -> Other
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Vundle~/.vimrc.bundles
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" install Vundle bundles
if filereadable(expand("~/.vim/vimrc.bundles"))
    source ~/.vim/vimrc.bundles
endif

filetype plugin indent on

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Sets how many lines of history VIM has to remember
set history=700

" Enable filetype plugins
filetype plugin on
filetype indent on

" Set to auto read when a file is changed from the outside
set autoread

" With a map leader it's possible to do extra key combinations
" like <leader>w saves the current file
let mapleader = ","
let g:mapleader = ","

" 可以在buffer的任何地方使用鼠标（类似office中在工作区双击鼠标定位）
set mouse=a
set selection=exclusive
set selectmode=mouse,key

" 在处理未保存或只读文件的时候，弹出确认
set confirm

" 语言设置
set langmenu=zh_CN.UTF-8
set helplang=cn

" 编码设置
set enc=utf-8
set fencs=utf-8,ucs-bom,shift-jis,gb18030,gbk,gb2312,cp936

" Use Unix as the standard file type
" set ffs=unix,dos,mac
if has("win32")
    set fileencoding=cp936
    set ffs=dos,unix,mac
    "解决菜单乱码
    source $VIMRUNTIME/delmenu.vim
    source $VIMRUNTIME/menu.vim
    "解决consle输出乱码
    language messages zh_CN.utf-8
else
    " Use Unix as the standard file type
    set ffs=unix,dos,mac
    set fileencoding=utf-8
endif

" Show comman
set showcmd

" Fast saving
nmap <leader>w :w<cr>

"paste 模式
set pastetoggle=<F5>

" 自动补全
set completeopt=longest,menu

" 取消搜索高亮
nmap <silent> <leader>h :nohlsearch<CR>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => VIM user interface
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Set 7 lines to the cursor - when moving vertically using j/k
set so=7

" Turn on the WiLd menu
set wildmenu

" Ignore compiled files
set wildignore=*.o,*~,*.pyc
if has("win16") || has("win32")
    set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store
else
    set wildignore+=.git\*,.hg\*,.svn\*
endif


"Always show current position
set ruler

" Height of the command bar
set cmdheight=2

" A buffer becomes hidden when it is abandoned
set hid

" Configure backspace so it acts as it should act
set backspace=eol,start,indent
set whichwrap+=<,>,h,l

" 搜索忽略大小写
set ignorecase

" When searching try to be smart about cases
set smartcase

" 高亮搜索结果
set hlsearch

" Makes search act like search in modern browsers
set incsearch

" Don't redraw while executing macros (good performance config)
set lazyredraw

" For regular expressions turn magic on
set magic

" 高亮显示匹配的括号
set showmatch

" 匹配括号高亮的时间（单位是十分之一秒）
set matchtime=1

" How many tenths of a second to blink when matching brackets
set mat=2

" No annoying sound on errors
set noerrorbells
set novisualbell
set t_vb=
set tm=500

" 突出显示当前行
set cursorline

" 显示行号
set nu


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Colors and Fonts
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Enable syntax highlighting
syntax enable

" Set extra options when running in GUI mode
if has("gui_running")
        colorscheme molokai
        let g:rehash256 = 1
        set guioptions-=T
        set guioptions+=e
        set t_Co=256
        set guitablabel=%M\ %t
        set guifont=Dejavu\ Sans\ Mono\ 11     " 字体 && 字号
        set lines=36 columns=88    " 设定窗口大小
else
        colorscheme desert
        set background=dark
        set t_Co=256
endif


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Files, backups and undo
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Turn backup off, since most stuff is in SVN, git et.c anyway...
set nobackup
set nowb
set noswapfile


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Text, tab and indent related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Use spaces instead of tabs
set expandtab

" Be smart when using tabs ;)
set smarttab

" 1 tab == 4 spaces
set shiftwidth=4
set tabstop=4

" for python
autocmd FileType python setlocal tabstop=4 shiftwidth=4

" Linebreak on 500 characters
set lbr
set tw=500

set ai "Autoindent
set si "Smartindent
set wrap "Wrap lines
set cindent "C/CPP indent


""""""""""""""""""""""""""""""
" => Visual mode related
""""""""""""""""""""""""""""""
" Visual mode pressing * or # searches for the current selection
" Super useful! From an idea by Michael Naumann
vnoremap <silent> * :call VisualSelection('f')<CR>
vnoremap <silent> # :call VisualSelection('b')<CR>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Moving around, tabs, windows and buffers
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Treat long lines as break lines (useful when moving around in them)
map j gj
map k gk

" Map <Space> to / (search)
map <space> /

" Disable highlight when <leader><cr> is pressed
map <silent> <leader><cr> :noh<cr>

" Smart way to move between windows
" map <C-j> <C-W>j
" map <C-k> <C-W>k
" map <C-h> <C-W>h
" map <C-l> <C-W>l


" buffers
nmap <leader>e :e <c-r>=expand("%:p:h")<cr>/
nmap <C-b>n  :bnext<CR>
nmap <C-b>p  :bprev<CR>
" Close the current buffer
map <leader>bd :Bclose<cr>
" Close all the buffers
map <leader>ba :1,1000 bd!<cr>

noremap <silent> <Left> :bp<CR>
noremap <silent> <Right> :bn<CR>

" File editing switch
map <leader>fn :next<cr>
map <leader>fp :previous<cr>

" Useful mappings for managing tabs
map <leader>tn :tabnew<cr>
" 合并到一个buffer
map <leader>to :tabonly<cr>
" 关闭标签页
map <leader>tc :tabclose<cr>
map <leader>tm :tabmove

" 切换标签页
map <F7> :tabprev<CR>
map <F8> :tabnext<CR>

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

" Return to last edit position when opening files (You want this!)
autocmd BufReadPost *
     \ if line("'\"") > 0 && line("'\"") <= line("$") |
     \   exe "normal! g`\"" |
     \ endif
" Remember info about open buffers on close
set viminfo^=%


""""""""""""""""""""""""""""""
" => Status line
""""""""""""""""""""""""""""""
" Always show the status line
set laststatus=2

" Format the status line
" set statusline=\ %{HasPaste()}%F%m%r%h\ %w\ \ CWD:\ %r%{getcwd()}%h\ \ \ Line:\ %l,\ %v\ \ %p%%

"状态行显示的内容
" set statusline=%F%m%r%h%w\ \ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [POS=%l,%v][%p%%]\ %{strftime(\"%d/%m/%y\ -\ %H:%M\")}
set statusline=%{HasPaste()}\ File:%f%m%r%h%w\ \ Fmt:%{&fenc}[%{&ff}]\ \ Type:%{GetFileType()}\ \ Line=%l,%v[%p%%]

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Editing mappings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Delete trailing white space by pressing <F12>
nmap <F12> :call DeleteTrailingWS()<CR>

" Remap VIM 0 to first non-blank character
map 0 ^

" 移动当前行/块
" Move a line of text using ALT+[jk] or Comamnd+[jk] on mac
nmap <M-j> mz:m+<cr>`z
nmap <M-k> mz:m-2<cr>`z
vmap <M-j> :m'>+<cr>`<my`>mzgv`yo`z
vmap <M-k> :m'<-2<cr>`>my`<mzgv`yo`z


" Delete trailing white space on save, useful for Python and CoffeeScript ;)
func! DeleteTrailingWS()
  exe "normal mz"
  %s/\s\+$//ge
  exe "normal `z"
endfunc
autocmd BufWrite *.py :call DeleteTrailingWS()
autocmd BufWrite *.coffee :call DeleteTrailingWS()


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => vimgrep searching and cope displaying
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" When you press gv you vimgrep after the selected text
vnoremap <silent> gv :call VisualSelection('gv')<CR>
vnoremap <leader>f :call VisualSelection('gvc')<CR>

" Open Ag and put the cursor in the right position
map <leader>g :Ag ""<left>

" 当前文件查找字符串
map <leader><space> :vimgrep // <C-R>%<C-A><left><left><left><left><left><left><left><left>

" 替换选择的文本
" When you press <leader>r you can search and replace the selected tmainmainmainext
vnoremap <silent> <leader>r :call VisualSelection('replace')<CR>

" Do :help cope if you are unsure what cope is. It's super useful!
"
" When you search with vimgrep, display your results in cope by doing:
"   <leader>cc
"
" 下一个查找结果
" To go to the next search result do:
"   <leader>n
"
" 上一个查找结果
" To go to the previous search results do:
"   <leader>p
"
map <F9> :copen<cr>
map <leader>cc :botright cope<cr>
map <leader>co ggVGy:tabnew<cr>:set syntax=qf<cr>pgg
map <leader>n :cn<cr>
map <leader>p :cp<cr>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Spell checking
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Pressing ,ss will toggle and untoggle spell checking
map <leader>ss :setlocal spell!<cr>

" Shortcuts using <leader>
map <leader>sn ]s
map <leader>sp [s
map <leader>sa zg
map <leader>s? z=


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Misc
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Remove the Windows ^M - when the encodings gets messed up
noremap <Leader>m mmHmt:%s/<C-V><cr>//ge<cr>'tzt'm

" Remove "\t"
noremap <Leader>t :%s/\t/    /ge

" Quickly open a buffer for scripbble
map <leader>buf :e ~/buffer<cr>

" Toggle paste mode on and off
map <leader>pp :setlocal paste!<cr>



"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Helper functions
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
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
        call CmdLine("Ag \"" . l:pattern . "\" " )
    elseif a:direction == 'gvc'
        call CmdLine("Ag \"" . l:pattern . "\" " . '<C-R>%<C-A>' )
    elseif a:direction == 'replace'
        call CmdLine("%s" . '/'. l:pattern . '/')
    elseif a:direction == 'f'
        execute "normal /" . l:pattern . "^M"
    endif

    let @/ = l:pattern
    let @" = l:saved_reg
endfunction


" Returns true if paste mode is enabled
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

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Other
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" highlight one column
map ,ch :call SetColorColumn()<CR>
function! SetColorColumn()
    let col_num = virtcol(".")
    let cc_list = split(&cc, ',')
    if count(cc_list, string(col_num)) <= 0
        execute "set cc+=".col_num
    else
        execute "set cc-=".col_num
    endif
endfunction

" 在新Buffer中打开c/h文件，需要a.vim
nnoremap <silent> <F6> :A<CR>

" Ctags
set tags+=~/.vim/systags
set tags+=~/.vim/tags/gtktags
set autochdir
" 仅显示当前文件的tags
let Tlist_Show_One_File=1

" 建立tags
map <F2> :!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .<CR>

" Taglist
" map <F3> :Tlist <CR>

" Tagbar
map <F3> :Tagbar <CR>

" NERDTree
map <F4> :NERDTreeToggle<CR>

" 自动补全
set completeopt=longest,menu

" 插入匹配括号
:inoremap ( ()<ESC>i
:inoremap ) <c-r>=ClosePair(')')<CR>
:inoremap { {}<ESC>i
:inoremap } <c-r>=ClosePair('}')<CR>
:inoremap [ []<ESC>i
:inoremap ] <c-r>=ClosePair(']')<CR>

function ClosePair(char)
    if getline('.')[col('.') - 1] == a:char
        return "\<Right>"
    else
        return a:char
    endif
endf

" 新建.c,.h,.sh,.java文件，自动插入文件头
autocmd BufNewFile *.cpp,*cc,*.hpp,*.py,*.[ch],*.sh exec ":call SetTitle()"

" 定义函数SetTitle，自动插入文件头
func SetTitle()
    "如果文件类型为.sh文件
    if &filetype == 'sh'
        call setline(1, "\#!/bin/sh")
        call append(line("."), "\# File Name: ".expand("%"))
        call append(line(".")+1, "\# Author: Stan.Lch")
        call append(line(".")+2, "\# mail: fn.stanc@gmail.com")
        call append(line(".")+3, "\# Created Time: ".strftime("%c"))
        call append(line(".")+4, "")
    elseif &filetype == 'python'
        call setline(1,"\#-*- coding: utf-8 -*-")
        call append(line("."), "\#!/usr/bin/env python")
        call append(line(".")+1, "\# File Name: ".expand("%"))
        call append(line(".")+2, "\# Author: Stan.Lch")
        call append(line(".")+3, "\# Mail: fn.stanc@gmail.com")
        call append(line(".")+4, "\# Created Time: ".strftime("%c"))
        call append(line(".")+5, "")
    else
        call setline(1, "/*")
        call append(line("."), " * File Name: ".expand("%"))
        call append(line(".")+1, " * Author: Stan.Lch")
        call append(line(".")+2, " * Mail: fn.stanc@gmail.com")
        call append(line(".")+3, " * Created Time: ".strftime("%c"))
        call append(line(".")+4, " */")
        call append(line(".")+5, "")
    endif


    if expand("%:e") == 'h'
        call append(line(".")+6, "#ifndef _".toupper(expand("%:t:r"))."_H")
        call append(line(".")+7, "#define _".toupper(expand("%:t:r"))."_H")
        call append(line(".")+8, "")
        call append(line(".")+9, "#endif")

    "elseif &filetype == 'c'
    "    call append(line(".")+6, "#include <stdio.h>")
    "    call append(line(".")+7, "#include <stdlib.h>")
    "    call append(line(".")+8, "")

    "elseif expand("%:e") == 'cpp'
    "    call append(line(".")+6, "#include <iostream>")
    "    call append(line(".")+7, "using namespace std;")
    "    call append(line(".")+8, "")
    endif

endfunc

"新建文件后，自动定位到文件末尾
autocmd BufNewFile * normal G
