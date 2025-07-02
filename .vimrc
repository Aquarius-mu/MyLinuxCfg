" 插件管理
set nocompatible
filetype off

set rtp+=~/3party/vimconfig/bundle/Vundle.vim
call vundle#begin()
Pluginfile '///home/sjd/3party/vimconfig/bundle/Vundle.vim'
Pluginfile '///home/sjd/3party/vimconfig/bundle/vim-fswitch'
Pluginfile '///home/sjd/3party/vimconfig/bundle/vim-cpp-enhanced-highlight'
call vundle#end()
filetype plugin indent on
" 常用的命令
" :PluginList       - 列出所有已配置的插件
" :PluginInstall  	 - 安装插件,追加 `!` 用以更新或使用 :PluginUpdate
" :PluginSearch foo - 搜索 foo ; 追加 `!` 清除本地缓存
" :PluginClean      - 清除未使用插件,需要确认; 追加 `!` 自动批准移除未使用插件

" 设置行号
set number
" 取消行号
:map! <C-n> <ESC>:set nonumber<CR>

" 语法高亮
syntax on

" auto file type
filetype on
filetype indent on
filetype plugin on
set cscopetag

" 缩进设置
set tabstop=4
set backspace=indent,eol,start
set smartindent
set shiftwidth=4
set smarttab
set expandtab
set softtabstop=4
set autoindent

" 显示括号匹配
set showmatch
" 括号匹配时间为1
set matchtime=1

" ctrl + \ 推出文件  
:map! <C-\> <ESC>:q<CR>  

" svn blame插件 v选中后按bm输出blame结果
vmap bl :<C-U>!svn blame <C-R>=expand("%p") <CR> \| sed -n <C-R>=line("'<") <CR>,<C-R>=line("'>") <CR>p<CR>

" cpp vim增强版  需要插件vim-cpp-enhanced-highlight
"let g:cpp_class_scope_highlight = 1  
let g:cpp_member_variable_highlight = 1  
hi cppMemberVariable guifg=#964B00 gui=bold  
let g:cpp_class_decl_highlight = 1  
let g:cpp_no_function_highlight = 1  

" sw键H和CPP切换  需要插件vim-fswitch
nnoremap sw :FSHere<CR>  

" 设置高亮搜索  
set hlsearch  
" 在搜索时，输入的词句逐字符高亮  
set incsearch  

" smart search case sensitivevim  
set ignorecase smartcase  

" 设置编码自动识别，中文引导显示  
set fileencodings=zh_CN.GB2312

" 设置C/C++代码缩进风格,几乎完美
set cinoptions=g0,i0,5s,+0,:0,10,5s,(0,t0,N-s

" 输入C/C++代码时自动缩进
set cindent

" 使用ctags跳转到定义
set tags=./tags,tags,$HOME

" 自动补全窗口颜色设置
highlight Pmenu  ctermfg=black ctermbg=lightgrey guibg=#444444 guifg=#ffffff  " 补全菜单颜色
highlight PmenuSel ctermfg=white ctermbg=darkgreen guibg=#555555 guifg=#ffffff  " 选中项颜色

" 文件头注释模板（F10触发）
map <F10> :call TitleDet()<cr>'s
function AddTitle()
    call append(00,"//")
    call append(01,"// 功能: ")
    call append(02,"//")
    call append(03,"// 作者: sunjiadong")
    call append(04,"//")
    call append(05,"// 修订: ")
    call append(06,"// - [".strftime("%Y-%m-%d")."] 增加XXX功能 (by sunjiadong)")
    call append(07,"//")
    echohl warningMsg | echo "Successful!" | echohl None
endfunction

" 更新文件头
function UpdateTitle(line)
    normal m'
    call append(a:line,"// - [".strftime("%Y-%m-%d").") 本次做了XXX修改 (by sunjiadong)")
    normal ''
    echohl warningMsg | echo "Successful in updating the copy right." | echohl None
endfunction

" 添加或更新文件头
function TitleDet()
    let n=100
    while n > 1
        let line = getline(n)
        if line =~ '^\/\/\s\s\s\s-'
            call UpdateTitle(n)
            return
        endif
        let n = n - 1
    endwhile
    call AddTitle()
endfunction
