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

# ビープ音削除
setopt no_beep

# 曖昧な補完の際のビープ音削除
setopt nolistbeep

# Ctrl-Dでのshell終了を無効に
setopt ignore_eof

# "#" 以降をコメントとして扱う
setopt interactive_comments

# 同時に起動したshell間で履歴を共有する
setopt share_history

# コマンドの開始時のタイムスタンプ(エポックからの秒数)と実行時間(秒単位)をヒストリに含める
setopt extended_history

# リダイレクト時(command > path)に既にファイルがある場合上書きできないようにする (やりたいときは >! を使う)
setopt noclobber

# zstyle

# 補完において
zstyle ':completion:*' matcher-list 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}'  # 大文字小文字の区別をしない
zstyle ':completion:*:default' menu select=2  # 補完候補を矢印キーで移動できるように
zstyle ':completion:*' use-cache true  # apt-getとかdpkgコマンドをキャッシュを使って速くする

# 補完のファイル, フォルダも ls -G と同じく色がつくように
# export LS_COLORS='di=34:ln=35:so=32:pi=33:ex=31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}

# 何も入力してない際のTABの無効化
zstyle ':completion:*' insert-tab false

# zsh-users/zsh-autosuggestions の色
# ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=8'

# Keyboard shotcut settings
bindkey "^A" vi-beginning-of-line
bindkey "^E" vi-end-of-line
export EMOJI_CLI_KEYBIND="^x"

if zplug check "zsh-users/zsh-history-substring-search"; then
    bindkey '^P' history-substring-search-up
    bindkey '^N' history-substring-search-down
fi

export HISTFILE="$HOME/.zsh_history"
export HISTSIZE=1000
export SAVEHIST=100000


# Prompt setting
# 参照: http://zsh.sourceforge.net/Doc/Release/Prompt-Expansion.html

# %F: 文字色
# %K: 背景色
# %f, %k: それぞれの色のリセット

# vcsの表示設定
zstyle ':vcs_info:git:*' check-for-changes true  # localの変更を検知する
zstyle ':vcs_info:git:*' stagedstr "!"  # stageされているがcommitされていないファイルが有ったときの表示 (%cに展開される)
zstyle ':vcs_info:git:*' unstagedstr "+"  # stageされていないファイルが有ったときの表示 (%uに展開される)
zstyle ':vcs_info:*' formats "%c%u%b"  # $vcs_info_msg_0_ で実際に表示されるformat %b: branch名
zstyle ':vcs_info:*' actionformats "%b|%a"  # rebaseやmergeなど特殊状況下でformatsの代わりに表示される

# %~: カレントディレクトリ(フルパス, home以下省略)
DIR_PROMPT="%K{green}%F{16} %~ %k%F{green}"
BRANCH_PROMPT="%K{blue}%F{16} "'${vcs_info_msg_0_}'" %k%F{blue}"
# %(A,B,C): if A then B else C
# ?: 直前コマンドの返り値
# !: rootユーザーかどうか
MARK_PROMPT="%K{black}%(?,%F{white},%F{red}) %(!,#,$) %k%F{black}"
END_PROMPT="%f"

if [ ${SSH_CONNECTION} ]; then
    export RPROMPT="%F{red}%K{red}%F{white} ${$(hostname)//.local/} "  # ${変数名//置換前文字列/置換後文字列} で置換
fi

export PROMPT="${DIR_PROMPT}"'${BRANCH_PROMPT}'"${MARK_PROMPT}${END_PROMPT}"

# precmd はprompt表示毎に実行される関数
# 他に用いないので add-zsh-hook を使うのではなく直接定義する
precmd() {
    if git rev-parse 2> /dev/null; then
        vcs_info
        BRANCH_PROMPT="%K{blue}%F{16} ${vcs_info_msg_0_} %k%F{blue}"
    else
        BRANCH_PROMPT=""
    fi
}
