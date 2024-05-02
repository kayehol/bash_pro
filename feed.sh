#!/bin/bash

feed() {
  lynx -source "$1" | grep '<title>' | tr -d \\t |
    sed 's/ *<[^>]*>//g; s/&quot;/"/g; 1d'
}
