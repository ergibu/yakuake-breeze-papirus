#! /bin/bash

grigio=$'\e[1;30m'
rosso=$'\e[1;31m'
verde=$'\e[1;32m'
giallo=$'\e[1;33m'
azzurro=$'\e[1;34m'
viola=$'\e[1;35m'
celeste=$'\e[1;36m'
bianco=$'\e[1;37m'
rcol=$'\e[m'

_YAKUAKE_D=$HOME/.local/share/yakuake
_INSTALL_D=$_YAKUAKE_D/skins
_DEP="yakuake"

function esci {
	echo ""
	echo $verde"[Finito!]"$rcol
	echo ""
	sleep 2
	exit 0
}

checkdeps() {
	local -i not_found
	for cmd; do
		command -v >&- "$cmd" || {
			let not_found++
		}
	done
	(( not_found == 0 )) || {
		echo ""
		echo $rcol"${verde}Aggiornamento cache APT"$rcol
		echo ""
		sudo apt-get -qq update
		echo $rcol"Installazione dipendenze:$giallo filezilla"$rcol
		echo ""
		sudo apt-get -yq yakuake $_DEP
		echo ""
	}
}

echo ""

if [ ! -d "$_YAKUAKE_D" ]; then
	echo -n $rcol"Crea la cartella $giallo'${_YAKUAKE_D}'"
	sudo mkdir -p "${_YAKUAKE_D}"
	echo $verde" [ok]"$rcol && sleep 1
fi

if [ ! -d "$_INSTALL_D" ]; then
	echo -n $rcol"Crea la cartella $giallo'${_INSTALL_D}'"
	sudo mkdir -p "${_INSTALL_D}"
	echo $verde" [ok]"$rcol && sleep 1
else
	echo -n $rcol"Copia i files in $giallo'${_INSTALL_D}'"
	sudo cp -Rf Breeze-Papirus "$_INSTALL_D"
	echo $verde" [ok]"$rcol && sleep 1
fi

checkdeps $_DEP
esci
