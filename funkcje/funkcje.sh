#!/bin/bash
#########################################################################
#																		#
#   TERMINATOR PAKIETOWY   dla WBS                                      #
#																		#
#   			                                                        #
#   Copyright 2013 gumbicp <pracacp@gmail.com>                          #
#																		#
#   funkcje.sh                                                          #
#             Plik z funkcjami dla terminator_for_wbs.sh                #
#																		#
#             File with functions for terminator_for_wbs.sh             #
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

#@TODO: dopisac opisy funkci w 2 jezkach 
#@TOTO:	dopisac funkcje dialogu 

#** IMPORTS -VARIABLES **#
. ./zmienne/zmienne.sh

###
# Function ends program
# - clear screen
# - end message
# - exit 0
#
#	v1.0
##
function func_end
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
###
# Funkcja kończy program
# - sprawdza opcje jezykowe --> ["-en" == true] see->end() 
# - czyszczenie ekranu
# - wypisanie wiadomosci koncowej
# - exit 0
#
#	v1.0
##
function func_koniec
{
	if [ "$language" = "-en" ]
	then
		func_end
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
###
#	Funkcja opcje wywolan pliku sh:
#   -czysci ekran 
#   -wswietla opcje -h pomoc
#	-konczy program
#----------------------------------
#	Function -h option
#	-clear screen
#	-write help on screen
#	-ends program
#
#	@see koniec() 
#	v1.0
##
function func_help
{
	clear
	echo "$pomoc"
	read -p "<enter> : ..."
	func_koniec
}

### 
# Funkcja startuje dialog
#
##
function func_start
{
    dialog --checklist "Odznacz pakiety do instalacji \n odznacz - spacja\n dół/góra - strzałki\n tab,enter " 15 35 5\
    1 "Java 7" off\
    2 "Java 6" off\
    3 Netbeans off\
    4 "Dodatki ubuntu" off\

    func_koniec
}
###
# Funckja instaluje pakiet dialog
# i startuje program
#
#--------------------------------
# Function install package dialog
# and start program
#
# @see func_start
# v1.0
##
function func_install_dialog
{
    sudo apt-get update
    sudo apt-get install dialog
    func_start
}
###
#	Funkcja menu tekstowego,
#	./..sh bez parametrow
#---------------------------
#	Function text menu,
#	./..sh without parametr 
#	
#	v.10
#
##
function func_pentla_textowa
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
		"${tab_menu_start[$dl_tms -1]}") func_koniec ;;
		    *) bool_brak_t_op=True
	    esac
	    break
	done
	echo -e "\n"
    done
}
###
#	Funkcja testuje parametry wywolania ..sh [-en][-m][-h]
##
function func_sprawdz_opcje
{
	#----------- debug
	echo ":: --------------------------------------------- ::" >&4
	echo ":: plik funkcje.sh -- funkcja -> sprawdz_opcje()   ::" >&4
	#----------- end debug
	local arg1=$1
	local arg2=$2
	local arg3=$3
	local args=("$arg1" "$arg2" "$arg3")
	local len=${#args[*]}
	#----------- debug
	echo "-->f: func_sprawdz_opcje() -> args 	= $args " >&4
	echo "-->f: func_sprawdz_opcje() -> len 	= $len " >&4
	echo "-->f: func_sprawdz_opcje() -> przed pentla for " >&4
	#----------- end debug
	for i in `seq 0 $[len -1]`
	do
		echo "-->f: func_sprawdz_opcje()->pentla przed 1-szym if czy -m = ${args[$i]}" >&4
		if [ "${args[$i]}" = '-m' ]
		then
			echo "-->f: func_sprawdz_opcje() -> f:func_start() " >&4
			func_start
		echo "-->f: func_sprawdz_opcje()->pentla przed 2-grugim elif czy -h = ${args[$i]}" >&4
		elif [ "${args[$i]}" = '-h' ]
		then
			echo "-->f: func_sprawdz_opcje() -> f:func_help() " >&4
			func_help
		fi
	done
	echo "-->f: func_sprawdz_opcje() -> f:func_pentla_textowa() " >&4
	echo ":: --------------------------------------------- ::" >&4
	func_pentla_textowa
}
###
# Funkcja dopisuje tylko czolowke do pliku 
#	debug_log.txt
#-----------------------------------------
# Function just for header in file 
# 	debug_log.txt
# v1.0
##
function func_create_file_debug
{
	echo ":: ------------------------------------------ ::" >&4
	echo ":: ------------------------------------------ ::" >&4
	echo ":: ------------ DEBUG LOG ------------------- ::" >&4
	echo ":: ------------------------------------------ ::" >&4
	echo ":: ------------------------------------------ ::" >&4
}
###
# Function just for header in file err_log.txt
# v1.0
##
function func_create_file_err
{
	echo ":: ------------------------------------------ ::" >&3
	echo ":: ------------------------------------------ ::" >&3
	echo ":: ------------ ERROR LOG ------------------- ::" >&3
	echo ":: ------------------------------------------ ::" >&3
	echo ":: ------------------------------------------ ::" >&3
}
###
# Function for remove old logs 
# when program start runnig.
# v1.0
##
function func_rm_logs
{
	if [ -e "$1" ]
	then
		rm -v "$1"
	fi
		
	if [ -e "$2" ]
	then
		rm -v "$2"
	fi
}
