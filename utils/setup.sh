#!/bin/sh
set -e
# Default settings
SHIVA=${SHIVA:-~/.shiva}
REPO=${REPO:-ZeraTron/Shiva42}
REMOTE=${REMOTE:-https://github.com/${REPO}.git}
BRANCH=${BRANCH:-master}
# Directories paths
UTILS=${UTILS:-utils}
TOOLS=${TOOLS:-tools}
ROUTERS=${ROUTERS:-routers}
TEMPLATES=${TEMPLATES:-templates}

command_exists() {
	command -v "$@" >/dev/null 2>&1
}

error() {
	echo ${RED}"Error: $@"${RESET} >&2
}

setup_color() {
	# Only use colors if connected to a terminal
	if [ -t 1 ]; then
		RED=$(printf '\033[31m')
		GREEN=$(printf '\033[32m')
		YELLOW=$(printf '\033[33m')
		BLUE=$(printf '\033[34m')
		BOLD=$(printf '\033[1m')
		RESET=$(printf '\033[m')
	else
		RED=""
		GREEN=""
		YELLOW=""
		BLUE=""
		BOLD=""
		RESET=""
	fi
}

install_all() {
	echo "${GREEN}Adding path to your .zshrc file...${RESET}"
	
cat <<EOF >> ~/.zshrc

# SHIVA 42
PATH=$PATH:${SHIVA}/${UTILS}:${SHIVA}/${TOOLS}
EOF
}

setup_shiva() {
	echo "${BLUE}Cloning Shiva...${RESET}"

	command_exists git || {
		error "git is not installed"
		exit 1
	}
	git clone --depth=1 --branch "$BRANCH" "$REMOTE" "$SHIVA" || {
			error "git clone of Shiva repo failed"
			exit 1
		}
	
	install_all
	echo
}

main() {
	setup_color

	if [ -d "$SHIVA" ]; then
		cat <<-EOF
			${YELLOW}You already have Shiva installed.${RESET}
			You'll need to remove '$SHIVA' if you want to reinstall.
		EOF
		exit 1
	fi

	setup_shiva

	printf "$BLUE"
	cat <<-"EOF"
	.     ad88888ba   88           88    	\\\  A Clang compiling tool \\\
	.    d8"     "8b  88           ""        \\\ for 42 school exercices \\\
	.    Y8,          88                   
	.    `Y8aaaaa,    88,dPPYba,   88  8b       d8  ,adPPYYba,  
	.      `"""""8b,  88P'    "8a  88  `8b     d8'  ""     `Y8  
	.            `8b  88       88  88   `8b   d8'   ,adPPPPP88  
	.    Y8a     a8P  88       88  88    `8b,d8'    88,    ,88  
	.     "Y88888P"   88       88  88      "8"      `"8bbdP"Y8     ....is now installed!
	.
	EOF
	printf "$YELLOW"
	cat <<-EOF
	.    Please look over the ~/.shiva/templates/ folder to add templates.$BLUE
	.
	.    Twitter: https://twitter.com/ZeraTron_
	.    Intra: https://profile.intra.42.fr/users/kdubois
	EOF
	printf "$RESET"
}
main "$@"
