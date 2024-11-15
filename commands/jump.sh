#!/bin/bash

JP_CACHE_FILE="$HOME/tools/config/jp_cache"

# キャッシュ更新
function update_cache() {
    # fd が使える場合
    if command -v fd > /dev/null; then
        echo 'Updating cache with "fd" command...'
        fd --type d . ~ > "$JP_CACHE_FILE"
    # fd が使えない場合
    else
        echo 'Updating cache with "find" command...'
        find ~ -type d 2> /dev/null > "$JP_CACHE_FILE"
    fi
    echo "Cache updated: $JP_CACHE_FILE"
}

function search() {
    # キャッシュが無い場合
    if ! test -f "$JP_CACHE_FILE"; then
        update_cache
    fi

    target=$(cat "$JP_CACHE_FILE" | fzf-tmux -p 2>/dev/null || fzf)

    if test -n "$target"; then
        cd "$target" || { echo "Failed to change directory to $target"; exit 1; }
        echo "Jump to $target"
    else
        echo "No directory selected."
    fi
}

case "$1" in
    # キャッシュの更新
    "update")
        update_cache
        ;;
    # 通常コマンド
    *)
        search
        ;;
esac
