" Modeline and Notes  throws an error... 
" vim: set foldmarker={,} foldlevel=0 foldmethod=marker ft=vim
"
"	This is the personal .vimrc file of Steve Francia.
"	While much of it is beneficial for general use, I would
"	recommend picking out the parts you want and understand.
"
"	You can find me at http://spf13.com
" }

" Environment {
	" Basics {
		set nocompatible 		" must be first line
		set background=dark     " Assume a dark background
	" }

	" Windows Compatible {
		" On Windows, also use '.vim' instead of 'vimfiles'; this makes synchronization
		" across (heterogeneous) systems easier. 
		if has('win32') || has('win64')
		  set runtimepath=$HOME/.vim,$VIM/vimfiles,$VIMRUNTIME,$VIM/vimfiles/after,$HOME/.vim/after
		endif
	" }
    " 
	" Setup Bundle Support {
	" The next two lines ensure that the ~/.vim/bundle/ system works
		runtime! autoload/pathogen.vim
		silent! call pathogen#helptags()
		silent! call pathogen#runtime_append_all_bundles()
	" }

" }

" General {
	set background=dark         " Assume a dark background
    "if !has('win32') && !has('win64') " throws an error... 
        "set term=$TERM       " Make arrow and other keys work
    "endif
	filetype plugin indent on  	" Automatically detect file types.
	syntax on 					" syntax highlighting
	set mouse=a					" automatically enable mouse usage
	scriptencoding utf-8

	set shortmess+=filmnrxoOtT     	" abbrev. of messages (avoids 'hit enter')
	"set iewoptions=folds,options,cursor,unix,slash " better unix / windows compatibility
	set virtualedit=onemore 	   	" allow for cursor beyond last character
	set history=1000  				" Store a ton of history (default is 20)
	set nospell 		 	        	" spell checking off
    set shell=/bin/sh
   
	
	" Setting up the directories {
		set backup 						" backups are nice ...
	" }
" }

