#!/bin/bash

RED='\033[0;31m'
NC='\033[0m' # No Color

repo=$(basename $(git remote get-url origin) .git)

checkIfKnoxRepo()
{
	git remote -v | grep -i knox >/dev/null
	[[ $? -eq 0 ]] && return 0
	targetRepos=("backend" "KubeArmor")
	[[ " ${targetRepos[@]} " =~ " ${repo} " ]] && return 0
	return 1
}

checkIfKnoxRepo
if [ $? -ne 0 ]; then
	exit 0
fi

