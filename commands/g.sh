#!/bin/bash
#
# g [path …] <message>
#   引数が 1 個   : message とみなす（add 対象は git add -A）
#   引数が 2 個以上: 最後の引数を message、それ以外を add 対象 path とみなす
#   commit 前に git status -s と commit message を表示して確認を求める
#   push 後、glog が入っていれば最新 1 件を表示（※要 glog -1 対応版）

set -euo pipefail

# prepare
message="${@: -1}"
if [ $# -eq 1 ]; then
    git add -A
    paths=()
    else
    paths=("${@:1:$# -1}")
fi

# log
echo "Running git command..."
if [ $# -eq 1 ]; then
    echo "$ git add -A"
else
    echo "$ git add $paths"
fi
echo "$ git status -s"

# commit
echo -en "Do you want to commit? (y/n) "
read -r answer
if [ "$answer" = "y" ]; then
    git commit -m "$message"
else
    echo "Commit cancelled."
    return 0
fi

# log
echo -e "$ git commit -m \"$message\""

# push
echo -en "\nDo you want to push? (y/n) "
read -r answer
if [ "$answer" = "y" ]; then
    git push
else
    echo "Push cancelled."
    return 0
fi