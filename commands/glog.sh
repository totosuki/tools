#!/bin/sh

config_file_path="$HOME/tools/config/glog-default-length.txt"

if [ ! -e "$config_file_path" ] ; then
  echo 5 > "$config_file_path"
fi

val=$(<"$config_file_path")
desc_mode=false

print_help() {
  echo "glog - a simple wrapper for frequently-used git log options"
  echo
  echo "Usage:"
  echo "  glog [<number-of-commits>] [-d|--desc]"
  echo "  glog -s|--set <number-of-commits>"
  echo
  echo "Options:"
  echo "  [number]         Temporarily override the default number of commits to show."
  echo "                   Defaults to the saved value (initial default: 5)."
  echo
  echo "  -d, --desc       Include the commit body (description) in the log output."
  echo
  echo "  -s, --set <num>  Set the default number of commits to show in future glog runs."
  echo "                   This value is stored at: $config_file_path"
  echo
  echo "  -h, --help       Show this help message."
  echo
  echo "Examples:"
  echo "  glog              # Show default number of commits"
  echo "  glog 10           # Show 10 commits"
  echo "  glog --desc       # Show default number of commits with body"
  echo "  glog 20 -d        # Show 20 commits with body"
  echo "  glog --set 15     # Change default to 15 commits"
}

# 引数処理
while [ $# -gt 0 ]; do
  case "$1" in
    -s|--set)
      if [ -n "$2" ]; then
        echo "$2" > "$config_file_path"
        echo "git log で表示するコミット数の初期値を ${2} に変更しました"
        exit 0
      else
        echo "第二引数に数値が入力されていません。"
        exit 1
      fi
      ;;
    -d|--desc)
      desc_mode=true
      ;;
    -h|--help)
      print_help
      exit 0
      ;;
    [0-9]*)
      val="$1"
      ;;
    -*)
      echo "不明なオプション: $1"
      exit 1
      ;;
  esac
  shift
done

# 出力
if $desc_mode; then
  git log --graph -$val --pretty="作成日: %Cblue %ci%Creset%Creset 作成者: %Cblue%an%Creset %Cred%d%Creset%n%Cgreen%t%Creset >> %s%n           %b%n"
else
  git log --graph -$val --pretty="作成日: %Cblue %ci%Creset%Creset 作成者: %Cblue%an%Creset %Cred%d%Creset%n%Cgreen%t%Creset >> %s%n"
fi