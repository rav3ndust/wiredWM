#!/usr/bin/env bash
# nslock
#   - by rav3ndust (xvoidsx)
# ( like i3lock-fancy, but for wayland )
# ( written for naviOS - hack it how you want! )
# XXX requires: grim, imagemagick (magick), swaylock, fonts-noto, wlr-randr, jq
#################################################################################
set -euo pipefail
PINK="#ff10f0"
GREEN="#39ff14"
CYAN="#00ffff"
RED="#ff3131"
WHITE="#ffffff"
quotes=(
  "Let's all love Lain."
  "Present day. Present time."
  "If you aren't remembered, then you never existed."
  "What isn't remembered never happened. Memory is merely a record. You need to re-write that record."
  "No matter where you go, everyone's connected."
  "When you're connected, you're never alone."
  "Existence and will. The rest is mere data."
  "God is here."
)
QUOTE="${quotes[$((RANDOM % ${#quotes[@]}))]}"
QUOTE_WRAPPED="$(printf '%s' "$QUOTE" | fold -s -w 46)"
tmp="$(mktemp -d /tmp/nslock.XXXXXX)"
trap 'rm -rf "$tmp"' EXIT
# cap working width for huge captures (4k etc). empty = native res.
MAXW=""
render() {
	local src="$1" dst="$2"
	if [ -n "$MAXW" ]; then
		CAP=(-resize "${MAXW}>")
	else
		CAP=()
	fi
	magick "$src" "${CAP[@]}" \
	  -evaluate multiply 0.75 \
	  -scale 10% -blur 0x8 -scale 1000% \
	  -font "Noto-Sans-Bold" -pointsize 120 -fill "$GREEN" \
	  -gravity North -annotate +0+60 "navi" \
	  -font "Noto-Sans-Bold" -pointsize 18 -fill "$GREEN" \
	  -gravity North -annotate +0+250 "type your password to return:" \
	  -scale 25% -blur 0x8 -scale 400% \
	  -font "Noto-Sans-Bold" -pointsize 120 -fill "$PINK" \
	  -gravity North -annotate +0+60 "navi" \
	  -font "Noto-Sans-Regular" -pointsize 20 -fill "$CYAN" \
	  -gravity North -annotate +0+200 "$(date +'%A %d %B %Y')" \
	  -font "Noto-Sans-Bold" -pointsize 18 -fill "$GREEN" \
	  -gravity North -annotate +0+250 "type your password to return:" \
	  -font "Noto-Sans-Regular" -pointsize 22 -fill "rgba(255,255,255,0.65)" \
	  -gravity South -annotate +0+170 "$QUOTE_WRAPPED" \
	  -font "Noto-Sans-Italic" -pointsize 12 -fill "rgba(255,16,240,0.60)" \
	  -gravity South -annotate +0+132 "- serial experiments lain" \
	  -strip \
	  "$dst"
}
IMAGES=()
if command -v wlr-randr >/dev/null 2>&1 && command -v jq >/dev/null 2>&1; then
    readarray -t OUTPUTS < <(wlr-randr --json | jq -r '.[] | select(.enabled == true) | .name' 2>/dev/null || true)
fi
if [ "${#OUTPUTS[@]}" -gt 0 ]; then
	for out in "${OUTPUTS[@]}"; do
		grim -s 1 -t ppm -o "$out" "$tmp/$out.ppm" \
		  && render "$tmp/$out.ppm" "$tmp/$out.png" \
		  && IMAGES+=("-i" "$out:$tmp/$out.png") \
		  || { swaylock --color 000000; exit 1; }
	done
else
	grim -s 1 -t ppm "$tmp/screen.ppm" \
	  && render "$tmp/screen.ppm" "$tmp/screen.png" \
	  && IMAGES=("-i" "$tmp/screen.png") \
	  || { swaylock --color 000000; exit 1; }
fi
swaylock "${IMAGES[@]}" \
  	--scaling stretch \
  	--indicator-idle-visible \
  	--indicator-radius 75 \
  	--indicator-thickness 10 \
  	--font "Noto Sans" \
  	--font-size 22 \
  	--ring-color "$PINK" \
  	--ring-ver-color "$CYAN" \
  	--ring-wrong-color "$RED" \
  	--ring-clear-color "$GREEN" \
  	--ring-caps-lock-color "$PINK" \
  	--inside-color "#00000040" \
  	--inside-ver-color "#00ffff22" \
  	--inside-wrong-color "#ff313122" \
  	--inside-clear-color "#39ff1422" \
  	--line-color "#00000000" \
  	--separator-color "#00000000" \
  	--text-color "$WHITE" \
  	--text-ver-color "$CYAN" \
  	--text-wrong-color "$RED" \
  	--text-clear-color "$GREEN" \
  	--key-hl-color "$CYAN" \
  	--bs-hl-color "$RED" \
  	--caps-lock-key-hl-color "$PINK"
# - - - - - |
