#!/bin/sh

command -v pdfcrop >/dev/null 2>&1 || {
  echo >&2 "pdfcrop executable not found in PATH:"
  echo >&2 "${PATH}"
  exit 1
}

# Change all .svg .png and .jpeg to .pdf to import into latex
for f in logos/*.svg logos/*.png logos/*.jpeg; do
  [ -e "$f" ] || continue
  inkscape "$f" -o "${f%.*}.pdf"
done

LOGOS=(tum faculty)

for logo in ${LOGOS[@]}
do
  pdfcrop "logos/${logo}.pdf" "logos/${logo}.pdf"
done
