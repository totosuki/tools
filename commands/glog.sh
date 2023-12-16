#!/bin/sh

config_file_path="$HOME/tools/config/glog-default-length.txt"

if [ ! -e "$config_file_path" ] ; then
  echo 5 > "$config_file_path"
fi

val=$(<"$config_file_path")

if [ -n "$1" ] ; then
  case $1 in
    -s | --set)
      if [ -n "$2" ] ; then
        echo $2 > $config_file_path
        echo "git log で表示する文字の長さの初期値を${2}に変更しました"
      else
        echo "第二引数に数値が入力されていません。"
      fi
      ;;
    *)
      git log --graph -$1 --pretty="作成日: %Cblue %ci%Creset%Creset 作成者: %Cblue%an%Creset %Cred%d%Creset%n%Cgreen%t%Creset %m%m %s%n"
      ;;
  esac
else
  git log --graph "-$val" --pretty="作成日: %Cblue %ci%Creset%Creset 作成者: %Cblue%an%Creset %Cred%d%Creset%n%Cgreen%t%Creset %m%m %s%n"
fi