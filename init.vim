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

" 界面样式
LoadScript init/init-style.vim

" 自定义按键
LoadScript init/init-keymaps.vim
