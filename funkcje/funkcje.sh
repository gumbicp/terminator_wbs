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
# funkcje instalacyjne
. ./funkcje/paczki.sh
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
### --- dialog
# Funckcja wybiera wszystkie paczki i instaluje z automatu
##
function func_M1_op1
{
$DIALOG --title " Pierwsza opcja" --clear \
        --yesno "wybrales pierwsza opcje" 10 30

case $? in
  0)
    echo "Yes chosen.";;
  1)
    echo "No chosen.";;
  255)
    echo "ESC pressed.";;
esac
}
### --- dialog
# Funkcja dla wybranej opcji 2 z Main Menu
# instaluj wybrane paczki
##
function func_M1_op2
{
    echo ":: func_M1_op2 ->> przed oknem dialog --checklist ::" >&4

    test -f tfile && rm tfile || > tfile && t_file="tfile"
   $DIALOG --backtitle "Ubuntu Lts 12.04 " --separate-output\
	--title "$paczki" --clear \
        --checklist "$CHB1_info" 20 61 5 \
        "Ubuntu"  "ubuntu-restricted-extras" ON \
        "Java7"  "openjdk-7-jdk"  off \
        "Java6"  "openjdk-6-jdk"  off \
        "Ant"    "Compiler for java"  off \
        "Dkms"    "debhelper, cdbs, dkms"  off \
        "Devscripts"  "And more to install"  off \
        "Codecs"  "libavformat-extra* libavcodec-extra*" off 2> $t_file

retval=$?

case $retval in
    0)
        for choice in `cat $t_file`; do
            #debug
            echo "f -> Wartosc = $choice" >&4
            #end debug
            if [ "$choice" = "Ubuntu" ]; then
                func_ubuntu_restricted_extras
                read -p "<enter>" enter
            elif [ "$choice" = "Java7" ]; then
                func_java7_install
                read -p "<enter>" enter
            elif [ "$choice" = "Java6" ]; then
                func_java6_install
                read -p "<enter>" enter
            fi
        done
        ;;
    1)
        echo "f --> Cancel pressed -> func_start" >&4
        func_start
        ;;
    255)
        echo "f --> ESC pressed. -> func_start" >&4
        func_start
    ;;
esac
func_start
}
### --- dialog
#   Funkcja informacyjna o programie netbeans
#
##
function func_M1_op3
{
$DIALOG --title " Trzecia opcja" --clear \
        --yesno "wybrales trzecia opcje" 10 30

case $? in
  0)
    echo "Yes chosen.";;
  1)
    echo "No chosen.";;
  255)
    echo "ESC pressed.";;
esac
}
### --- dialog
#   Funkcja sprawdza wersje javy zainstalowanej
# i alternatives dla niej
##
function func_M1_op4
{
    func_java_version
    func_start
#$DIALOG --title " Czwarta opcja" --clear \
#        --yesno "wybrales czwarta opcje" 10 30
#
#case $? in
#  0)
#    echo "Yes chosen.";;
#  1)
#    echo "No chosen.";;
#  255)
#    echo "ESC pressed.";;
#esac
}
### --- dialog
#   Funkcja otwiera okienko tak nie
# pyta czy napewno wybor jest właściwy
##
function func_M_Menu_wybor
{
    $DIALOG --title "$MYN1_tytul " --clear \
    --yesno "$MYN1_info $1" 5 35

    case $? in
        0)
            echo ":: func_M_Menu_wybor-> przed if '$1 = $M1_op1 ::" >&4
            #wszystko na raz
            if [ "$1" = "$M1_op1" ]; then
                echo "f --> in if $1 = $M1_op1" >&4
                func_M1_op1
            echo "f --> przed elif '$1 = $M1_op2 ::" >&4
            #wybrane paczki
            elif [ "$1" = "$M1_op2" ]; then
                echo "f --> in elif $1 = $M1_op2" >&4
                func_M1_op2
            echo "f --> przed elif '$1 = $M1_op3 ::" >&4
            #netbeans
            elif [ "$1" = "$M1_op3" ]; then
                echo "f --> in elif $1 = $M1_op3" >&4
                func_M1_op3
            echo "f --> przed elif '$1 = $M1_op4 ::" >&4
            #versions Java
            elif [ "$1" = "$M1_op4" ]; then
                echo "f --> in elif $1 = $M1_op4" >&4
                func_M1_op4
            fi
            ;;
        1)
            echo "f --> cancel -> func_start ...." >&4
            func_start
            ;;
        255)
            echo "f --> Esc -> func_start ...." >&4
            func_start
            ;;
    esac
    echo ":::: func_M_Menu_wybor--> end } ::::" >&4
}
### --- dialog
# Funkcja startuje Main Menu  dialog
#
##
function func_start
{
    $DIALOG --clear --title "Menu" \
	--menu "$czolowka_menu\n\n" 20 55 4 \
	"$M1_op1" "$M1_opis_op1" \
	"$M1_op2" "$M1_opis_op2" \
	"$M1_op3" "$M1_opis_op3" \
    "$M1_op4" "$M1_opis_op4" 2> $t_file

   retval=$?
   choice=`cat $t_file`

   case $retval in
       0)
         func_M_Menu_wybor $choice
	   ;;
       1)
           #cancel pressed
           echo "func_start-> cancel pressed" >&4
           func_koniec
	   ;;
       255)
           #Esc
           echo "func_start-> Esc pressed" >&4
           func_koniec
	   ;;
   esac

    func_koniec
}
###--- dialog install
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
		echo "-->f: func_sprawdz_opcje()->pentla przed 2-drugim elif czy -h = ${args[$i]}" >&4
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
# when program start running.
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
