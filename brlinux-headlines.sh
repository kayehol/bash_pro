#!/bin/bash

URL="https://br-linux.org"

lynx -dump -nolist "$URL" |
  grep '^[A-Z]' |
  sed '/^BR-Linux.org/ d'
