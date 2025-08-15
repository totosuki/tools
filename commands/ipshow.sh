#!/bin/sh

interface="en0"

print_help() {
    echo "ipshow - 指定したネットワークインターフェースの情報を表示します"
    echo
    echo "使用方法:"
    echo "  ipshow [<インターフェース名>]"
    echo
    echo "引数:"
    echo "  [インターフェース名]  表示したいネットワークインターフェース名を指定します。"
    echo "                       何も指定しない場合は en0 が使用されます。"
    echo
    echo "オプション:"
    echo "  -h, --help          このヘルプメッセージを表示します。"
    echo
    echo "使用例:"
    echo "  ipshow              # en0 インターフェースの情報を表示"
    echo "  ipshow en1          # en1 インターフェースの情報を表示"
    echo "  ipshow wlan0        # wlan0 インターフェースの情報を表示"
}

# 引数処理
while [ $# -gt 0 ]; do
    case "$1" in
        -h|--help)
            print_help
            exit 0
            ;;
        -*)
            echo "不明なオプション: $1"
            echo "使用可能なオプションを確認するには 'ipshow --help' を実行してください。"
            exit 1
            ;;
        *)
            interface="$1"
            ;;
    esac
    shift
done

# ifconfigコマンドの存在確認
if ! command -v ifconfig > /dev/null 2>&1; then
    echo "ifconfig コマンドが見つかりません。"
    echo "このスクリプトを実行するには ifconfig が必要です。"
    exit 1
fi

# インターフェースの存在確認
if ! ifconfig "$interface" > /dev/null 2>&1; then
    echo "インターフェース '$interface' が見つかりません。"
    echo "利用可能なインターフェースを確認するには 'ifconfig -l' を実行してください。"
    exit 1
fi

# 指定されたインターフェースから次のインターフェースまでの情報を抽出
ifconfig | awk -v target="$interface" '
BEGIN { found = 0; output = 0 }
/^[a-zA-Z0-9]+:/ {
    if (found && output) {
        exit
    }
    if ($1 == target ":") {
        found = 1
        output = 1
    } else if (found) {
        output = 0
    }
}
output { print }
'