# Created by ilim0t14 for 5.6.2

# zsh起動時の速度計測用 (不要なら以下1行をコメントアウト)
# zmodload zsh/zprof && zprof


# .zshrc のキャッシュを生成
if [ ! -e $HOME/.zshrc.zwc ] || [ $HOME/.zshrc -nt $HOME/.zshrc.zwc ]; then
  zcompile $HOME/.zshrc
fi


# 環境変数の設定
path=(
    $HOME/.local/bin(N-/) # added by pipx (https://github.com/pipxproject/pipx)
    /usr/local/sbin(N-/)  # brew doctor より
    $HOME/.nodebrew/current/bin(N-/)  # nodebrew
    /usr/local/cuda/bin(N-/)
    $path
)

export LD_LIBRARY_PATH=(
    /usr/local/cuda/lib64(N-/)
    $LD_LIBRARY_PATH 
)


# zplugの読み込み
source $HOME/.zplug/init.zsh

# zplug plugins
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


# zshの設定

# autoload

# 補完機能を有効に (既に他で読み込まれてるので軽量化のためコメントアウト)
# autoload -Uz compinit && compinit

# 色を文字で指定出来るようにする (Promptに限らず，black, greenなどと表現可能に)
autoload -Uz colors && colors

# vcs_info関数をロード (Prompt内にgitの状況を表示するために利用)
autoload -Uz vcs_info

# setopt

# PROMPT内の変数参照を展開する
setopt prompt_subst

# コマンドのスペルミスを指摘する
setopt correct

#引数のスペルの訂正を使用する
unsetopt CORRECT_ALL

# ビープ音削除
setopt no_beep

# 補完候補表示時のビープ音削除
setopt nolistbeep

# Ctrl-Dを無効に
setopt ignore_eof

# zstyle

# 補完のファイル, フォルダも ls -G と同じく色がつくように
export LS_COLORS='di=34:ln=35:so=32:pi=33:ex=31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}

# zsh-users/zsh-autosuggestions の色
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=8'

# Keyboard shotcut settings
bindkey "^A" vi-beginning-of-line
bindkey "^E" vi-end-of-line
bindkey "^R" history-incremental-search-backward


# Prompt setting
# 参照: http://zsh.sourceforge.net/Doc/Release/Prompt-Expansion.html

# precmd はprompt表示毎に実行される関数
# 他に用いないので add-zsh-hook を使うのではなく直接定義する
precmd() {
    vcs_info
}

# vcsの表示設定
zstyle ':vcs_info:git:*' check-for-changes true
zstyle ':vcs_info:git:*' stagedstr "!"
zstyle ':vcs_info:git:*' unstagedstr "+"
zstyle ':vcs_info:*' formats "%c%u%b"
zstyle ':vcs_info:*' actionformats "%b|%a"

TEXT_COLOR="white"
COLOR1="green"
COLOR2="blue"
COLOR3="black"

# %F: 文字色
# %K: 背景色
# %f, %k: それぞれの色のリセット

# %~: カレントディレクトリ(フルパス, home以下省略)
DIR_PROMPT="%K{$COLOR1}%F{$TEXT_COLOR} %~ %k%f"
SEP1="%K{$COLOR2}%F{$COLOR1}%k%f"
BRANCH_PROMPT="%K{$COLOR2}%F{$TEXT_COLOR} "'${vcs_info_msg_0_}'" %k%f"
SEP2="%K{$COLOR3}%F{$COLOR2}%k%f"
# %(A,B,C): if A then B else C
# ?: 直前コマンドの返り値
# !: rootユーザーかどうか
MARK_PROMPT="%K{$COLOR3}%(?,%F{$TEXT_COLOR},%F{red}) %(!,#,$) %k%f"
SEP3="%F{$COLOR3}%f"
export PROMPT="${DIR_PROMPT}${SEP1}${BRANCH_PROMPT}${SEP2}${MARK_PROMPT}${SEP3}"


# pyenv
if (( $+commands[pyenv] )); then
    # eval "$(pyenv init -)"
    export PIPENV_VENV_IN_PROJECT=1
    export PIPENV_SKIP_LOCK=1
fi


# direnv 読み込み
# export EDITOR=vim  (意味がなさそうなのでコメントアウト 問題なければ削除)
eval "$(direnv hook zsh)"

# iTerm2 shell_integration 読み込み (https://www.iterm2.com/documentation-shell-integration.html)
if [ -e "$HOME/.iterm2_shell_integration.zsh" ]; then
    source "$HOME/.iterm2_shell_integration.zsh"
fi

# cargo 読み込み
source $HOME/.cargo/env

# 文字コード指定
# export LANG="ja_JP.UTF-8" (もともとされてたのでコメントアウト 問題なければ削除)


# alias
alias tree="tree -N"  # 日本語を文字化けせずに表示するため
alias gitlog="git log --oneline --decorate --graph --branches --tags --remotes"
alias lzd='lazydocker'  # 短縮

# alias tb="tensorboard --logdir result --samples_per_plugin images=40"
# alias brew="env PATH=${PATH//$(pyenv root)\/shims:/} brew"

# ls を色付きに
if [ $(uname) = "Darwin" ]; then
    alias ls="ls -G"
elif [ $(uname) = 'Linux' ]; then
    alias open='xdg-open'
    alias ls="ls --color=auto"
fi

# rm をゴミ箱へ移動させるコマンドへ変更
if (( $+commands[trash-put] )); then
    alias rm=trash-put
fi

# shellからGoogle検索しそのページをブラウザで開くような関数
google(){
    echo $*
    local url="https://www.google.co.jp/search?q=${*// /+}"  # ${変数名//置換前文字列/置換後文字列} で置換

    if (( $+commands[xdg-open] )); then
        xdg-open $url
    else
        open $url
    fi
}


# zmodload が読み込まれている場合、計測結果を表示する
if (which zprof > /dev/null) ;then
  zprof | less
fi
