#!/usr/bin/env bash
thought=$(cat ~/Documents/github_repos/sahilrajput03/thoughts-principles.md | grep -v -e '^$' | shuf -n1)

notify-send " 💜" "$thought" -t 15000
