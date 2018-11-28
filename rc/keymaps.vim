
" With a map leader it's possible to do extra key combinations
" like <leader>w saves the current file
let mapleader = ","
let g:mapleader = ","

" Fast saving
nmap <leader>w :w<cr>

"paste 模式
set pastetoggle=<F5>

" 取消搜索高亮
nmap <silent> <leader>h :nohlsearch<CR>


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
        call append(line(".")+1, "\# Author: Lch")
        call append(line(".")+2, "\# mail: fn.stanc@gmail.com")
        call append(line(".")+3, "\# Created Time: ".strftime("%c"))
        call append(line(".")+4, "")
    elseif &filetype == 'python'
        call setline(1,"\#-*- coding: utf-8 -*-")
        call append(line("."), "\#!/usr/bin/env python")
        call append(line(".")+1, "\# File Name: ".expand("%"))
        call append(line(".")+2, "\# Author: Lch")
        call append(line(".")+3, "\# Mail: fn.stanc@gmail.com")
        call append(line(".")+4, "\# Created Time: ".strftime("%c"))
        call append(line(".")+5, "")
    else
        call setline(1, "/*")
        call append(line("."), " * File Name: ".expand("%"))
        call append(line(".")+1, " * Author: Lch")
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
