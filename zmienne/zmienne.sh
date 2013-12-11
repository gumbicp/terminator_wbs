#!/bin/bash
#########################################################################
#   TERMINATOR PAKIETOWY   dla WBS                                      #
#   @author gumbicp                                                     #
#   Copyright 2013 gumbicp <pracacp@gmail.com>                          #
#																		#
#   zmienne.sh                                                          #
#             Plik ze zmiennymi dla terminator_for_wbs.sh               #
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

#pliki dla logow  bledow i do debugowania

err_log='err_log.txt'
debug_log="debug_log.txt"

#-----------------------------------------------
opcje=$#
# dla menu tekstowego wersja polska
if [ "$language" = "-pl" ]
then
	brak_t_op="Nie ma takiej opcji .. "
	bool_brak_t_op=False
	opis="

			TERMINATOR PAKIETOWY

	Program do instalacji róźnych pakietów potrzebnych do webcamstudio.
Tą wiadomość zobaczysz tylko przy pierwszym uruchomieniu  tego skryptu,
aby to menu pomijać uruchom skrypt z opcja :

./terminator_for_wbs.sh -m

Aby program wystartował musi być doinstalowany pakiet dialog do obsługi
okienek w terminalu.
Przy braku tego pakietu programik nie wystartuje !!!


	"
	pomoc="
	
	Opcje wywolania programu i składnia:

./terminator_for_wbs.sh [-h][-m][-en]

-h	: opis komend wywołania i konczy program od razu
-en	: wersja programu w języku angielskim
-m 	: opcja startu programu gdy już mamy pakiet dialog
		zainstalowany pomija menu tekstowe

AUTOR
	gumbicp
	
VERSION
	v 1.0.0 na linux ubuntu dla wbs
"
	pierwsza_t="Instaluj-dialog"
	druga_t="Zainstalowany"
	koniec_t="Zamknij"
	tab_menu_start=("$pierwsza_t" "$druga_t" "$koniec_t")
	dl_tms=${#tab_menu_start[@]}
	
# zmienne dla wersji angielskiej
elif [ "$language" = "-en" ]
then
	brak_t_op="Choose right options .. "
	bool_brak_t_op=False
	opis="

			TERMINATOR FOR PACKAGE

	Program complete missing packages for webcamstudio.
This massage you will see just for ones if you didnt,
choose option -m:

./terminator_for_wbs.sh -m

For this program purpose you have to install dialog package.
Program wont work if you dont have it installed !!!


	"
	pomoc="
	
	Options for user comands end synopsis:

./terminator_for_wbs.sh [-h][-m][-en]

-h	: this manual and end script 
-en	: english version 
-m 	: starts program without menu text if you have installed
		dialog package 

AUTOR
	gumbicp
	
VERSION
	v 1.0.0 na linux ubuntu for wbs
"
	pierwsza_t="Install-dialog"
	druga_t="Installed"
	koniec_t="Close"
	tab_menu_start=("$pierwsza_t" "$druga_t" "$koniec_t")
	dl_tms=${#tab_menu_start[@]}
fi
