#!/usr/bin/env bash

# ===== CRYPTOGRAPHER BANNER =====
print_banner() {
    local -a _cb_art=(
        '_________                        __                                    .__'
        '\_   ___ \_______ ___.__._______/  |_  ____   ________________  ______ |  |__ ___.__./'
        '/    \/\_  __ <   |  |\____ \   __\/  _ \ / ___\_  __ \__  \ \____ \|  |  <   |  |'
        '\     \____|  | \/\___  ||  |_> >  | (  <_> ) /_/  >  | \// __ \|  |_> >   Y  \___  |'
        ' \______  /|__|   / ____||   __/|__|  \____/\___  /|__|  (____  /   __/|___|  / ____|'
        '        \/        \/     |__|                /_____/          \/|__|        \/\/'
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
    _cb_w=$((_cb_w + 2))

    for ((_cb_i = 0; _cb_i < _cb_w + 2; _cb_i++)); do
        _cb_bar+="$_cb_h"
    done
    for ((_cb_i = 0; _cb_i < 50; _cb_i++)); do
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
        printf '%s%s%s %-*s%s %s%s%s\n' \
            "$_cb_frm" "$_cb_v" "$_cb_c" "$_cb_w" "${_cb_art[$_cb_i]}" \
            "$_cb_rst" "$_cb_frm" "$_cb_v" "$_cb_rst"
    done

    printf '%s%s %*s %s%s\n' "$_cb_frm" "$_cb_v" "$_cb_w" '' "$_cb_v" "$_cb_rst"
    printf '%s%s %-*s %s%s\n' "$_cb_frm" "$_cb_v" 50 "$_cb_rule" "$_cb_v" "$_cb_rst"
    printf '%s%s %s%s%s%-*s%s %s%s\n' \
        "$_cb_frm" "$_cb_v" "$_cb_lbl" '[ TOOL ]     : ' "$_cb_val" "$((_cb_w - 15))" "$_cb_tool" \
        "$_cb_rst" "$_cb_v" "$_cb_rst"
    printf '%s%s %s%s%s%-*s%s %s%s\n' \
        "$_cb_frm" "$_cb_v" "$_cb_lbl" '[ ENGINE ]   : ' "$_cb_val" "$((_cb_w - 15))" 'SCRIPTMONKS CRYPTOGRAPHY ENGINE' \
        "$_cb_rst" "$_cb_v" "$_cb_rst"
    printf '%s%s %s%s%s%-*s%s %s%s\n' \
        "$_cb_frm" "$_cb_v" "$_cb_lbl" '[ VERSION ]  : ' "$_cb_val" "$((_cb_w - 15))" "$_cb_ver" \
        "$_cb_rst" "$_cb_v" "$_cb_rst"
    printf '%s%s %s%s%s%-*s%s %s%s\n' \
        "$_cb_frm" "$_cb_v" "$_cb_lbl" '[ SECURITY ] : ' "$_cb_ok" "$((_cb_w - 15))" 'ENCRYPTED / ACTIVE SESSION' \
        "$_cb_rst" "$_cb_v" "$_cb_rst"
    printf '%s%s %-*s %s%s\n' "$_cb_frm" "$_cb_v" 50 "$_cb_rule" "$_cb_v" "$_cb_rst"
    printf '%s%s %*s %s%s\n' "$_cb_frm" "$_cb_v" "$_cb_w" '' "$_cb_v" "$_cb_rst"
    printf '%s%s %-*s %s%s\n' "$_cb_frm" "$_cb_v" 50 "$_cb_rule" "$_cb_v" "$_cb_rst"
    printf '%s%s %s%-*s%s %s%s\n' \
        "$_cb_frm" "$_cb_v" "$_cb_diml" "$_cb_w" '[ DISCLAIMER ]' \
        "$_cb_rst" "$_cb_v" "$_cb_rst"
    printf '%s%s %s%-*s%s %s%s\n' \
        "$_cb_frm" "$_cb_v" "$_cb_dim" "$_cb_w" 'This tool is developed strictly for educational and instructional' \
        "$_cb_rst" "$_cb_v" "$_cb_rst"
    printf '%s%s %s%-*s%s %s%s\n' \
        "$_cb_frm" "$_cb_v" "$_cb_dim" "$_cb_w" 'purposes. While modern security relies on mathematical foundations,' \
        "$_cb_rst" "$_cb_v" "$_cb_rst"
    printf '%s%s %s%-*s%s %s%s\n' \
        "$_cb_frm" "$_cb_v" "$_cb_dim" "$_cb_w" 'this repository was designated "Cryptography" primarily for its' \
        "$_cb_rst" "$_cb_v" "$_cb_rst"
    printf '%s%s %s%-*s%s %s%s\n' \
        "$_cb_frm" "$_cb_v" "$_cb_dim" "$_cb_w" 'compelling aesthetic appeal.' \
        "$_cb_rst" "$_cb_v" "$_cb_rst"
    printf '%s%s %-*s %s%s\n' "$_cb_frm" "$_cb_v" 50 "$_cb_rule" "$_cb_v" "$_cb_rst"
    printf '%s%s%s%s%s\n' "$_cb_frm" "$_cb_bl" "$_cb_bar" "$_cb_br" "$_cb_rst"

    printf '\n'
    printf '%s%s%s\n' "$_cb_frm" "$_cb_rule" "$_cb_rst"
    printf '\n'
}

print_banner

H="\033[1;31m"
S="\033[1;32m"
E="\033[0m"

echo -e "${H}Analyzer${E}"

read -p "Input text: " INPUT

menu () {
echo -e "
${S}1${E}) Frequency Analysis
${S}2${E}) Brute-force Caesar
${S}3${E}) Character Count
"
}

menu
read -p "Choice: " C

case $C in

1)
echo "$INPUT" | tr -d ' ' | fold -w1 | sort | uniq -c | sort -nr
;;

2)
for i in {0..25}; do
echo -n "Shift $i: "
echo "$INPUT" | tr 'A-Za-z' \
$(python3 - <<EOF
import string
s=$i
a=string.ascii_lowercase
b=a[s:]+a[:s]
A=string.ascii_uppercase
B=A[s:]+A[:s]
print(a+A+" "+b+B)
EOF
)
done
;;

3)
echo "$INPUT" | wc -m
;;

*) echo "Invalid"
esac
