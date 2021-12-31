#!/bin/bash

RED='\033[0;31m'
NC='\033[0m' # No Color

repo=$(basename $(git remote get-url origin) .git)

