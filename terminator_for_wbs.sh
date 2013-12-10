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
else
    func_start
fi

#end script
