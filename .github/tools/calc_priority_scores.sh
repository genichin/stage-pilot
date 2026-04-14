#!/usr/bin/env bash
set -euo pipefail

if [[ $# -lt 1 ]]; then
  echo "Usage: $0 <input_csv> [output_csv]"
  exit 1
fi

infile="$1"
outfile="${2:-}"

tmp_scored="$(mktemp)"
tmp_sorted="$(mktemp)"
trap 'rm -f "$tmp_scored" "$tmp_sorted"' EXIT

awk -F',' 'BEGIN { OFS="," }
NR==1 {
  print "item_id","work_item","method","wsjf_score","rice_score","selected_score","notes"
  next
}
{
  item=$1
  work=$2
  bv=$3+0
  tc=$4+0
  rroe=$5+0
  js=$6+0
  reach=$7+0
  impact=$8+0
  conf=$9+0
  effort=$10+0
  method=toupper($11)
  notes=$12

  wsjf=(js==0)?0:((bv+tc+rroe)/js)
  rice=(effort==0)?0:((reach*impact*conf)/effort)
  selected=(method=="RICE")?rice:wsjf

  printf "%s,%s,%s,%.4f,%.4f,%.4f,%s\n", item, work, method, wsjf, rice, selected, notes
}
' "$infile" > "$tmp_scored"

{
  head -n 1 "$tmp_scored"
  tail -n +2 "$tmp_scored" | sort -t',' -k6,6gr
} > "$tmp_sorted"

awk -F',' 'BEGIN { OFS="," }
NR==1 {
  print $0, "priority"
  next
}
{
  print $0, NR-1
}
' "$tmp_sorted" > "${outfile:-/dev/stdout}"