" Vim UI {
    colorscheme darkspectrum
    set gfn=Monaco\ 12
	set tabpagemax=15 				" only show 15 tabs
	set showmode                   	" display the current mode

	set cursorline  				" highlight current line
	hi cursorline guibg=#333333 	" highlight bg color of current line
	hi CursorColumn guibg=#333333   " highlight cursor

	if has('cmdline_info')
		set ruler                  	" show the ruler
		set rulerformat=%30(%=\:b%n%y%m%r%w\ %l,%c%V\ %P%) " a ruler on steroids
		set showcmd                	" show partial commands in status line and
									" selected characters/lines in visual mode
	endif

	if has('statusline')
        set laststatus=2
		" Broken down into easily includeable segments
		set statusline=%<%f\    " Filename
		set statusline+=%w%h%m%r " Options
		set statusline+=%{fugitive#statusline()} "  Git Hotness
		set statusline+=\ [%{&ff}/%Y]            " filetype
		set statusline+=\ [%{getcwd()}]          " current dir
        set statusline+=\ i:%{WhatIndent()}
		"set statusline+=\ [A=\%03.3b/H=\%02.2B] " ASCII / Hexadecimal value of char
		set statusline+=%=%-14.(%l,%c%V%)\ %p%%  " Right aligned file nav info
	endif

	set backspace=indent,eol,start	" backspace for dummys
	set linespace=0					" No extra spaces between rows
	set nu							" Line numbers on
	set noshowmatch					" show matching brackets/parenthesis
	set incsearch					" find as you type search
	set hlsearch					" highlight search terms
	"set winminheight=0				" windows can be 0 line high 
	set ignorecase					" case insensitive search
	set smartcase					" case sensitive when uc present
	set wildmenu					" show list instead of just completing
	set wildmode=list:longest,full	" command <Tab> completion, list matches, then longest common part, then all.
	set whichwrap=b,s,<,>,[,]	" backspace and cursor keys wrap to
	set scrolljump=5 				" lines to scroll when cursor leaves screen
	set scrolloff=3 				" minimum lines to keep above and below cursor
	set foldmethod=marker
	set gdefault					" the /g flag on :s substitutions by default
    set nolist
    set listchars=tab:▸\ ,eol:¬
	set hidden
" }

" Formatting {
	set nowrap                     	" wrap long lines
	set noautoindent                " indent at the same level of the previous line
	set nosmartindent				
	set shiftwidth=4               	" use indents of 4 spaces
	" use tabs
    set noexpandtab
    set tabstop=4 					" an indentation every four columns
    set softtabstop=4 				" let backspace delete indent
	" dontuse tabs
	"set expandtab
	"set tabstop=4 					" an indentation every four columns
	"set softtabstop=4 				" let backspace delete indent
	" use spaces for php and yaml
	au FileType php setlocal expandtab
	au FileType php setlocal softtabstop=4
	au FileType php setlocal ts=4
	au FileType php setlocal shiftwidth=4
	au FileType yaml setlocal expandtab
	au FileType yaml setlocal softtabstop=2
	au FileType yaml setlocal ts=2
	au FileType yaml setlocal shiftwidth=2
	"todo plugin files: wrap text, it is local to window
	au FileType * setlocal nowrap
	au FileType todo setlocal wrap
	au FileType todo setlocal linebreak
	let &showbreak = '> '
" }

" Key (re)Mappings {

	"The default leader is '\', but many people prefer ',' as it's in a standard
	"location
	let mapleader = ','

	" Easier moving in tabs and windows
	map <C-J> <C-W>j<C-W>_
	map <C-K> <C-W>k<C-W>_
	map <C-L> <C-W>l<C-W>_
	map <C-H> <C-W>h<C-W>_
	map <C-K> <C-W>k<C-W>_

    " moving lines
    nnoremap <A-j> :m+<CR>==
    nnoremap <A-k> :m-2<CR>==
    inoremap <A-j> <Esc>:m+<CR>==gi
    inoremap <A-k> <Esc>:m-2<CR>==gi
    vnoremap <A-j> :m'>+<CR>gv=gv
    vnoremap <A-k> :m-2<CR>gv=gv

	
    " Wrapped lines goes down/up to next row, rather than next line in file.
    nnoremap j gj
    nnoremap k gk

	" Yank from the cursor to the end of the line, to be consistent with C and D.
	nnoremap Y y$
		
	""" Code folding options
	nmap <leader>f0 :set foldlevel=0<CR>
	nmap <leader>f1 :set foldlevel=1<CR>
	nmap <leader>f2 :set foldlevel=2<CR>
	nmap <leader>f3 :set foldlevel=3<CR>
	nmap <leader>f4 :set foldlevel=4<CR>
	nmap <leader>f5 :set foldlevel=5<CR>
	nmap <leader>f6 :set foldlevel=6<CR>
	nmap <leader>f7 :set foldlevel=7<CR>
	nmap <leader>f8 :set foldlevel=8<CR>
	nmap <leader>f9 :set foldlevel=9<CR>

    "clearing highlighted search
    nmap <silent> <leader>/ :nohlsearch<CR>

	" Shortcuts
	" Change Working Directory to that of the current file
    cmap cwd lcd %:p:h
	cmap cd. lcd %:p:h

	" visual shifting (does not exit Visual mode)
    vnoremap < <gv
    vnoremap > >gv 

	" For when you forget to sudo.. Really Write the file.
	cmap w!! w !sudo tee % >/dev/null

    " Shortcut to rapidly toggle `set list`
    nmap <leader>l :set list!<CR>

    "tabs vs spaces indent
    nmap <leader>i :call ToggleTabs()<CR>
" }

" Plugins {
	" Gundo " {
		nnoremap <F6> :GundoToggle<CR>
	" }
	" Fugitive " {
		nmap ,gs :Gstatus<CR>
		"nmap ,cw :cw<CR>
		autocmd BufReadPost fugitive://* set bufhidden=delete
	" }
	
	
	" Supertab {
		let g:SuperTabMappingForward = '<c-space>'
		let g:SuperTabMappingBackward = '<s-c-space>'

		let g:SuperTabDefaultCompletionType = "<c-p>"
	" }

	" Misc { 
		"comment out line(s) in visual mode -RB: If you do this, you can't
        "switch sides of the comment block in visual mode.
		"vmap  o  :call NERDComment(1, 'toggle')<CR>
		let g:NERDShutUp=1

		let b:match_ignorecase = 1
	" }
	
	" Syntastics { 
		let g:syntastic_enable_signs=1	
		let g:syntastic_auto_loc_list=1
		let g:syntastic_jshint_conf= '~/vim/jshint.config.json'
	" }
	
	" ShowMarks {
		let showmarks_include = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
		" Don't leave on by default, use :ShowMarksOn to enable
		let g:showmarks_enable = 0
		" For marks a-z
		highlight ShowMarksHLl gui=bold guibg=LightBlue guifg=Blue
		" For marks A-Z
		highlight ShowMarksHLu gui=bold guibg=LightRed guifg=DarkRed
		" For all other marks
		highlight ShowMarksHLo gui=bold guibg=LightYellow guifg=DarkYellow
		" For multiple marks on the same line.
		highlight ShowMarksHLm gui=bold guibg=LightGreen guifg=DarkGreen
	" }
	
	" Command-t {
		nmap ,t :CommandT<CR>
	" }

	" OmniComplete {
		"if has("autocmd") && exists("+omnifunc")
			"autocmd Filetype *
				"\if &omnifunc == "" |
				"\setlocal omnifunc=syntaxcomplete#Complete |
				"\endif
		"endif

		" Popup menu hightLight Group
		"highlight Pmenu	ctermbg=13	guibg=DarkBlue
        "highlight PmenuSel	ctermbg=7	guibg=DarkBlue		guifg=LightBlue
		"highlight PmenuSbar ctermbg=7	guibg=DarkGray
		"highlight PmenuThumb			guibg=Black

		"hi Pmenu  guifg=#000000 guibg=#F8F8F8 ctermfg=black ctermbg=Lightgray
		"hi PmenuSbar  guifg=#8A95A7 guibg=#F8F8F8 gui=NONE ctermfg=darkcyan ctermbg=lightgray cterm=NONE
		"hi PmenuThumb  guifg=#F8F8F8 guibg=#8A95A7 gui=NONE ctermfg=lightgray ctermbg=darkcyan cterm=NONE

		" some convenient mappings 
		inoremap <expr> <Esc>      pumvisible() ? "\<C-e>" : "\<Esc>"
		inoremap <expr> <CR>       pumvisible() ? "\<C-y>" : "\<CR>"
		inoremap <expr> <Down>     pumvisible() ? "\<C-n>" : "\<Down>"
		inoremap <expr> <Up>       pumvisible() ? "\<C-p>" : "\<Up>"
		inoremap <expr> <C-d>	   pumvisible() ? "\<PageDown>\<C-p>\<C-n>" : "\<C-d>"
		inoremap <expr> <C-u>      pumvisible() ? "\<PageUp>\<C-p>\<C-n>" : "\<C-u>"

        " and make sure that it doesn't break supertab
        let g:SuperTabCrMapping = 0
        
		" automatically open and close the popup menu / preview window
		au CursorMovedI,InsertLeave * if pumvisible() == 0|silent! pclose|endif
		set completeopt=menu,preview,longest
	" }
	
	" Ctags {
    " This will look in the current directory for 'tags', and work up the tree towards root until one is found. 
		set tags=./tags;/,$HOME/vimtags
        map <C-\> :tab split<CR>:exec("tag ".expand("<cword>"))<CR> " C-\ - Open the definition in a new tab
        map <A-]> :vsp <CR>:exec("tag ".expand("<cword>"))<CR>      " A-] - Open the definition in a vertical split
	" }

	" EasyTags {
       " Disabling for now. It doesn't work well on large tag files 
        let g:loaded_easytags = 1  " Disable until it's working better
		let g:easytags_cmd = 'ctags'
        let g:easytags_dynamic_files = 1
		if !has('win32') && !has('win64')
            let g:easytags_resolve_links = 1
        endif
	" }

	" Delimitmate {
		"let b:delimitMate_autoclose = 0 

		"au FileType * let b:delimitMate_autoclose = 0 
		au FileType * let b:delimitMate_expand_cr = 0

		" If using html auto complete (complete closing tag)
        au FileType xml,html,xhtml let b:delimitMate_matchpairs = "(:),[:],{:}"
	" }
	
	" AutoCloseTag {
		" Make it so AutoCloseTag works for xml and xhtml files as well
		au FileType xhtml,xml ru ftplugin/html/autoclosetag.vim
	" }

	" SnipMate {
		" Setting the author var
        " If forking, please overwrite in your .vimrc.local file
		let g:snips_author = 'Steve Francia <steve.francia@gmail.com>'
		" Shortcut for reloading snippets, useful when developing
		nnoremap ,smr <esc>:exec ReloadAllSnippets()<cr>
	" }

	" NerdTree {
		map <F2> :NERDTreeToggle<CR>
		"map <C-e> :NERDTreeToggle<CR>:NERDTreeMirror<CR>
		map <leader>e :NERDTreeFind<CR>
		nmap <leader>nt :NERDTreeFind<CR>

		let NERDTreeShowBookmarks=1
		let NERDTreeIgnore=['\.pyc', '\~$', '\.swo$', '\.swp$', '\.git', '\.hg', '\.svn', '\.bzr']
		let NERDTreeChDirMode=0
		let NERDTreeQuitOnOpen=0
		let NERDTreeShowHidden=1
		let NERDTreeKeepTreeInNewTab=1
	" }
    
	" Richard's plugins {
		" Fuzzy Finder {
			""" Fuzzy Find file, tree, buffer, line
			nmap <leader>ff :FufFile **/<CR>
			nmap <leader>ft :FufFile<CR>
			nmap <leader>fb :FufBuffer<CR>
			nmap <leader>fl :FufLine<CR>
			nmap <leader>fr :FufRenewCache<CR>
		" }

		" Session List {
			set sessionoptions=blank,buffers,curdir,folds,tabpages,winsize
			nmap <leader>sl :SessionList<CR>
			nmap <leader>ss :SessionSave<CR>
		" }
		
		" Buffer explorer {
			nmap <leader>b :BufExplorer<CR>
			nmap \be <leader>be
            let g:bufExplorerShowRelativePath=1
		" }
		
		" php-doc commands {
			nmap <leader>pd :call PhpDocSingle()<CR>
			vmap <leader>pd :call PhpDocRange()<CR>
		" }
		
		" Debugging with VimDebugger {
			"map <F11> :DbgStepInto<CR>
			"map <F10> :DbgStepOver<CR>
			"map <S-F11> :DbgStepOut<CR>
			"map <F5> :DbgRun<CR>
			"map <F6> :DbgDetach<CR>
			"map <F8> :DbgToggleBreakpoint<CR>
			"map <S-F8> :DbgFlushBreakpoints<CR>
			"map <F9> :DbgRefreshWatch<CR>
			"map <S-F9> :DbgAddWatch<CR>
		" }

		" Tagbar Variables {
			map <F8> :TagbarToggle<CR>
		" }

		" JSON {
			nmap <leader>jt <Esc>:%!python -m json.tool<CR><Esc>:set filetype=json<CR>
		 " }
	" }
" }

" GUI Settings {
	" GVIM- (here instead of .gvimrc)
	if has('gui_running')
		set guioptions-=T          	" remove the toolbar
		set ghr=0
		"set lines=40               	" 40 lines of text instead of 24,
	else 
		set term=builtin_ansi       " Make arrow and other keys work
	endif
" }

function! InitializeDirectories()
  let separator = "."
  let parent = $HOME 
  let prefix = '.vim'
  let dir_list = { 
			  \ 'backup': 'backupdir', 
			  \ 'views': 'viewdir', 
			  \ 'swap': 'directory' }

  for [dirname, settingname] in items(dir_list)
	  let directory = parent . '/' . prefix . dirname . "/"
	  if exists("*mkdir")
		  if !isdirectory(directory)
			  call mkdir(directory)
		  endif
	  endif
	  if !isdirectory(directory)
		  echo "Warning: Unable to create backup directory: " . directory
		  echo "Try: mkdir -p " . directory
	  else  
          let directory = substitute(directory, " ", "\\\\ ", "")
          exec "set " . settingname . "=" . directory
	  endif
  endfor
endfunction
call InitializeDirectories() 

function! NERDTreeInitAsNeeded()
    redir => bufoutput
    buffers!
    redir END
    let idx = stridx(bufoutput, "NERD_tree")
    if idx > -1
        NERDTreeMirror
        NERDTreeFind
        wincmd l
    endif
endfunction

" Use local vimrc if available {
    if filereadable(expand("~/.vimrc.local"))
        source ~/.vimrc.local
    endif
" }
"
"
function! UseTabs()
    set noexpandtab
    set tabstop=4 					" an indentation every four columns
    set softtabstop=4 				" let backspace delete indent
endfunction

function! DontUseTabs()
	set expandtab
	set tabstop=4 					" an indentation every four columns
	set softtabstop=4 				" let backspace delete indent
endfunction

function! ToggleTabs()
    if &expandtab
        call UseTabs()
    else 
        call DontUseTabs()
    endif
endfunction

function! WhatIndent() 
    if &expandtab
        return "SPACE"
    else
        return "TAB"
	endif
endfunction
