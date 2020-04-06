" File  : plugins.vim
" Author: Lch <fn.stanc@gmail.com>
" Date  : 2018/12/01 16:14:46

"----------------------------------------------------------------------
" 默认情况下的分组，可以再前面覆盖之
"----------------------------------------------------------------------
if !exists('g:bundle_group')
    let g:bundle_group = ['basic', 'airline', 'programming', 'neocomplete']
    let g:bundle_group += ['snippets']
endif

"----------------------------------------------------------------------
" 计算当前 vim-init 的子路径
"----------------------------------------------------------------------
let s:home = fnamemodify(resolve(expand('<sfile>:p')), ':h:h')

function! s:path(path)
    let path = expand(s:home . '/' . a:path )
    return substitute(path, '\\', '/', 'g')
endfunc

let s:plugins_home = s:path("plugins")
let s:vim_plug_home = s:path("vim-plug")

filetype off                    " required!

exec 'set rtp+='.s:vim_plug_home
call plug#begin(s:plugins_home)

"----------------------------------------------------------------------
" 默认插件
"----------------------------------------------------------------------
" Plug 'tomasr/molokai'
Plug 'kaicataldo/material.vim'

if g:os == "Linux"
    Plug 'lilydjwg/fcitx.vim'
endif

if index(g:bundle_group, 'basic') >= 0
    Plug 'scrooloose/nerdtree'
    Plug 'majutsushi/tagbar'

    Plug 'Yggdroot/LeaderF'
    let g:Lf_ShowDevIcons = 0

    " vim-indent-guides
    Plug 'nathanaelkane/vim-indent-guides'
    let g:indent_guides_enable_on_vim_startup = 1
    let g:indent_guides_guide_size = 1
    let g:indent_guides_start_level = 2
    let g:indentLine_color_gui = '#A4E57E'
endif

" ariline
if index(g:bundle_group, 'airline') >= 0
    Plug 'vim-airline/vim-airline'
    let g:airline_enable_syntastic = 0
    let g:airline#extensions#tabline#enabled = 1
endif

" programming
if index(g:bundle_group, 'programming') >= 0
    Plug 'scrooloose/syntastic'
    let g:syntastic_python_checkers = ['flake8']

    Plug 'scrooloose/nerdcommenter'
    Plug 'vim-scripts/a.vim'

    " vim-header
    Plug 'lchannng/vim-header'
    let g:header_field_author = 'lchannng'
    let g:header_field_author_email = 'l.channng@gmail.com'
    let g:header_field_filename_path = 0
    let g:header_field_modified_timestamp = 0
    let g:header_field_modified_by = 0
    let g:header_field_timestamp_format = '%Y/%m/%d %H:%M:%S'

    " pep8
    Plug 'tell-k/vim-autopep8', { 'for' : 'python' }
    autocmd FileType python noremap <buffer> <F11> :call Autopep8()<CR>
endif

" snippets
if index(g:bundle_group, 'snippets') >= 0
    Plug 'SirVer/ultisnips'
    Plug 'honza/vim-snippets'
    let g:UltiSnipsExpandTrigger="<c-j>"
    let g:UltiSnipsJumpForwardTrigger="<c-l>"
    let g:UltiSnipsJumpBackwardTrigger="<c-h>"
endif

" autocomplete
if index(g:bundle_group, 'neocomplete') >= 0
    Plug 'Shougo/neocomplete.vim'

    "Note: This option must set it in .vimrc(_vimrc).  NOT IN .gvimrc(_gvimrc)!
    " Disable AutoComplPop.
    let g:acp_enableAtStartup = 0
    " Use neocomplete.
    let g:neocomplete#enable_at_startup = 1
    " Use smartcase.
    let g:neocomplete#enable_smart_case = 1
    " Set minimum syntax keyword length.
    let g:neocomplete#sources#syntax#min_keyword_length = 3
    let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'

    " Define dictionary.
    let g:neocomplete#sources#dictionary#dictionaries = {
        \ 'default' : '',
        \ 'vimshell' : $HOME.'/.vimshell_hist',
        \ 'scheme' : $HOME.'/.gosh_completions'
            \ }

    " Define keyword.
    if !exists('g:neocomplete#keyword_patterns')
        let g:neocomplete#keyword_patterns = {}
    endif
    let g:neocomplete#keyword_patterns['default'] = '\h\w*'

    " Plugin key-mappings.
    inoremap <expr><C-g>     neocomplete#undo_completion()
    inoremap <expr><C-l>     neocomplete#complete_common_string()

    " Recommended key-mappings.
    " <CR>: close popup and save indent.
    inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
    function! s:my_cr_function()
      return neocomplete#close_popup() . "\<CR>"
      " For no inserting <CR> key.
      "return pumvisible() ? neocomplete#close_popup() : "\<CR>"
    endfunction

    " <TAB>: completion.
    inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"

    " <C-h>, <BS>: close popup and delete backword char.
    inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
    inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
    inoremap <expr><C-y>  neocomplete#close_popup()
    inoremap <expr><C-e>  neocomplete#cancel_popup()

    " Enable omni completion.
    autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
    autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
    autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
    autocmd FileType python setlocal omnifunc=python3complete#Complete
    autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

    " Enable heavy omni completion.
    if !exists('g:neocomplete#sources#omni#input_patterns')
      let g:neocomplete#sources#omni#input_patterns = {}
    endif

    " For perlomni.vim setting.
    " https://github.com/c9s/perlomni.vim
    let g:neocomplete#sources#omni#input_patterns.perl = '\h\w*->\h\w*\|\h\w*::'
endif

call plug#end()            " required
" filetype plugin indent on    " required
