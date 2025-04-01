#!/bin/sh

config_file_path="$HOME/tools/config/glog-default-length.txt"

if [ ! -e "$config_file_path" ] ; then
  echo 5 > "$config_file_path"
fi

val=$(<"$config_file_path")
desc_mode=false

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