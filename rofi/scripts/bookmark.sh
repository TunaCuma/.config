#!/bin/bash
# UI states 'Shift+Return: new window', but expects ROFI_RETV == 11 to do so. which by default is 'Alt+1.'
# To match the stated UI, add these lines to your config file.
#
# configuration {
# ...
#    kb-custom-1:"Shift+Return";
#    kb-accept-alt:"Alt+1";   
# }
gen_bookmark() {
    if [ -z "$bookmarks_folder" ]; then
        bookmarks_folder=$(find ~/.mozilla/firefox/ -maxdepth 2 -type d | grep -E 'default.*release' | grep -v -E 'nightly$' | awk 'NR==1')
        if [ -z "$bookmarks_folder" ]; then
            echo "unable to detect firefox profile. please specify manually in source."
            exit 1
        fi
    fi

    csum_orig=$(sha1sum "${bookmarks_folder}"/places.sqlite | awk '{print $1}')
    csum_copy=$(sha1sum "${bookmarks_folder}"/places_copy.sqlite 2> /dev/null | awk '{print $1}')

    if [ "$csum_orig" != "$csum_copy" ]; then
        /usr/bin/cp -f "${bookmarks_folder}"/places.sqlite "${bookmarks_folder}"/places_copy.sqlite
    fi

    sqlite3 "${bookmarks_folder}"/places_copy.sqlite \
    "SELECT DISTINCT b.title || '|' || p.url 
     FROM moz_bookmarks b 
     JOIN moz_places p ON b.fk = p.id 
     WHERE b.type = 1 AND b.title IS NOT NULL AND b.title != ''" | while read -r line; do
        title=$(echo "$line" | cut -d'|' -f1)
        url=$(echo "$line" | cut -d'|' -f2)
        [ -n "$title" ] && [ -n "$url" ] && echo -en "${title}\0info\x1f${url}\x1ficon\x1fbookmarks\n"
    done
}

if [ -z "$@" ]; then
    gen_bookmark | sort -u
    echo -en "\0message\x1f<b>shift+enter</b>: new window  <b>enter</b>: new tab\n"
    echo -en "\0use-hot-keys\x1ftrue\n"
else 
    if [ "$ROFI_RETV" = 10 ]; then 
        firefox --new-window "${ROFI_INFO}" > /dev/null 2>&1 &
    else 
        firefox --new-tab "${ROFI_INFO}" > /dev/null 2>&1 &
    fi
fi
