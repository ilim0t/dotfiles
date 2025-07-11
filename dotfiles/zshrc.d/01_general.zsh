# 環境変数の設定
path=(
    /opt/homebrew/bin(N-/)  # M1 Homebrew
    /opt/homebrew/sbin(N-/)  # M1 Homebrew
    /snap/bin(N-/)  # snap run
    $HOME/.pyenv/bin(N-/)  # pyenv installer より
    /usr/local/sbin(N-/)  # brew doctor (M1 macOS) より
    $path
)

# TODO: 理由の記載
export EDITOR=vim

# TODO: 理由の記載
# export LANG="ja_JP.UTF-8"  # (必要性の検証, 問題なければ削除)

# gitのgpg署名が失敗するため
export GPG_TTY=$TTY

# Linuxbrew
if [ -d "/home/linuxbrew/.linuxbrew" ]; then # root install
    eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)
elif [ -d "$HOME/.linuxbrew" ]; then  # non-root install
    eval $($HOME/.linuxbrew/bin/brew shellenv)
fi
