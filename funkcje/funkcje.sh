#!/bin/bash
#########################################################################
#   TERMINATOR PAKIETOWY   dla WBS                                      #
#   @author gumbicp                                                     #
#   Copyright 2013 gumbicp <pracacp@gmail.com>                          #
#																		#
#   funkcje.sh                                                          #
#             Plik z funkcjami dla terminator_for_wbs.sh                #
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
. ./zmienne/zmienne.sh

#
# Funkcja kończy program
# - czyszczenie ekranu
# - wypisanie wiadomosci
# - exit 0
#
function end
{
	clear
    echo
    echo
    echo -e "\t\tI hope so there is not error in this script, but ..."
    echo -e "\tIf You find it please let me know  --> pracacp@gmail.com"
    echo -e "\tor issues  https://github.com/gumbicp/terminator_wbs.git"
    echo
    echo -e "\t\tThx in advance gumbicp"
    echo
    echo
    exit 0
}

function koniec
{
	if [ "$language" = "-en" ]
	then
		end
	fi
    clear
    echo
    echo
    echo -e "\t\tMam na dzieję że nie było błędów w działaniu programu."
    echo -e "\tJeżeli  tak  proszę  dać  mi  znać  na  --> pracacp@gmail.com"
    echo -e "\tLub w issues na https://github.com/gumbicp/terminator_wbs.git"
    echo
    echo -e "\t\tPozd. gumbicp"
    echo
    echo
    exit 0
}
function func_help
{
	clear
	echo "$pomoc"
	read -p "<enter> : ..."
	koniec
}

# 
# Funkcja startuje dialog
#
function func_start
{
    dialog --checklist "Odznacz pakiety do instalacji \n odznacz - spacja\n dół/góra - strzałki\n tab,enter " 15 35 5\
    1 "Java 7" off\
    2 "Java 6" off\
    3 Netbeans off\
    4 "Dodatki ubuntu" off\

    koniec
}
#
# Funckja instaluje pakiet dialog
# i startuje program
# @see func_start
#
function func_install_dialog
{
    sudo apt-get update
    sudo apt-get install dialog
    func_start
}
function pentla_textowa
{
	while [ True ]
    do
	clear
	if [ $bool_brak_t_op = True ]
	then
	    echo
	    echo -e "\t\t $brak_t_op"
	    echo
	    bool_brak_t_op=False
	fi
	echo "$opis"
	select option in ${tab_menu_start[@]}
	do
	    case $option in
		"${tab_menu_start[0]}") func_install_dialog ;;
		"${tab_menu_start[1]}") func_start ;;
		"${tab_menu_start[$dl_tms -1]}") koniec ;;
		    *) bool_brak_t_op=True
	    esac
	    break
	done
	echo -e "\n"
    done
}

function sprawdz_opcje
{
	local arg1=$1
	local arg2=$2
	local arg3=$3
	local args=("$arg1" "$arg2" "$arg3")
	local len=${#args[*]}
	
	for i in `seq 0 $[len -1]`
	do
		if [ "${args[$i]}" = '-m' ]
		then
			func_start
		elif [ "${args[$i]}" = '-h' ]
		then
			func_help
		fi
	done
	pentla_textowa
}
