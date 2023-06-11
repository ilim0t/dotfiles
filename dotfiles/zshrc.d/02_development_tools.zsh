###########################################
# プログラミング言語のバージョン, パッケージ管理
###########################################

# Python
if (( $+commands[pyenv] )); then
    eval "$(pyenv init --path)"
    eval "$(pyenv init -)"
    export PIPENV_VENV_IN_PROJECT=1
    export PIPENV_SKIP_LOCK=1
fi

# Rust
if [ -e "$HOME/.cargo" ]; then
    source $HOME/.cargo/env
fi

# Node.js
eval "$(nodenv init -)"

# Ruby
eval "$(rbenv init - zsh)"

###########################################
# その他
###########################################

if (( $+commands[direnv] )); then
    eval "$(direnv hook zsh)"
fi

# iTerm2 shell_integration 読み込み (https://www.iterm2.com/documentation-shell-integration.html)
if [ -e "$HOME/.iterm2_shell_integration.zsh" ]; then
    source "$HOME/.iterm2_shell_integration.zsh"
fi
