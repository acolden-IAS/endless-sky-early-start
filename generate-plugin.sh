#!/bin/bash

set -eo pipefail

if [ ! -f "${0##*/}" ]; then
  echo 'ERROR: this must be run from the plugin root.' >&2
  exit 1
fi

starts_file="../endless-sky/data/starts.txt"
if [ ! -s "${starts_file}" ]; then
  echo 'Please enter the full path to Endless Sky on your system. Do not use a relative path. If you are on macOS, it may contain spaces. Example entry: /Users/andrew/Library/Application Support/ESLauncher2/instances/Main/Endless Sky.app/Contents/Resources'
  read -p 'Enter path: ' starts_dir
  if [ -s "${starts_dir}/data/starts.txt" ]; then
    starts_file="${starts_dir}/data/starts.txt"
  else
    echo 'ERROR: could not find data/starts.txt in your entered path.' >&2
    exit 1
  fi
fi

rm -rf data
mkdir data
grep ^start "${starts_file}" | \
  awk '{ print $0; printf "\tdate 16 11 2999\n\n"}' \
  > data/early-starts.txt
