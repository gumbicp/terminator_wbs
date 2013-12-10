#!/bin/bash
#########################################################################
#   TERMINATOR PAKIETOWY   dla WBS                                      #
#   @author gumbicp                                                     #
#   Copyright 2013 gumbicp <pracacp@gmail.com>                          #
#                                                                       #
#        Program do instalacji róźnych pakietów potrzebnych do          #
#      webcamstudio. Aby menu pomijać uruchom skrypt z opcja :          #
#                                                                       #
#    ./terminator.sh -m                                                 #
#                                                                       #
#    Aby program wystartował musi być doinstalowany pakiet dialog       #
#   do obsługi okienek w terminalu.                                     #
#   Przy braku tego pakietu programik nie wystartuje !!                 #
#                                                                       #
#                                                                       #
#                                                                       #
# This program is free software; you can redistribute it and/or modify  #
# it under the terms of the GNU General Public License as published by  #
# the Free Software Foundation; either version 2 of the License, or     #
# (at your option) any later version.                                   #
#                                                                       #
# This program is distributed in the hope that it will be useful,       #
# but WITHOUT ANY WARRANTY; without even the implied warranty of        #
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the         #
# GNU General Public License for more details.                          #
#                                                                       #
# You should have received a copy of the GNU General Public License     #
# along with this program; if not, write to the Free Software           #
# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,            #
# MA 02110-1301, USA.                                                   #
#                                                                       #
#########################################################################

#
# Funkcja ustawia wersje jezykową programu np -en po angielsku
# bez parametru wersja polska
#
function en_pl
{
	local arg1=$1
	local arg2=$2
	local arg3=$3
	local args=("$arg1" "$arg2" "$arg3")
	local len=${#args[*]}

	language='-pl'
	
	for i in `seq 0 $[len -1]`
	do
		if [ "${args[$i]}" = "-en" ]
		then
			language="-en"
		fi
	done
}
# ustaw wersje jezykowa
en_pl $@
#--------- zmienne globalne ------------------
. ./zmienne/zmienne.sh
# ---------------- end zmienne ---------------

# --------------------------------------------
# ---------------- funkcje -------------------
# --------------------------------------------
. ./funkcje/funkcje.sh
# ---------------- end funkcje ---------------

# --------------------------------------------
# ---------------- Start skryptu  ------------
# --------------------------------------------

#
# glówny warunek rozruchowy programu
# jezeli brak opcji to startuje opis i menu tekstowe
#TODO: rożne opcje rozruchowe jeżeli bedą potrzebne
#
if [ $opcje = 0 ]
then
    pentla_textowa
elif [ $opcje -ge 1 ]
then
	sprawdz_opcje $@

else
    func_start
fi

#end script
