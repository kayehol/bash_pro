#!/bin/bash

URL="https://lobste.rs"

lynx -source "$URL" |
  grep 'u-url' lobsters.html |
  sed 's/<[^>]*>//g'
