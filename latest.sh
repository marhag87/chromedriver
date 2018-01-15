#!/bin/bash
# Script for checking for new versions of chromedriver
# Written by Martin Hagström 2018-01-15

set -e

update=false

function getlatestversion() {
  curl -s https://chromedriver.storage.googleapis.com/LATEST_RELEASE
}

function getcurrentversion() {
  awk '/^Version/ { print $2 }' SPECS/chromedriver.spec
}

function update() {
  datestring=$(date "+%a %b %d %Y Martin Hagstrom <marhag87@gmail.com> $1-1")
  sed -i "s/\(^Version:\s*\)[[:digit:].]*/\1${1}/"   SPECS/chromedriver.spec
  sed -i "s/\(^Release:\s*\)[[:digit:].]*/\11/"      SPECS/chromedriver.spec
  sed -i "s/\%changelog/\%changelog\n\* ${datestring}\n- Update to $1/" SPECS/chromedriver.spec
}

function compareversions() {
  latestversion=$(getlatestversion)
  currentversion=$(getcurrentversion)
  if [[ $currentversion != $latestversion ]]; then
    if [[ $update == true ]]; then
      update $latestversion
    else
      echo "chromedriver not up to date, latest version: ${latestversion}"
    fi
  fi
}

while getopts ":u" opt; do
  case $opt in
    u)
      update=true
      shift
      ;;
    \?)
      echo "Invalid option: -$OPTARG" >&2
      ;;
  esac
done

compareversions
