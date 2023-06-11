# zplugの読み込み
if (( $+commands[brew] )) && [ -d "$(brew --prefix)/opt/zplug" ]; then
    source $(brew --prefix zplug)/init.zsh
else
    source $HOME/.zplug/init.zsh
fi

# zplug plugins
zplug 'zplug/zplug', hook-build:'zplug --self-manage'
zplug "zsh-users/zsh-autosuggestions"                               # 実行したことがあるコマンドの続きを薄く表示 右キーで補完
zplug "zsh-users/zsh-completions"                                   # 補完される辞書の追加
zplug "zsh-users/zsh-history-substring-search"                      # 途中まで打ったコマンドの続きを履歴から検索 (^P, ^N に設定した)
zplug "zsh-users/zsh-syntax-highlighting", defer:2                  # https://github.com/zsh-users/zsh-syntax-highlighting
zplug "b4b4r07/enhancd", use:init.sh                                # cdコマンドでインタラクティブにあいまい検索  fzy等のinstallが必要
zplug "mrowa44/emojify", as:command, rename-to:emojify, lazy:true   # :tada: 等を絵文字にデコードするコマンドの追加
zplug "stedolan/jq", from:gh-r, as:command, rename-to:jq, lazy:true # emojifyの依存
zplug "b4b4r07/emoji-cli", on:"stedolan/jq", defer:2                # 絵文字を入力する機能の追加
# zplug "plugins/docker-compose", from:oh-my-zsh, lazy:true
# zplug "plugins/cargo", from:oh-my-zsh, lazy:true
# zplug "plugins/docker", from:oh-my-zsh, lazy:true
zplug "plugins/extract", from:oh-my-zsh, lazy:true
zplug "plugins/gitignore", from:oh-my-zsh, lazy:true
zplug "lib/clipboard", from:oh-my-zsh, lazy:true
zplug "lib/key-bindings", from:oh-my-zsh, lazy:true

# テスト(お試し)段階の plugin
# zplug "modules/utility", from:prezto, lazy:true
# ~~, lazy:true

# Install plugins if there are plugins that have not been installed
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi


# Then, source plugins and add commands to $PATH
zplug load