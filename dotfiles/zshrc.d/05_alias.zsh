###########################################
# 利便性向上
###########################################

# git log の描画を改善
if (( $+commands[emojify] )); then
    alias gitlog="git log --oneline --decorate --graph --branches --tags --remotes --color | emojify | less -rX"
else
    alias gitlog="git log --oneline --decorate --graph --branches --tags --remotes"
fi

# rmで完全削除せずに、ゴミ箱相当の場所へ送るように
if (( $+commands[trash-put] )); then
    alias rm=trash-put
fi

###########################################
# 問題の修正
###########################################

alias tree="tree -N" # 日本語を文字化けせずに表示するため

# pyenvで作成されるconfigがbrew doctorで警告されるから
# 検証中, 警告されなくなった?
# if [ $+commands[pyenv] -a $+commands[brew] ]; then
#     alias brew='env PATH=${PATH//$(pyenv root)\/shims/} brew'
# fi

###########################################
# 互換性
###########################################

case $OSTYPE in
darwin*)
    # ls を色付きに
    alias ls="ls -G"
    ;;
linux*)
    # ls を色付きに
    alias ls="ls --color=auto"

    # OS間の互換性のため
    alias open="xdg-open"
    ;;
esac

###########################################
# 簡略化
###########################################

alias lzd='lazydocker'
alias dockerprune='docker image prune -f && docker container prune -f && docker volume prune -f && docker network prune -f'
