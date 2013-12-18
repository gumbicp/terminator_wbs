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

#dla paczki dialog (grafika)
DIALOG=${DIALOG=dialog}
test -f tfile || > tfile && t_file="tfile"
trap "rm -f $t_file" 0 1 2 5 15

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
	czolowka_menu="
  Witam , masz do wyboru pełną instalacje od zera
lub doinstalowanie brakujacych pakietow."
	M1_op1="Całość"
	M1_opis_op1="Wszystkie pakiety od zera" 
	M1_op2="Wybrane"
	M1_opis_op2="Tylko wybrane pakiety"
	M1_op3="Netbeans"
	M1_opis_op3="Program IDE do programowania w java"
	M1_op4="Wersje"
	M1_opis_op4="Sprawdz wersje java"
	MYN1_info="Wybrales opcje "
	MYN1_tytul="Jesteś tego pewny ?"
	paczki="Lista paczek"
	CHB1_info="Witam, jest to radiolist box.\n\
Jeżeli jest wiecej opcji na ekranie, można ją \n\
przesuwać w dół używając klawiszy UP/DOWN lub\n\
strzałek , pierwsza litera jest tak zwanym \n\
hot key, lub 1-9 numery też działają. \n\
Naciśnij spacje aby odchaczyć opcje. \n\n\
  Które paczki potrzebujesz ?"
	pierwsza_t="Instaluj-dialog"
	druga_t="Zainstalowany"
	koniec_t="Zamknij"
	tab_menu_start=("$pierwsza_t" "$druga_t" "$koniec_t")
	dl_tms=${#tab_menu_start[@]}
#for file paczki.sh
    java_version_info="Java i Javac wersje są takie same ?!"
    yes=("T"  "Ta" "Tak" "t" "ta" "tak")
    no=("N" "Ni" "Nie" "n" "ni" "nie")
    YES_NO="<Tak/Nie>"
    ANSWER_COMPLAIN="\nTak lub Nie, prosze !\n"

# zmienne dla wersji angielskiej
elif [ "$language" = "-en" ]
then
	brak_t_op="Choose right options .. "
	bool_brak_t_op=False
	opis="

			TERMINATOR FOR PACKAGE

	Program complete missing packages for webcamstudio.
This massage you will see just for ones if you didn't,
choose option -m:

./terminator_for_wbs.sh -m

For this program purpose you have to install dialog package.
Program wont work if you dont have it installed !!!


	"
	pomoc="
	
	Options for user commands end synopsis:

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
	czolowka_menu="
   Hi, you can install all or just some of missing
packages."
# for func start and func_M_Menu_wybor
	M1_op1="All"
	M1_opis_op1="Install all from zero" 
	M1_op2="Choice"
	M1_opis_op2="Some missing packages"
	M1_op3="Netbeans"
	M1_opis_op3="Program IDE for programing in java"
	M1_op4="Version"
	M1_opis_op4="Java version , alternatives"
	MYN1_info="Your choice is "
	MYN1_tytul="Are you sure ?"
	paczki="Packages check list"
	CHB1_info="Hi, this is a radiolist box. \n\
If there are more items than can fit on the \n\
screen, the list will be scrolled. You can use the \n\
UP/DOWN arrow keys, the first letter of the choice as a \n\
hot key, or the number keys 1-9 to choose an option. \n\
Press SPACE to toggle an option on/off. \n\n\
  Which packages you need ?"
	pierwsza_t="Install-dialog"
	druga_t="Installed"
	koniec_t="Close"
	tab_menu_start=("$pierwsza_t" "$druga_t" "$koniec_t")
	dl_tms=${#tab_menu_start[@]}

#for file paczki.sh
    java_version_info="Java and Javac version are the same ?!"
    yes=("Y"  "Ye" "Yes"  "y" "ye" "yes")
    no=("N" "No" "n" "no" "nope" "nop")
    YES_NO="<Yes/No>"
    ANSWER_COMPLAIN="\nYes or No, please !\n"
fi
