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
        echo -e "\033[33mCache does not exist. Do you want to create it now? (y/n)\033[0m"

        # y/n 入力
        echo -n "Enter your choice : "
        read -r choice # zsh では p オプションが使えないっぽい
        case "$choice" in
            [Yy])
                update_cache
                ;;
            [Nn])
                echo "Skipping cache creation. Exiting..."
                return 0
                ;;
            *)
                echo -e "\033[31mInvalid input. Exiting...\033[0m"
                return 1
                ;;
        esac
    fi

    target=$(cat "$JP_CACHE_FILE" | fzf-tmux -p 2>/dev/null || fzf)

    if test -n "$target"; then
        cd "$target" || { echo "Failed to change directory to $target"; exit 1; }
        echo "Jump to $target"
    else
        echo "No directory selected."
    fi
}

function show_help() {
    echo "Usage: jp [OPTIONS]"
    echo ""
    echo "Options:"
    echo "    -u, --update    Update the cache file."
    echo "    -h, --help      Show this help message."
    echo ""
    echo "Description:"
    echo '    "jp" is a utility to quickly navigate to frequently used directories.'
    echo '    Use 'fzf' to select a directory from a cached list.'
}

case "$1" in
    -u|--update)
        update_cache
        ;;
    -h|--help)
        show_help
        ;;
    "")
        search
        ;;
    *)
        echo -e "\033[31mInvalid option: $1\033[0m\n"
        show_help
        return 1
        ;;
esac
