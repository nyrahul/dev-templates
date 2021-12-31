#!/bin/bash

ORANGE="\033[0;33m"
RED="\033[0;31m"
GREEN="\033[0;32m"
CYAN="\033[0;36m"
NC="\033[0m" # No Color

repo=$(basename $(git remote get-url origin) .git)

statusline()
{
	status=$1
	shift
	[[ $status == AOK ]] || [[ $status == "0" ]] &&
		{
			printf "[${GREEN}OK${NC}] $*\n"
			return
		}
	[[ $status == WARN ]] &&
		{
			printf "[${ORANGE}WARN${NC}] $*\n"
			return
		}
	[[ $status == WAIT ]] &&
		{
			printf "[${CYAN}..${NC}] $*\r"
			return
		}
	printf "[${RED}FAIL${NC}] $*\n"
	exit 1
}

checkGithubAuthStatus()
{
	[[ "$(which gh)" == "" ]] && statusline ERR "github cli-tool 'gh' not found in PATH. Download and Install from https://github.com/cli/cli/releases"
	str=`gh auth status 2>&1`
	[[ $? -ne 0 ]] && echo "$str" && statusline ERR "'gh auth status' does not show you are logged in. Use 'gh auth login'."
}

checkGithubAuthStatus
