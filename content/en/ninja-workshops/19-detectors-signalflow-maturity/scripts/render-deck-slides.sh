#!/usr/bin/env bash
# Regenerate PNGs for each slide of Detectors-signalflow-Maturity-Story.pptx.
# Requires Docker. Output: ../images/slides/slide-01.png … slide-NN.png

set -euo pipefail
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
PPTX="$ROOT/Detectors-signalflow-Maturity-Story.pptx"
OUT="$ROOT/images/slides"
TMP="$ROOT/images/.tmp-render"

if [[ ! -f "$PPTX" ]]; then
  echo "Missing PPTX: $PPTX" >&2
  exit 1
fi

mkdir -p "$OUT" "$TMP"
rm -f "$TMP"/*.pdf "$OUT"/slide-*.png

docker run --rm \
  -v "$ROOT:/data" \
  ubuntu:22.04 \
  bash -c "
    export DEBIAN_FRONTEND=noninteractive
    apt-get update -qq
    apt-get install -y -qq libreoffice-impress poppler-utils >/dev/null
    libreoffice --headless --convert-to pdf --outdir /data/images/.tmp-render /data/Detectors-signalflow-Maturity-Story.pptx
    pdftoppm -png -r 150 /data/images/.tmp-render/Detectors-signalflow-Maturity-Story.pdf /data/images/slides/slide
    rm -f /data/images/.tmp-render/*.pdf
  "

echo "Wrote PNGs under: $OUT"
ls -la "$OUT"
