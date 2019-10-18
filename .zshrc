# Created by ilim0t14 for 5.6.2
# .zshrc キャッシュ生成

if [ ${HOME}/.zshrc -nt ${HOME}/.zshrc.zwc ]; then
  zcompile ${HOME}/.zshrc
fi

# 環境変数の設定
export PYENV_ROOT="$HOME/.pyenv"
export EDITOR=vim
path=(
    $HOME/.local/bin(N-/) # added by pipx (https://github.com/pipxproject/pipx)
    /usr/local/sbin(N-/)
    $PYENV_ROOT/bin(N-/)
    $HOME/.nodebrew/current/bin(N-/)
    /usr/local/cuda/bin(N-/)
    $path
)
LD_LIBRARY_PATH=(
    /usr/local/cuda/lib64(N-/)
    $LD_LIBRARY_PATH 
)

# iTerm2
test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"


# pyenv 初期化
eval "$(pyenv init -)"
eval "$(direnv hook zsh)"
export PIPENV_VENV_IN_PROJECT=1
export PIPENV_SKIP_LOCK=1

# zplug settings
source ${HOME}/.zplug/init.zsh

# plugins
zplug 'zplug/zplug', hook-build:'zplug --self-manage'
zplug "zsh-users/zsh-completions"
zplug "zsh-users/zsh-autosuggestions" # 実行したことがあるコマンドの続きを薄く表示 右キーで補完
zplug "zsh-users/zsh-syntax-highlighting", defer:2
zplug "b4b4r07/enhancd", use:init.sh
zplug "modules/completion", from:prezto
zplug "modules/history", from:prezto
zplug "zsh-users/zsh-history-substring-search"

# Install plugins if there are plugins that have not been installed
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

# Then, source plugins and add commands to $PATH
zplug load  --verbose

# PROMPTの設定
autoload -Uz vcs_info
zstyle ':vcs_info:git:*' check-for-changes true
zstyle ':vcs_info:git:*' stagedstr "!"
zstyle ':vcs_info:git:*' unstagedstr "+"
zstyle ':vcs_info:*' formats "%c%u%b"
zstyle ':vcs_info:*' actionformats "%b|%a"

precmd() { vcs_info }
DIR_PROMPT="%K{green}%F{white} %~ %k%f"
SEP1="%F{green}%K{blue}%k%f"
BRANCH_PROMPT="%F{white}%K{blue} "'${vcs_info_msg_0_}'" %k%f%"
SEP2="F{blue}%K{black}%k%f"
AAA="%(?,%F{white},%F{red})%K{black} %(!,#,$) %k%f"
SEP3="%F{black}%f"
export PROMPT="${DIR_PROMPT}${SEP1}${BRANCH_PROMPT}${SEP2}${AAA}${SEP3}"

# カスタマイズ

# Alias
alias tree="tree -N"
alias gitlog="git log --oneline --decorate --graph --branches --tags --remotes"
alias tb="tensorboard --logdir result --samples_per_plugin images=40"
alias brew="env PATH=${PATH//$(pyenv root)\/shims:/} brew"

if [ "$(uname)" = 'Darwin' ]; then
    alias ls="ls -G"
else
    alias ls="ls --color=auto"
fi

if type trash-put &> /dev/null
then
    alias rm=trash-put
fi

# 文字コード指定
export LANG=ja_JP.UTF-8

# 保管機能を有効に (他で読み込まれてるので省略)
# autoload -Uz compinit && compinit

# 色を使用出来るようにする
autoload -Uz colors
colors

# PROMPT変数内で変数参照する
setopt prompt_subst

# コマンドのスペルミスを指摘
setopt correct

# ビープ音の停止
setopt no_beep

# 補完候補表示時のビープ音停止
setopt nolistbeep

# Ctrl-Dを無効に
setopt ignore_eof

# 補完のファイル, フォルダも ls -G と同じく色がつくように
export LS_COLORS='di=34:ln=35:so=32:pi=33:ex=31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}

# zsh-users/zsh-autosuggestions の色
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=8'

# Keyboard shotcut settings
bindkey "^A" vi-beginning-of-line
bindkey "^E" vi-end-of-line
bindkey "^R" history-incremental-search-backward

google(){
    if [ $(echo $1 | egrep "^-[cfs]$") ]; then
        local opt="$1"
        shift
    fi
    local url="https://www.google.co.jp/search?q=${*// /+}"
    local app="/Applications"
    local g="${app}/Google Chrome.app"
    local f="${app}/Firefox.app"
    local s="${app}/Safari.app"

    if [ "$(uname)" = 'Darwin' ]; then
        export OPEN="open"
    else
        export OPEN="xdg-open"
    fi

    case ${opt} in
        "-g")   ${OPEN} "${url}" -a "$g";;
        "-f")   ${OPEN} "${url}" -a "$f";;
        "-s")   ${OPEN} "${url}" -a "$s";;
        *)      ${OPEN} "${url}";;
    esac
    unset OPEN
}

alias lzd='lazydocker'
alias pbcopy='xsel --clipboard --input'

if [ "$(uname)" = 'Linux' ]; then
    alias open='xdg-open'
fi

# 計測用
# if type zprof > /dev/null 2>&1; then
#   zprof | less
# fi

