#!/bin/bash
set +o noclobber

VERSION="0.28.1"

if [ ! -f "xterm-kitty" ] ; then
  echo "Checking for new release..."
  wget https://sw.kovidgoyal.net/kitty/changelog/ -O kitty-changelog.html 2>/dev/null
  CODE=$?
  LINES=$(grep "<a class=\"reference internal\" href=\"#id1\">$VERSION" kitty-changelog.html | wc -l)
  rm xterm-kitty.new -rf
  if [ $CODE -ne 0 ] ; then
    echo "Download failed: [$CODE]"
    exit $CODE
  elif [ $LINES -eq 1 ] ; then
    echo "No new KiTTY release detected"
    exit 0
  fi
fi

echo "Downloading xterm-kitty..."
rm xterm-kitty.new -rf
wget https://github.com/kovidgoyal/kitty/raw/master/terminfo/x/xterm-kitty -O xterm-kitty.new 2>/dev/null
CODE=$?
if [ $CODE -ne 0 ] ; then
  rm xterm-kitty.new -rf
  echo "Download failed: [$CODE]"
  exit $CODE
fi

diff xterm-kitty xterm-kitty.new >/dev/null 2>/dev/null
CODE=$?
if [ -f "xterm-kitty.new" -a ! -f "xterm-kitty" ] ; then
  mv xterm-kitty.new xterm-kitty
  echo "File xterm-kitty created!"
  exit 0
elif [ $CODE -eq 0 ] ; then
  rm xterm-kitty.new -rf
  echo "No updates available"
  exit 0
elif [ $CODE -ne 1 ] ; then
  rm xterm-kitty.new -rf
  echo "Error comparing files: [$code]"
  exit $CODE
else 
  mv xterm-kitty.new xterm-kitty
  echo "File xterm-kitty updated!"
fi
