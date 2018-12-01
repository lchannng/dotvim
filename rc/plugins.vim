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

let s:bundle_home = s:path("bundle")
let s:vundle_home = s:path("bundle/Vundle.vim")

filetype off                    " required!

exec 'set rtp+='.s:vundle_home
call vundle#begin(s:bundle_home)

" let Vundle manage Vundle
Plugin 'VundleVim/Vundle.vim'

"----------------------------------------------------------------------
" 默认插件
"----------------------------------------------------------------------
Plugin 'tomasr/molokai'
Plugin 'lilydjwg/fcitx.vim'

if index(g:bundle_group, 'basic') >= 0
    Plugin 'scrooloose/nerdtree'
    Plugin 'majutsushi/tagbar'

    " ag
    Plugin 'rking/ag.vim'
    let g:ag_prg = 'ag --nogroup --nocolor --column --smart-case --worker=4'
    let g:ag_highlight = 1

    " vim-indent-guides
    Plugin 'nathanaelkane/vim-indent-guides'
    let g:indent_guides_enable_on_vim_startup = 1
    let g:indent_guides_guide_size = 1
    let g:indent_guides_start_level = 2
    let g:indentLine_color_gui = '#A4E57E'
endif

" ariline
if index(g:bundle_group, 'airline') >= 0
    if has("gui_running")
        Plugin 'bling/vim-airline'
        "let g:airline_enable_branch     = 1
        let g:airline_enable_syntastic = 0
    endif
endif

" programming
if index(g:bundle_group, 'programming') >= 0
    Plugin 'scrooloose/syntastic'
    Plugin 'scrooloose/nerdcommenter'
    Plugin 'a.vim'

    " vim-header
    Plugin 'fnstanc/vim-header'
    let g:header_field_author = 'Lch'
    let g:header_field_author_email = 'fn.stanc@gmail.com'
    let g:header_field_filename_path = 0
    let g:header_field_modified_timestamp = 0
    let g:header_field_modified_by = 0
    let g:header_field_timestamp_format = '%Y/%m/%d %H:%M:%S'

    " pep8
    Plugin 'vim-autopep8'
    autocmd FileType python noremap <buffer> <F11> :call Autopep8()<CR>
endif

" snippets
if index(g:bundle_group, 'snippets') >= 0
    Plugin 'SirVer/ultisnips'
    Plugin 'honza/vim-snippets'
    let g:UltiSnipsExpandTrigger="<c-j>"
    let g:UltiSnipsJumpForwardTrigger="<c-l>"
    let g:UltiSnipsJumpBackwardTrigger="<c-h>"
endif

" autocomplete
if index(g:bundle_group, 'neocomplete') >= 0
    Plugin 'Shougo/neocomplete.vim'

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
    autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
    autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

    " Enable heavy omni completion.
    if !exists('g:neocomplete#sources#omni#input_patterns')
      let g:neocomplete#sources#omni#input_patterns = {}
    endif

    " For perlomni.vim setting.
    " https://github.com/c9s/perlomni.vim
    let g:neocomplete#sources#omni#input_patterns.perl = '\h\w*->\h\w*\|\h\w*::'
endif

call vundle#end()            " required
filetype plugin indent on    " required
