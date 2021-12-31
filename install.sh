#!/bin/bash

LOCALBIN=$HOME/.local/bin

install_latest_templates()
{
	TMP=/tmp/dev-templates_$$
	export GIT_TEMPLATE_DIR=$HOME/.git/templates/hooks
	mkdir -p $GIT_TEMPLATE_DIR 2>/dev/null

	echo -en "Installing Templates..."
	[[ ! -d $TMP ]] && git clone --quiet --depth 1 https://github.com/nyrahul/dev-templates.git $TMP
	cd $TMP
	cp gh-templates/* $GIT_TEMPLATE_DIR
	cd - >/dev/null
	rm -rf $TMP
	echo done
}

chkbasic()
{
	[[ "$(which gh)" == "" ]] && echo "Download latest gh-cli tool from https://github.com/cli/cli/releases and save it in any PATH folders." && exit 1
	[[ ! -d ".git" ]] && echo "You need to execute this from the base dir of your repo." && exit 1
	git remote -v 2>&1 >/dev/null
	[[ $? -ne 0 ]] && echo "Execute this script from the base dir of your repo." && exit 1

	which git 2>&1 >/dev/null
	[[ $? -ne 0 ]] && echo "git cmd not found." && exit 1

	[[ $EUID -eq 0 ]] &&
		echo "Executing as root is not a good idea!" &&
		echo "RISKY: Are you sure(CTRL-C to break, ENTER to continue)?" &&
		dd bs=1 count=1 2>/dev/null # read does not work with sudo, hence using dd to wait for user input.

	[[ ! -d "$LOCALBIN" ]] &&
		echo "Couldnot find $LOCALBIN folder to install pre-requisites" && exit 1
		# if this folder is not present then the tools could be copied to any other location

	which gh 2>&1 >/dev/null
	[[ $? -ne 0 ]] && cp tools/gh $LOCALBIN
}

chkbasic
install_latest_templates
cp $GIT_TEMPLATE_DIR/* .git/hooks/
