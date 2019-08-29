#!/bin/sh
if [ $# -eq 0 ] ; then
	echo "No target directory supplied"
	exit
fi
_pathname=$1
if [ ! -d Toolbox ] ; then
	echo "No existing Toolbox detected"
	mkdir $1/Toolbox
	curl -fsSL https://github.com/ZeraTron/42_workspace/tree/master/Toolbox/tools.tar
	tar -xf tools.tar
	echo "Updated Toolbox"
fi
if [ $1 = "." ] ; then
	echo "Install in current working directory..."
	export _pathname=""
fi
if [ $2 = "tmp" ] ; then
	echo "Temporary Toolbox setup"
	export PATH="$PATH:$HOME/$_pathname/Toolbox"
	echo $PATH
	exit
fi
if [ grep -q echo "export PATH=$PATH':$HOME/$_pathname/Toolbox'" ~/.zshrc ] ; then
	echo 'Toolbox already installed !'
	exit
fi
echo "export PATH=$PATH':$HOME/$1/Toolbox'" >> ~/.zshrc
echo "[100%] Toolbox installed !"
