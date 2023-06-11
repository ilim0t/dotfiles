# Created by ilim for 5.6.2

# zsh起動時の速度計測用 (不要なら以下1行をコメントアウト)
# zmodload zsh/zprof && zprof

# .zshrc のキャッシュを生成
# TODO: ディレクトリに対応させる
if [ ! -e $HOME/.zshrc.zwc ] || [ $HOME/.zshrc -nt $HOME/.zshrc.zwc ]; then
    zcompile $HOME/.zshrc
fi

for conf in $(dirname $0)/zshrc.d/*.zsh; do
    source "${conf}"
    # もし、すべてを結合したいファイルがほしいなら cat zshrc.d/*.zsh > all_conf.zsh を実行
done
# unset conf # TODO: いらなくないか?

# zmodload が読み込まれている場合、計測結果を表示する
if (which zprof >& /dev/null); then
    zprof | less
fi
