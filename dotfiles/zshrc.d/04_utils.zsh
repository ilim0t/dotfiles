# shellからGoogle検索しそのページをブラウザで開くような関数
google() {
    local URL="https://www.google.co.jp/search?q=${*// /+}" # ${変数名//置換前文字列/置換後文字列} で置換, *: すべての引数

    if (( $+commands[xdg-open] )); then
        xdg-open $URL
    else
        open $URL
    fi
}