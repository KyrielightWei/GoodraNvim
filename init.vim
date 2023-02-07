" 防止重复加载
if get(s:, 'loaded', 0) != 0
	finish
else
	let s:loaded = 1
endif

" 取得本文件所在的目录
let g:config_home = fnamemodify(resolve(expand('<sfile>:p')), ':h')

" 定义一个命令用来加载文件
command! -nargs=1 LoadScript exec 'so '.g:config_home.'/'.'<args>'

" 将 vim-init 目录加入 runtimepath
exec 'set rtp+='.g:config_home

" 将 ~/.vim 目录加入 runtimepath (有时候 vim 不会自动帮你加入）
set rtp+=~/.nvim


"----------------------------------------------------------------------
" 模块加载
"----------------------------------------------------------------------

" 加载基础配置
LoadScript init/init-basic.vim

" 加载扩展配置
LoadScript init/init-config.vim

" 设定 tabsize
LoadScript init/init-tabsize.vim

" 插件加载
"  LoadScript init/init-plugins.vim
lua require('init')

let g:neoformat_cpp_clangformat = {
    \ 'exe': 'clang-format',
    \ 'args': ['--style="{
    \           BasedOnStyle: LLVM,
    \           AccessModifierOffset: -2,
    \           AlignEscapedNewlines: Left,
    \           AlignOperands : true,
    \           AlwaysBreakTemplateDeclarations: true,
    \           BinPackArguments: true,
    \           BinPackParameters: false,
    \           BreakBeforeBinaryOperators: NonAssignment,
    \           Standard: Auto,
    \           IndentWidth: 2,
    \           BreakBeforeBraces: Custom,
    \           BraceWrapping:
    \              {AfterClass:      true,
    \              AfterControlStatement: false,
    \              AfterEnum:       true,
    \              AfterFunction:   true,
    \              AfterNamespace:  true,
    \              AfterObjCDeclaration: false,
    \              AfterStruct:     true,
    \              AfterUnion:      true,
    \              AfterExternBlock: true,
    \              BeforeCatch:     false,
    \              BeforeElse:      false,
    \              IndentBraces:    false,
    \              SplitEmptyFunction: false,
    \              SplitEmptyRecord: false,
    \              SplitEmptyNamespace: false},
    \           ColumnLimit: 100,
    \           AllowAllParametersOfDeclarationOnNextLine: false,
    \           AlignAfterOpenBracket: true}"'],
    \ 'stdin' : 1,
    \ 'stderr' : 1,
  \}
  " let g:neoformat_verbose = 1 " only affects the verbosity of Neoformat
  let g:neoformat_enabled_cpp = ['clangformat']
  let g:neoformat_enabled_c = ['clangformat']
" let g:rainbow_active = 1
" 	 let g:rainbow_conf = {
" 	 \	'guifgs': ['royalblue3', 'darkorange3', 'seagreen3', 'firebrick'],
" 	 \	'ctermfgs': ['lightblue', 'lightyellow', 'lightcyan', 'lightmagenta'],
" 	 \	'operators': '_,_',
" 	 \	'parentheses': ['start=/(/ end=/)/ fold', 'start=/\[/ end=/\]/ fold', 'start=/{/ end=/}/ fold'],
" 	 \	'separately': {
" 	 \		'*': {},
" 	 \		'tex': {
" 	 \			'parentheses': ['start=/(/ end=/)/', 'start=/\[/ end=/\]/'],
" 	 \		},
" 	 \		'lisp': {
" 	 \			'guifgs': ['royalblue3', 'darkorange3', 'seagreen3', 'firebrick', 'darkorchid3'],
" 	 \		},
" 	 \		'vim': {
" 	 \			'parentheses': ['start=/(/ end=/)/', 'start=/\[/ end=/\]/', 'start=/{/ end=/}/ fold', 'start=/(/ end=/)/ containedin=vimFuncBody', 'start=/\[/ end=/\]/ containedin=vimFuncBody', 'start=/{/ end=/}/ fold containedin=vimFuncBody'],
" 	 \		},
" 	 \		'html': {
" 	 \			'parentheses': ['start=/\v\<((area|base|br|col|embed|hr|img|input|keygen|link|menuitem|meta|param|source|track|wbr)[ >])@!\z([-_:a-zA-Z0-9]+)(\s+[-_:a-zA-Z0-9]+(\=("[^"]*"|'."'".'[^'."'".']*'."'".'|[^ '."'".'"><=`]*))?)*\>/ end=#</\z1># fold'],
" 	 \		},
" 	 \		'css': 0,
" 	 \	}
" 	 \}
nnoremap <silent> <leader>p :BufferPick<CR>
nnoremap <C-n> :NvimTreeToggle<CR>:NvimTreeRefresh<CR>
let g:asyncrun_open = 6
let g:asynctasks_term_pos = 'tab'
let g:asynctasks_term_reuse = 1
nnoremap gd <cmd>lua require'telescope.builtin'.lsp_definitions{}<CR>
nnoremap gr <cmd>lua require'telescope.builtin'.lsp_references{}<CR>
nnoremap gD <cmd>lua require'telescope.builtin'.lsp_declaration{}<CR>
nnoremap K <cmd>lua require'telescope.builtin'.lsp_hover{}<CR>
nnoremap gi <cmd>lua require'telescope.builtin'.lsp_implementations{}<CR>
nnoremap gy <cmd>lua require'telescope.builtin'.lsp_type_definitions{}<CR>
nnoremap <space>d <cmd>lua require'telescope.builtin'.diagnostics{}<CR>
nnoremap <space>o <cmd>lua require'telescope.builtin'.lsp_document_symbols{}<CR>
nnoremap <space>w <cmd>lua require'telescope.builtin'.lsp_workspace_symbols{}<CR>
nnoremap <space>f <cmd>lua require'telescope.builtin'.find_files({cwd=vim.call("asyncrun#get_root","%")})<CR>
nnoremap <space>g <cmd>lua require'telescope.builtin'.git_files{}<CR>
nnoremap <space>b <cmd>lua require'telescope.builtin'.buffers{}<CR>
nnoremap <space>h <cmd>lua require'telescope.builtin'.oldfiles{}<CR>
nnoremap <space>s <cmd>lua require'telescope.builtin'.live_grep{}<CR>
nnoremap <space>t <cmd>lua require('telescope').extensions.asynctasks.all()<CR>

" 界面样式
LoadScript init/init-style.vim

" 自定义按键
LoadScript init/init-keymaps.vim
