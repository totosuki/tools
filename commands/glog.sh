#!/bin/sh
if [ -n "$1" ] ; then
  git log --graph -$1 --pretty="作成日: %Cblue %ci%Creset%Creset 作成者: %Cblue%an%Creset %Cred%d%Creset%n%Cgreen%t%Creset %m%m %s%n"
else
  echo "第一引数に数値を入力してください。"
fi