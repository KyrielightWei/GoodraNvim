ZINIT_HOME="${HOME}/.local/share/zinit/zinit.git"
[ ! -d $ZINIT_HOME ] && mkdir -p "$(dirname $ZINIT_HOME)"
[ ! -d $ZINIT_HOME/.git ] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
source "${ZINIT_HOME}/zinit.zsh"

#source ~/.bashrc
# SELF_DEV_FILE=~/.self_dev_env.sh
# if [ -f "$SELF_DEV_FILE" ]; then 
#   source $SELF_DEV_FILE
#   echo "source $SELF_DEV_FILE"
# fi

# 快速目录跳转
zinit ice lucid wait='1'
zinit light skywind3000/z.lua

# 语法高亮
zinit ice lucid wait='0' atinit='zpcompinit'
zinit light zdharma/fast-syntax-highlighting

# 自动建议
zinit ice lucid wait="0" atload='_zsh_autosuggest_start'
zinit light zsh-users/zsh-autosuggestions

# 补全
zinit ice lucid wait='0'
zinit light zsh-users/zsh-completions

# 加载 OMZ 框架及部分插件
zinit snippet OMZ::lib/completion.zsh
zinit snippet OMZ::lib/history.zsh
zinit snippet OMZ::lib/key-bindings.zsh
zinit snippet OMZ::lib/theme-and-appearance.zsh
zinit snippet OMZ::plugins/colored-man-pages/colored-man-pages.plugin.zsh
zinit snippet OMZ::plugins/sudo/sudo.plugin.zsh

zinit snippet OMZ::plugins/svn/svn.plugin.zsh

zinit ice 
zinit snippet OMZP::extract/

zinit ice lucid wait='1'
zinit snippet OMZ::plugins/git/git.plugin.zsh
zinit snippet PZT::modules/helper/init.zsh

zinit snippet OMZ::lib/theme-and-appearance.zsh
zinit snippet OMZ::lib/git.zsh
zinit snippet OMZ::themes/ys.zsh-theme

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
