#!/usr/bin/env bash

print_banner() {
    local -a _cb_art=(
'_________                        __                                    .__            '
'\_   ___ \_______ ___.__._______/  |_  ____   ________________  ______ |  |__ ___.__.'
'/    \  \/\_  __ <   |  |\____ \   __\/  _ \ / ___\_  __ \__  \ \____ \|  |  <   |  |'
'\     \____|  | \/\___  ||  |_> >  | (  <_> ) /_/  >  | \// __ \|  |_> >   Y  \___  |'
' \______  /|__|   / ____||   __/|__|  \____/\___  /|__|  (____  /   __/|___|  / ____|'
'        \/        \/     |__|                /_____/          \/|__|        \/\/     '
    )
    local -a _cb_tc=( '0;255;255' '0;204;255' '0;153;255' '51;102;255' '102;51;255' '153;51;255' )
    local -a _cb_c8=( 51 45 39 63 99 135 )

    local _cb_w=0 _cb_i _cb_l _cb_c _cb_tool _cb_ver='v1.0.0'
    local _cb_bar='' _cb_rule='' _cb_h _cb_tl _cb_tr _cb_bl _cb_br _cb_v
    local _cb_tc_on=0 _cb_color=1
    local _cb_rst='' _cb_frm='' _cb_lbl='' _cb_val='' _cb_ok='' _cb_dim='' _cb_diml=''

    case "${COLORTERM:-}" in truecolor|24bit) _cb_tc_on=1 ;; esac
    [ -n "${NO_COLOR:-}" ] && _cb_color=0

    if [ "$_cb_color" = 1 ]; then
        _cb_rst=$'\033[0m'
        _cb_frm=$'\033[1;38;2;255;68;255m'
        _cb_lbl=$'\033[1;38;2;0;229;255m'
        _cb_val=$'\033[38;2;226;226;255m'
        _cb_ok=$'\033[1;38;2;57;255;136m'
        _cb_dim=$'\033[38;2;132;132;140m'
        _cb_diml=$'\033[1;38;2;150;175;178m'
    fi

    case "${LC_ALL:-${LC_CTYPE:-${LANG:-}}}" in
        *utf8*|*UTF8*|*utf-8*|*UTF-8*)
            _cb_tl='╔' _cb_tr='╗' _cb_bl='╚' _cb_br='╝'
            _cb_v='║' _cb_h='═' ;;
        *)
            _cb_tl='+' _cb_tr='+' _cb_bl='+' _cb_br='+'
            _cb_v='|' _cb_h='=' ;;
    esac

    _cb_tool="${BASH_SOURCE[0]##*/}"
    [ -n "$_cb_tool" ] || _cb_tool="${0##*/}"
    _cb_tool=$(printf '%s' "$_cb_tool" | tr '[:lower:]' '[:upper:]')

    for _cb_l in "${_cb_art[@]}"; do
        [ "${#_cb_l}" -gt "$_cb_w" ] && _cb_w=${#_cb_l}
    done

    [ "$_cb_w" -lt 70 ] && _cb_w=70

    for ((_cb_i = 0; _cb_i < _cb_w + 2; _cb_i++)); do
        _cb_bar+="$_cb_h"
        _cb_rule+='-'
    done

    if [ -t 1 ] && [ -z "${NO_BANNER_CLEAR:-}" ]; then
        command clear 2>/dev/null || printf '\033[H\033[2J\033[3J'
    fi

    printf '\n'
    printf '%s%s%s%s%s\n' "$_cb_frm" "$_cb_tl" "$_cb_bar" "$_cb_tr" "$_cb_rst"
    printf '%s%s %*s %s%s\n' "$_cb_frm" "$_cb_v" "$_cb_w" '' "$_cb_v" "$_cb_rst"

    for _cb_i in "${!_cb_art[@]}"; do
        if   [ "$_cb_color" = 0 ]; then _cb_c=''
        elif [ "$_cb_tc_on" = 1 ]; then _cb_c=$'\033[1;38;2;'"${_cb_tc[$_cb_i]}"$'m'
        else _cb_c=$'\033[1;38;5;'"${_cb_c8[$_cb_i]}"$'m'
        fi
        printf '%s%s %s%-*s%s %s%s\n' \
            "$_cb_frm" "$_cb_v" "$_cb_c" "$_cb_w" "${_cb_art[$_cb_i]}" \
            "$_cb_rst$_cb_frm" "$_cb_v" "$_cb_rst"
    done

    printf '%s%s %*s %s%s\n' "$_cb_frm" "$_cb_v" "$_cb_w" '' "$_cb_v" "$_cb_rst"
    printf '%s%s %s %s%s\n' "$_cb_frm" "$_cb_v" "$_cb_rule" "$_cb_v" "$_cb_rst"

    _print_line() {
        local lbl="$1" val="$2" val_color="$3"
        local plain_text="[ $lbl ] : $val"
        local pad=$(( _cb_w - ${#plain_text} ))
        printf '%s%s %s[ %s ] : %s%s%*s %s%s\n' \
            "$_cb_frm" "$_cb_v" "$_cb_lbl" "$lbl" "$val_color" "$val" \
            "$pad" '' "$_cb_rst$_cb_frm" "$_cb_v" "$_cb_rst"
    }

    _print_line "TOOL" "$_cb_tool" "$_cb_val"
    _print_line "ENGINE" "SCRIPTMONKS CRYPTOGRAPHY ENGINE" "$_cb_val"
    _print_line "VERSION" "$_cb_ver" "$_cb_val"
    _print_line "SECURITY" "ENCRYPTED / ACTIVE SESSION" "$_cb_ok"

    printf '%s%s %s %s%s\n' "$_cb_frm" "$_cb_v" "$_cb_rule" "$_cb_v" "$_cb_rst"

    _print_disc() {
        local text="$1" color="$2"
        local pad=$(( _cb_w - ${#text} ))
        printf '%s%s %s%s%*s %s%s\n' \
            "$_cb_frm" "$_cb_v" "$color" "$text" \
            "$pad" '' "$_cb_rst$_cb_frm" "$_cb_v" "$_cb_rst"
    }

    _print_disc "[ DISCLAIMER ]" "$_cb_diml"
    _print_disc "This tool is developed strictly for educational and instructional" "$_cb_dim"
    _print_disc "purposes. While modern security relies on mathematical foundations," "$_cb_dim"
    _print_disc "this repository was designated \"Cryptography\" primarily for its" "$_cb_dim"
    _print_disc "compelling aesthetic appeal." "$_cb_dim"

    printf '%s%s %s %s%s\n' "$_cb_frm" "$_cb_v" "$_cb_rule" "$_cb_v" "$_cb_rst"
    printf '%s%s%s%s%s\n' "$_cb_frm" "$_cb_bl" "$_cb_bar" "$_cb_br" "$_cb_rst"
    printf '\n'
}

print_banner

H="\033[1;34m"
S="\033[1;32m"
E="\033[0m"

echo -e "${H}Encryptor${E}"

menu () {
echo -e "
${S}1${E}) Encrypt (AES-256)
${S}2${E}) Decrypt (AES-256)
"
}

menu
read -p "Choice: " C
read -p "File: " FILE

case $C in
1)
openssl enc -aes-256-cbc -salt -in "$FILE" -out "$FILE.enc"
echo "Encrypted → $FILE.enc"
;;

2)
read -p "Output file: " OUT
openssl enc -d -aes-256-cbc -in "$FILE" -out "$OUT"
echo "Decrypted → $OUT"
;;

*) echo "Invalid"
esac
